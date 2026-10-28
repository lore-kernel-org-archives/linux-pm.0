Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188688;
	b=aD/xopRvbYltIHBk1QHmdUscIdgJhhdZeBbzk/8dOqiMY4R1irL2YjrVWOu530fvhQil
	 lyPycVdKylxm6QGRe52Sodyi57YpnUnyAFiG4XICutrxoEmaBJMLBIPUIaRnNn7PkxVmM
	 segfSHY48IDams82XB5kODoeimH+4SeDeiyzWDeAZ0iEwouNhRsILByHUMvjnj7Jlznrr
	 YVR8XOYrvHGINBUd+AgS7gft5kGogSplGfG1WFakzuzO80Nxt2goFf6FjsmA+D1i0LzdE
	 F4fxU6rSJOUMFxYQSrxNq8f/TlnU9kpYXdJNmCAR2YNbn9c78tVpknSu1a49juaVQsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188688;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=0rd0eq+HWmPKSTWPxG5jNO/1HvtIEnxtmy7jSKAuMZU=;
	b=Ce5Mdbhc4GAv2IK+wIaq7nqyrnekylqByEzN18EWr+k05cS03jfxtToYu7KDaMXhz5SL
	 ybsB1kkSXympS9bYwVMnVnVA4M/y3umSEUFYIRtogDUhtiL3TZBlZDmvU1x/dCl/qEwQ2
	 4SSou63ztZTpaA0yr5S7mhp7R5tHHV6LIYufZuL1izeEisBjQVZMPG6iL1VMKJy2YC3pd
	 R/pKk5/QPVyIE2b2XWuI6vLEWJ8xMjnhYbV7diF6WttUMqUexIouyyvRGCvizAVR79j5J
	 R+2bQq9JCVcKY9cUXS6Zih495JJOgId6XxTeVo7aOH21GG5SKqIx4keWmnikCfrdoKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=xH1CgE2W;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35553606A31C;
	Wed, 28 Oct 2026 11:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35553606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=xH1CgE2W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version; bh=0rd0eq+HWmPKSTWPxG5jN
	O/1HvtIEnxtmy7jSKAuMZU=; b=xH1CgE2WFNhu+WDMbiZ6GUyJcTDyQTv92AAWk
	OOegw6PiBMAQEyBkcC6Mt2ZXg2/P1C35aebPlGF4jTnToWxnPFiGiuO7nBdplDBR
	jKA8gfLR24cgw44ZYrE+DRGHDCWaiEFVKsFwj+RVoZ0JyKZr2MHNSc7UJx7aFTtu
	RNzcYA=
Received: from [127.0.1.1] (unknown [114.214.180.23])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDHST5F4+FqCs5YAA--.2697S2;
	Wed, 28 Oct 2026 19:57:57 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on SM8750
Date: Wed, 28 Oct 2026 19:57:57 +0800
Message-ID: <179318867727.88971.13007415873000488463@mail.ustc.edu.cn>
In-Reply-To: <84483ae1-1fbb-4219-a829-5867feb8bb17@oss.qualcomm.com>
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <5bf3636d-be7a-4800-9914-808d2fc5ebd9@oss.qualcomm.com>
 <52fc4222-508d-4acf-b38a-7b4e5aeff3cb@oss.qualcomm.com>
 <63cf18bc-5c89-4a55-aa15-2550dc47c155@oss.qualcomm.com>
 <179276335779.97093.2561281074827129812@mail.ustc.edu.cn>
 <179276342356.98176.10645303509497652146@mail.ustc.edu.cn>
 <84483ae1-1fbb-4219-a829-5867feb8bb17@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:3pYKCgDHST5F4+FqCs5YAA--.2697S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryxGryfGr4kCFWxJr47Arb_yoW5ZrWfpa
	yrtrnYkw1vyFWrCryUtr47Ca4Ygrs3AFy5Kr9Fv3sYva15Ar17tr1kKFn8Wr97Crn3XF4x
	t3Waqwn3WF13CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxkI
	ecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
	Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUg_gCUUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREOB2rg+9ZfJwBgsm

Hi Konrad,

You are right and my previous mail was wrong. I checked the repository
you pointed at and the battery/QBG path is there. Correcting it properly,
including why I got it wrong.

What I did before was a partial clone with a sparse checkout limited to
the display, mmc and audio paths. drivers/power was never materialised,
so "there is no drivers/power/supply vendor code in the drop" was an
artefact of my own checkout, not a property of the repository. That is my
mistake and I should have caught it before writing it down.

Checked now with the GitHub contents API on main (tip 210981a0ad74,
last push 2025-11-09), no full clone:

  drivers/power/supply/qti_battery_charger.c     70657 B
  drivers/power/supply/qcom_battmgr.c            39375 B
  drivers/power/supply/qcom/qti-qbg.c            78872 B
  drivers/power/supply/qcom/qbg-core.h
  drivers/power/supply/qcom/qbg-sdam.c
  drivers/power/supply/qcom/qbg-battery-profile.c
  drivers/power/supply/qcom/battery.c

The same commit is the one I have locally and git ls-tree lists all of
them, so the content was in the tree I already had.

On your three questions, now with the sources in hand:

- Which channel does the vendor actually build? CONFIG_QTI_BATTERY_CHARGER=m
  in both arch/arm64/configs/vendor/sun_perf.config and sun_le.config
  (sun = SM8750). CONFIG_BATTERY_QCOM_BATTMGR=m appears only in the generic
  defconfig, so the SM8750 build does not use the upstream-shaped driver.

- Is the property remapped? I do not see a remap. qti_battery_charger.c has
  BATT_POWER_NOW at enum value 22, maps it to POWER_SUPPLY_PROP_POWER_NOW,
  and read_property_id() sends that id unchanged to the PMIC GLINK
  firmware. Upstream qcom_battmgr.c also uses 22 for the same slot, so both
  channels address the same property id; nothing in the vendor driver
  renumbers it.

- Does that mean power_now is trustworthy on this board? No, and I am not
  going to claim it. The vendor driver answering slot 22 only shows that
  the firmware has an answer for it. It says nothing about whether the
  value tracks load.

Two things that do not change:

The vendor's own qcom_battmgr.c is an older copy - enum qcom_battmgr_variant
has only SM8350 and SC8280XP, no SM8750 - so there is still no
upstream-shaped reference implementation for this SoC to compare against.

And qti_battery_charger.c is downstream-only: it includes
linux/soc/qcom/qti_pmic_glink.h, linux/soc/qcom/battery_charger.h and
linux/soc/qcom/panel_event_notifier.h, none of which are upstream, so
qcom_battmgr cannot reuse it. Same conclusion as before, just reached with
the sources in front of me instead of behind my own checkout mistake.

So the question from my previous mail still stands, now asked with better
information: would you take the conservative version - add the SM8750
variant, do not register POWER_NOW at all, no claim about what the slot
means - or would you rather I keep the property and only fix the commit
message? If you would prefer the numbers first, I can print slot 22 next
to current_now and voltage_now in one sample and post that before sending
anything.

Sorry for the noise, and thanks for the pointer.

Qianhui Xu

