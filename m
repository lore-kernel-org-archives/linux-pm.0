Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7640310651;
	Fri,  3 Apr 2026 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775212491; cv=none; b=YbkEtdvnMXtz7umsMSkdnUsNg72fkAE9TiUpyPR1PlftbjiGBEqW3+X6evxfLHrhqY/9nufy3k+Kh9WDbYHi3rUHcZPyzCvlNruAe2+cN38POyrueQublI5tnwkSoz2PJlZm8nCE/xujQYsIiDY77uBdfSk+xw0Tl/4Sv5y8onM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775212491; c=relaxed/simple;
	bh=3NFeOsyY0UGtptXKycEdwjVY7uJYeTTny9+Lsg73KHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VuXEAbH08WKD0tFPFy0t6klOgIbE5KNkGLsjHFKMie794VzZF5euBSB014X1XloWEHZ/B0QMsteF+yTlqn9N+KU0XuKx2Q+ISpQhhvwaNIgrbhOJ8BeCV0Zqd3cMEc1XPGbLS5nlI8XemNHzVD1szyz0cv9BHA9dKJRBuJo0dIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowAB3HmrDl89pcuQPDA--.2057S2;
	Fri, 03 Apr 2026 18:34:43 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Fri, 03 Apr 2026 18:34:29 +0800
Subject: [PATCH] dt-bindings: opp-v2: Fix example 3 CPU reg value
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-dt-bindings-opp-v2-hex-cpu-reg-v1-1-38a4968ab515@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIALSXz2kC/yXNMQ7CMAxA0atUnrGUusDAVRADjk1qhjSK26pS1
 bsTYHzL/zu4VlOHW7dD1dXcptzQnzqI4zMnRZNmoEDXcA4DyoxsWSwnx6kUXAlH3TCWBasmJCF
 hjYG5v0CLlKov236D++NvX/itcf5W4Tg+J8z8PYIAAAA=
X-Change-ID: 20260403-dt-bindings-opp-v2-hex-cpu-reg-2d2dbec0bb15
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.15.0
X-CM-TRANSID:qwCowAB3HmrDl89pcuQPDA--.2057S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw15Cr4UJw17Gw45Gw47CFg_yoW8Kry8pF
	4Ikay3Ja1Yqr45W3Z0q3W0gr1fWFykAF4jkFnYvry8tas8XF9YvrWayF1UGFyUWF1xXFZx
	ZF43GrWrJwnrAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvttUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Example 3 is a dual-cluster example, meaning that the CPU nodes should
have reg values 0x0, 0x1, 0x100, 0x101. The example incorrectly uses
decimal 0, 1, 100, 101 instead, which seems unintended. Use the correct
hexadecimal values.

Even though the value doesn't change for the first two CPUs, 0 and 1 in
example 3 are changed to 0x0 and 0x1 respectively for consistency. Other
examples all have reg less than 10, so they have not been changed.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Found while trying to figure out if cpu@* unit addresses are supposed to
be decimal or hexadecimal. This is AFAICT the only place in-tree where
an arm/arm64 DTS uses multi-digit decimal. See also:

- https://lore.kernel.org/devicetree-spec/00ddad5a-02f5-474e-af9c-11ce7716ddfc@iscas.ac.cn/
- https://github.com/devicetree-org/devicetree-specification/issues/86
---
 Documentation/devicetree/bindings/opp/opp-v2.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2.yaml b/Documentation/devicetree/bindings/opp/opp-v2.yaml
index 6972d76233aa..10000a758572 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2.yaml
@@ -172,7 +172,7 @@ examples:
         cpu@0 {
             compatible = "arm,cortex-a7";
             device_type = "cpu";
-            reg = <0>;
+            reg = <0x0>;
             next-level-cache = <&L2>;
             clocks = <&clk_controller 0>;
             clock-names = "cpu";
@@ -183,7 +183,7 @@ examples:
         cpu@1 {
             compatible = "arm,cortex-a7";
             device_type = "cpu";
-            reg = <1>;
+            reg = <0x1>;
             next-level-cache = <&L2>;
             clocks = <&clk_controller 0>;
             clock-names = "cpu";
@@ -194,7 +194,7 @@ examples:
         cpu@100 {
             compatible = "arm,cortex-a15";
             device_type = "cpu";
-            reg = <100>;
+            reg = <0x100>;
             next-level-cache = <&L2>;
             clocks = <&clk_controller 1>;
             clock-names = "cpu";
@@ -205,7 +205,7 @@ examples:
         cpu@101 {
             compatible = "arm,cortex-a15";
             device_type = "cpu";
-            reg = <101>;
+            reg = <0x101>;
             next-level-cache = <&L2>;
             clocks = <&clk_controller 1>;
             clock-names = "cpu";

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260403-dt-bindings-opp-v2-hex-cpu-reg-2d2dbec0bb15

Best regards,
--  
Vivian "dramforever" Wang

