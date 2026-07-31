Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD423A1CF8;
	Fri, 31 Jul 2026 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491004; cv=none; b=JCpKwWCQuJukQ24MlrBE53PzniULUTMeINn5LohjluMbVOj0qyJIWpca2u+uJa8OfhzArRUy1AclwfP31eHQSLFa5eKuxfXz52nOuPdy4ry/AMgabMV+bXAX5ya0V+RolO3vWkHk1Izb3inFerycnyhz3JNMt5zk0SRtX7DsCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491004; c=relaxed/simple;
	bh=vyXy2/t7jaDleoFkv+LZWODC81nU2o6HGG5Z/D9vkV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoROw+8+iZVIzVvwkDaMHg0CWHmbSE/FHvXSaNev6I9kJKMVTbDH6BMah2r+TEjPQ8cmDi5rLMNmxkqUTSioG7GPaHjCWFqMbPqxrDiFQAHbJ9ZvpiFGRIBNZZtfD9LyzQscA8AqnGEddY61gTy5gQzuPle/V5VcrKuhe6KO0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.205])
	by gateway (Coremail) with SMTP id _____8Cxg+g5bmxqrCwJAA--.7786S3;
	Fri, 31 Jul 2026 17:43:21 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.205])
	by front1 (Coremail) with SMTP id qMiowJDxDcc1bmxqRfYeAA--.34836S2;
	Fri, 31 Jul 2026 17:43:18 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Lee Jones <lee@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 4/5] dt-bindings: thermal: loongson,ls2k-thermal: Add compatible for Loongson-2K0300
Date: Fri, 31 Jul 2026 17:43:10 +0800
Message-ID: <5c6f32c841d34a9f370b5a0981a71cb23bc6e62a.1785480242.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1785480242.git.zhoubinbin@loongson.cn>
References: <cover.1785480242.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxDcc1bmxqRfYeAA--.34836S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEFCGpsKC8FBAAAsO
X-Coremail-Antispam: 1Uk129KBj93XoWxCr45Gw43Gr4fWF4rXrW7KFX_yoW5CryDpF
	sxCw48Gr1kKF17Z398tFy8CanYvF92yasrurs7Wr13trs8K3yaq3y3K3WYvayfur10qFy7
	uryv9rWUCF1DCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsDDJDUUUU

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

