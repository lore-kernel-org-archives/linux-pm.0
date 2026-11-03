Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690730;
	b=4ySV1lnveL1wQefahMydrz3zIRlWnZ1PcBrN++OQwbsR4Rx7j1sPJsFqzt1KW5I0m11h
	 nYssajqqFgZ0WXYju6RkMvbLlejZBX0i0r6h8q4STdDiCuSvwoNeu87cO12TPUXckYsNk
	 UOiiYBNn1Mp2uwRa5xRQ4lck8aQpm3TSCNurfSUnz+vr/K7n4qrTzXgunDxjpTTY8if2n
	 Ya2whE0zhX/jk6n5ng2CaSUl0XMyXnkEJQI7my6NdLM5mOMt+173JzCLDbBEnwD7q3j04
	 TuIEU+Lyv9EajjZp20d9v5sMsGL4gAhA2cU+hsQ0S9DlAsgHcxUCNuG0qzXZ91+7aVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690730;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=G1j5rMKnJ6ihVq5uHJzfwFefjl3D9s3JCtiCZjnJzRU=;
	b=RRcQKToJmPbOIQJIIsRdEgca5AO/A8GvBPNKt2ny1PZnEuAc0nif1yT+Jnnafy11ZEMy
	 jMfXeJ0xcFj7Cx9sw5xztnZ9gKv8+w+1mI813l5S5PQ1SSFdxQhT0/NzCXhk8K55oqQyM
	 3gOETZ3+NY83ZpzCFgDjnHEsesdRsppgxPZF7eVwqHw8oOh7WQ1moFq9JnWMBleIK1pLR
	 Kqn1GSC96QVXPF+raABss4b5grZDr0Ure5NSXfWiFg77e16blgHmgplePRnfmzjz2LOHT
	 +gSJ4VtrnbmkTjYDZOIfFx5cns/E5t3p4M/+GGq8k+J2ZUBb4TSVNTMSb+G9UeZLFOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB6D606A332;
	Tue,  3 Nov 2026 07:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EB6D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8CxfdJnjOlqMN4bAA--.15176S3;
	Tue, 03 Nov 2026 15:25:27 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJBx5cxijOlq7xUyAA--.10875S4;
	Tue, 03 Nov 2026 15:25:25 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 6/7] dt-bindings: thermal: loongson,ls2k-thermal: Add compatible for Loongson-2K0300
Date: Tue,  3 Nov 2026 15:25:15 +0800
Message-ID: <42000d97b3e8429b732aa113d6b08c786fe2e339.1793690276.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793690276.git.zhoubinbin@loongson.cn>
References: <cover.1793690276.git.zhoubinbin@loongson.cn>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx5cxijOlq7xUyAA--.10875S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGrpUP0D2AAAs+
X-Coremail-Antispam: 1Uk129KBj93XoWxCr45Gw43Gr4fWF4rXrW7KFX_yoW5CryDpF
	sxCw48Gr1kKF17Z398tFy8CanYvF92yasrurs7Wr13trs8K3yaq3y3K3WYvayfur10qFy7
	uryv9rWUCF1DCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1q6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6rWY6Fy7McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1PCzJUUUUU==

Add a new compatible string `loongson,ls2k0300-thermal` for the thermal
sensor found on the Loongson-2K0300 SoC.

The hardware differs from existing SoCs in that it requires a phandle to
a syscon node that provides the CHIP ID register, used as a compensation
source in the temperature calculation.

Update the binding to make `loongson,chipid` required for this new
compatible, and clarify the register region requirements for each
variant.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../thermal/loongson,ls2k-thermal.yaml        | 73 ++++++++++++++-----
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
index 79e691b08341..d312e27737a2 100644
--- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
@@ -10,13 +10,11 @@ maintainers:
   - zhanghongchen <zhanghongchen@loongson.cn>
   - Yinbo Zhu <zhuyinbo@loongson.cn>
 
-allOf:
-  - $ref: /schemas/thermal/thermal-sensor.yaml#
-
 properties:
   compatible:
     oneOf:
       - enum:
+          - loongson,ls2k0300-thermal
           - loongson,ls2k1000-thermal
           - loongson,ls2k2000-thermal
       - items:
@@ -34,28 +32,56 @@ properties:
   '#thermal-sensor-cells':
     const: 1
 
+  loongson,chipid:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon with the Loongson-2K0300 CHIP ID.
+
 required:
   - compatible
   - reg
   - interrupts
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - loongson,ls2k2000-thermal
+allOf:
+  - $ref: /schemas/thermal/thermal-sensor.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: loongson,ls2k0300-thermal
+    then:
+      properties:
+        reg:
+          items:
+            - description: Thermal base register region
+      required:
+        - loongson,chipid
 
-then:
-  properties:
-    reg:
-      minItems: 2
-      maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: loongson,ls2k1000-thermal
+    then:
+      properties:
+        loongson,chipid: false
+        reg:
+          items:
+            - description: Thermal base register region
 
-else:
-  properties:
-    reg:
-      maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: loongson,ls2k2000-thermal
+    then:
+      properties:
+        loongson,chipid: false
+        reg:
+          items:
+            - description: Thermal base register region
+            - description: Thermal data output register region
 
 unevaluatedProperties: false
 
@@ -69,3 +95,14 @@ examples:
         interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
         #thermal-sensor-cells = <1>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    thermal-sensor@16001500 {
+       compatible = "loongson,ls2k0300-thermal";
+       reg = <0x16001500 0x30>;
+       interrupt-parent = <&liointc1>;
+       interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+       loongson,chipid = <&chipid>;
+       #thermal-sensor-cells = <1>;
+    };
-- 
2.52.0

