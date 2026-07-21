Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE52D9EDB;
	Tue, 21 Jul 2026 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636720; cv=none; b=frganb8uG4tUvpDymmSuG7/gZTRidn1BW8DGpY7G6ZcMwr8zXfte3pMbXC15LXSvXFH4h2r2ZaQRtyxPyqUFqemELyaUK55XhieGfxGKrQS+LymCHH5gKXKCLGebkLq/8c6IMyF6NGDC5Ou2tLyPpcYwM/S9Z8xCbn0zTE59HvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636720; c=relaxed/simple;
	bh=ZUeVQHklf0SxxCO21tasS0zXAODkPRuTw5sVOy+hkjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gflOeR2cnCS1287kKAN12Mv6L+IxdCBGquoE1HnkUKZ5UOwDogW0OuMKbENEjdZ6We1OQRuyauIClV0LytbgxXqfI9JjwoqNNWKW9IfJ8/v49altTZKwkU07aoz74OYbKHbeSAEXFlOfzqM6BSfWq7MenxxymH4KURbhiMLJQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.205])
	by gateway (Coremail) with SMTP id _____8Dx6vAsZV9q5KAFAA--.22331S3;
	Tue, 21 Jul 2026 20:25:16 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.205])
	by front1 (Coremail) with SMTP id qMiowJCxq8QRZV9qRfsTAA--.52432S4;
	Tue, 21 Jul 2026 20:25:15 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 2/4] dt-bindings: mfd: syscon: Allow syscon compatible for Loongson-2K0300 chip id
Date: Tue, 21 Jul 2026 20:24:21 +0800
Message-ID: <bab36775095bb85827676b2db917e6cb9527b325.1784619512.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1784619512.git.zhoubinbin@loongson.cn>
References: <cover.1784619512.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxq8QRZV9qRfsTAA--.52432S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEPCGpe+S4IdAAAsb
X-Coremail-Antispam: 1Uk129KBj9xXoW7GF1xCrW5ur4rCF1fXrykXrc_yoWkKrb_u3
	Wxtw4rAa98AFyFg390vF48KrW3XwsIkr17Cr17G3Z7G340qas5Xr97trWayr1xuF4rurnx
	Aan7W3yYv3Z7GosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

The Loongson-2K0300 SoC exposes its chip ID registers through a syscon
interface. Add the specific compatible `loongson,ls2k0300-chipid-syscon`
to the allowed list of syscon bindings so that it can be referenced from
the thermal node via a phandle.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index e22867088063..c5b2e28f6ced 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -76,6 +76,7 @@ select:
           - hpe,gxp-sysreg
           - loongson,ls1b-syscon
           - loongson,ls1c-syscon
+          - loongson,ls2k0300-cphipid-syscon
           - lsi,axxia-syscon
           - marvell,armada-3700-cpu-misc
           - marvell,armada-3700-nb-pm
@@ -189,6 +190,7 @@ properties:
               - hpe,gxp-sysreg
               - loongson,ls1b-syscon
               - loongson,ls1c-syscon
+              - loongson,ls2k0300-cphipid-syscon
               - lsi,axxia-syscon
               - marvell,armada-3700-cpu-misc
               - marvell,armada-3700-nb-pm
-- 
2.52.0

