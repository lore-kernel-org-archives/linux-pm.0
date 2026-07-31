Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24853C5536;
	Fri, 31 Jul 2026 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490990; cv=none; b=SXbBJa8yZT9favCa9HZ+uwMWAvwr8jXvdq14K/BBWlXu95WjBu+toFzilN5HANLNJFNJAJzRQni9CUdQspOBr+xsE7y6NIHfmxdM91emTiRGwrGRuHr++Y9aKRvO26aUs9azXUpN1cioOKcpD9/7nCprBfRdmkmOgcSENmKp2Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490990; c=relaxed/simple;
	bh=wSASVYFyKzRCwfaj2civb/DEQuZMXHHbWp85GRhW5K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/TnsVJSd9itckIbDXNN0quq4EXBF+ONuGhP+YneAi3DaCOmFJ9Dgv9s14bpqjDmtdtUUf4k9g2WYK4UbHrlD5JPMksUoewvhUWLhmrHtJo/bAzaXKEaDdbZN2FSDnFyTAkeMYYNCQgUiYDVIsUmmOM3AzAwNQlQRlPkv7sU/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.205])
	by gateway (Coremail) with SMTP id _____8DxfZsmbmxqmiwJAA--.7592S3;
	Fri, 31 Jul 2026 17:43:02 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.205])
	by front1 (Coremail) with SMTP id qMiowJDxu8QPbmxqHvYeAA--.48910S5;
	Fri, 31 Jul 2026 17:42:53 +0800 (CST)
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
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 3/5] dt-bindings: mfd: syscon: Allow syscon compatible for Loongson-2K0300 chip id
Date: Fri, 31 Jul 2026 17:42:19 +0800
Message-ID: <0fbb8d766b6ed33bf4ae9b066eac174f55ae5b56.1785480242.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxu8QPbmxqHvYeAA--.48910S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEFCGpsKC8FAgAAsI
X-Coremail-Antispam: 1Uk129KBj9xXoW7GF1xCrW5ur4rCF1fXrykXrc_yoWktwb_u3
	Wxtr1rAa9xAFy0g390vF48GrW3XwsIkrnrCrnrG3WxG340qas5Xr97trWYyryUuF45urnx
	Aan7W3yYv3Z7GosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUUUU=

The Loongson-2K0300 SoC exposes its chip ID registers through a syscon
interface. Add the specific compatible `loongson,ls2k0300-chipid-syscon`
to the allowed list of syscon bindings so that it can be referenced from
the thermal node via a phandle.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index e22867088063..18eb9defec8c 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -76,6 +76,7 @@ select:
           - hpe,gxp-sysreg
           - loongson,ls1b-syscon
           - loongson,ls1c-syscon
+          - loongson,ls2k0300-chipid-syscon
           - lsi,axxia-syscon
           - marvell,armada-3700-cpu-misc
           - marvell,armada-3700-nb-pm
@@ -189,6 +190,7 @@ properties:
               - hpe,gxp-sysreg
               - loongson,ls1b-syscon
               - loongson,ls1c-syscon
+              - loongson,ls2k0300-chipid-syscon
               - lsi,axxia-syscon
               - marvell,armada-3700-cpu-misc
               - marvell,armada-3700-nb-pm
-- 
2.52.0

