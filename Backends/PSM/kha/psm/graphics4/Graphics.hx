package kha.psm.graphics4;

import kha.Blob;
import kha.graphics4.BlendingOperation;
import kha.graphics4.CompareMode;
import kha.graphics4.CubeMap;
import kha.graphics4.CullMode;
import kha.graphics4.FragmentShader;
import kha.graphics4.IndexBuffer;
import kha.graphics4.MipMapFilter;
import kha.graphics4.Program;
import kha.graphics4.StencilAction;
import kha.graphics4.TextureAddressing;
import kha.graphics4.TexDir;
import kha.graphics4.TextureFilter;
import kha.graphics4.TextureFormat;
import kha.graphics4.Usage;
import kha.graphics4.VertexBuffer;
import kha.graphics4.VertexShader;
import kha.math.Matrix4;
import kha.math.Vector2;
import kha.math.Vector3;
import kha.math.Vector4;
import kha.Rectangle;
import sce.playstation.core.graphics.DrawMode;
import sce.playstation.core.graphics.GraphicsContext;

class Graphics implements kha.graphics4.Graphics {
	private var context: GraphicsContext;
	private var indexBuffer: IndexBuffer;
	private var vertexBuffer: VertexBuffer;
	private var program: Program;

	public function new() {
		context = new GraphicsContext();
	}
	
	public function init(?backbufferFormat: TextureFormat, antiAliasingSamples: Int = 1): Void {
		
	}
	
	public function vsynced(): Bool {
		return true;
	}
	
	public function refreshRate(): Int {
		return 60;
	}
	
	public function clear(?color: Color, ?depth: Float, ?stencil: Int): Void {
		
	}
	
	public function setCullMode(mode: CullMode): Void {
		
	}
	
	public function setDepthMode(write: Bool, mode: CompareMode): Void {
		
	}
	
	public function createCubeMap(size: Int, format: TextureFormat, usage: Usage, canRead: Bool = false): CubeMap {
		return null;
	}
		
	public function setStencilParameters(compareMode: CompareMode, bothPass: StencilAction, depthFail: StencilAction, stencilFail: StencilAction, referenceValue: Int, readMask: Int = 0xff, writeMask: Int = 0xff): Void {
		
	}

	public function setScissor(rect: Rectangle): Void {
		
	}
	
	public function setTextureParameters(texunit: kha.graphics4.TextureUnit, uAddressing: TextureAddressing, vAddressing: TextureAddressing, minificationFilter: TextureFilter, magnificationFilter: TextureFilter, mipmapFilter: MipMapFilter): Void {
		
	}
	
	public function setBlendingMode(source: BlendingOperation, destination: BlendingOperation): Void {
		
	}
	
	public function setVertexBuffer(vertexBuffer: kha.graphics4.VertexBuffer): Void {
		this.vertexBuffer = vertexBuffer;
	}
	
	public function setIndexBuffer(indexBuffer: kha.graphics4.IndexBuffer): Void {
		this.indexBuffer = indexBuffer;
	}
	
	public function setProgram(program: kha.graphics4.Program): Void {
		this.program = program;
		context.SetShaderProgram(program.program);
	}
	
	public function maxTextureSize(): Int {
		return 2048;
	}
	
	public function supportsNonPow2Textures(): Bool {
		return false;
	}
	
	public function setTexture(unit: kha.graphics4.TextureUnit, texture: kha.Image): Void {
		if (texture != null) {
			context.SetTexture(0, texture.texture);
		}
	}
		
	public function drawIndexedVertices(start: Int = 0, count: Int = -1): Void {
		vertexBuffer.setIndices(indexBuffer);
		context.SetVertexBuffer(0, vertexBuffer.buffer);
		context.DrawArrays(DrawMode.Triangles, start, count);
	}
	
	public function createVertexShader(source: Blob): kha.graphics4.VertexShader {
		return new VertexShader(source);
	}

	public function createFragmentShader(source: Blob): kha.graphics4.FragmentShader {
		return new FragmentShader(source);
	}
	
	public function setBool(location: kha.graphics4.ConstantLocation, value: Bool): Void {
		
	}
	
	public function setInt(location: kha.graphics4.ConstantLocation, value: Int): Void {
		
	}

	public function setFloat(location: kha.graphics4.ConstantLocation, value: Float): Void {
		
	}
	
	public function setFloat2(location: kha.graphics4.ConstantLocation, value1: Float, value2: Float): Void {
		
	}
	
	public function setFloat3(location: kha.graphics4.ConstantLocation, value1: Float, value2: Float, value3: Float): Void {
		
	}
	
	public function setFloat4(location: kha.graphics4.ConstantLocation, value1: Float, value2: Float, value3: Float, value4: Float): Void {
		
	}
	
	public function setVector2(location: kha.graphics4.ConstantLocation, value: Vector2): Void {
		
	}
	
	public function setVector3(location: kha.graphics4.ConstantLocation, value: Vector3): Void {
		
	}
	
	public function setVector4(location: kha.graphics4.ConstantLocation, value: Vector4): Void {
		
	}
	
	@:functionCode('
		var m = new Sce.PlayStation.Core.Matrix4(
			(float)matrix.get(0, 0), (float)matrix.get(1, 0), (float)matrix.get(2, 0), (float)matrix.get(3, 0),
			(float)matrix.get(0, 1), (float)matrix.get(1, 1), (float)matrix.get(2, 1), (float)matrix.get(3, 1),
			(float)matrix.get(0, 2), (float)matrix.get(1, 2), (float)matrix.get(2, 2), (float)matrix.get(3, 2),
			(float)matrix.get(0, 3), (float)matrix.get(1, 3), (float)matrix.get(2, 3), (float)matrix.get(3, 3)
			);
		program.program.SetUniformValue(location.location, ref m);
	')
	private function setMatrix2(location: kha.psm.graphics4.ConstantLocation, matrix: Matrix4): Void {
		
	}
	
	public function setMatrix(location: kha.graphics4.ConstantLocation, matrix: Matrix4): Void {
		setMatrix2(cast location, matrix);
	}
	
	public function setFloats(location: kha.graphics4.ConstantLocation, values: Array<Float>): Void {
		
	}
		
	public function renderTargetsInvertedY(): Bool {
		return false;
	}
	
	public function begin(): Void {
		
	}
	
	public function end(): Void {
		context.SwapBuffers();
	}
}
