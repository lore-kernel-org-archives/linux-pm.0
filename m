Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638229;
	b=JmS6qAIrohWanEfc3DXayFUQ7cPlfdXe3dzHw9ZcTrjGCCd5pF+T3e+nquSayvgHB0sF
	 OeAFTEdpVrMYjJ6J6N7XSFzR7jo/UNJsPnYT3Ul6wc55Sej9FXLOkV4JDtWzMYcq3zWfy
	 tZ4t847EmLlGmMUWddyV0LuseBTNdAC0r7tWgqm/GWrTe97lgHKrN8e1ypn0gs/YmpVlt
	 XWZShSzm81j4Rn+qXQEgUSDiYYlSLM+jWTuUWLTWpVd6s639XAOcSq1zGBbfqr747DN0h
	 IYGduwj5O/6HQSVWMSt6UnVMbrrkx3cNrQAoN4KNSMME8RuJ6Xxt5f1zhYxA5tHcWrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zM3VpGqk066yvlDhCbkoqjg4/pybiKa+o08CKjiTZQA=;
	b=QI6s7bVULLdA4nTtBaKh6iz5Fx/qcrAwHN7t9S/qcRB19QourFKZYjAKId8ns05aqphM
	 qFNxK9NzYJWqRZA3iTJK1EGi6I14VUKLAEfpQefxG/l3WdaPKYuqfGaTERL6jVpeNVsb4
	 /wifsV1Vxm2fVqt9Yv1f/a0FA4FVP3SJ3OT26BhlsSyuyyZhY50OJa5/0B62JFXqmTlQh
	 +vnF0IbqP3rXq4b16zXLpe0fg/hrWoS99j9GBN/2qpy7AV+BgAKcsEZWPo/PdiAeHIDJ8
	 N/JgtQizWaXf3CCgTXQgFeYqTHGTCGyfWthLQiLHklfQ/xs8J0rJdrM+zOxZxxIkS6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=axf0tRDt;
	arc=none smtp.remote-ip=74.125.231.128
Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08354606E031
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 16:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08354606E031
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=axf0tRDt
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-84e8a9fae57so1646860a34.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 08:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638228; x=1794243028; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zM3VpGqk066yvlDhCbkoqjg4/pybiKa+o08CKjiTZQA=;
        b=axf0tRDt0sMe6i07s+o9nbmWLTaguaMwSKVokW31n0d4S44IyWwqnemb4fMw+96zgv
         s3fuY7SPEAHWyxhMngDS9+Xr05yqpnVBw8DhH330WDvE1If13zhPnSMq75dWMkvoONG6
         pNNHOJh4y9Yc63IaaJD0uPtPgZnPMhVLehoIwsiHwtNmWt3T+1JN3s8DcU3YbcBI1coW
         q/lYbyyhwKxlNYhn3tiXRLUEJ+WtnTCx44uNlWY/ZC5YZCSsMRmc/nJXFAPOWNjJE4Yn
         c8nav11dQ+OVjkH3uXcvlTzoi+8jQ+pjUQbseqdsTc37HGWgx4iyzvpWuBqoLMGuHxbP
         joQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638228; x=1794243028;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zM3VpGqk066yvlDhCbkoqjg4/pybiKa+o08CKjiTZQA=;
        b=YXYJOrHJH/ryWch/T90Sfgwn5wHoKV2JKGjfzNAYUUy7PInKgWK1zKNIyRju3VZ9ih
         fUP9Gdd/4PtKABHQWX+dzasa2Za83GWtIGB0gfhLi2GHf8ADJTSK1b/jenUBEfGTLX0m
         0L5CfAEhM24eLt7MXbOAz1rD5Q1LjKRloUOnYyp0kSTyso0mngR8HW+MnrWf45cJD3bZ
         OCH19HRCR5nhlQj0H7HxbIZ1ADD8CTKuiKNUkVkr+z5PqLEPhEWEH5LDhMJyjdcYybXJ
         /xB2oVQRuO5JBAlCYtvSs5KWQcSQiSP02aZonn9sJQ50Xzbvlr2zCniFpugiRn5UWxKw
         6oFg==
X-Gm-Message-State: AFq9FYJR4/4sv4E8ESc8Xd0Kcv+0POupc8vcMn4Gpo5FfaMTQSzfObUB
	8W8k4snGKyfp+DTLYYuUI5Gn0DS/SNQpW6UQLL6dyTXGpllLF1Sv7IvT
X-Gm-Gg: AYBFou2LB2Uzv+/CtYQjSuQQaK1byLDnTzs1mIBqVNpI8YuxJ7t/IG/KzLjZiqYzKUt
	8MgE9IiMc8ylKfY4B9HWIXQxK4jvpJE9YegmzyKOH1LeFh4KC9QeE3zcp6QLomb1SdjeQOSRSk3
	ipIOoYKszk4WNzv9eSczJkG/wQ+9YwaQBsXSYVzScPGaoyYSnmRjeSJsh9UwAEDsn2y52p+9UtW
	D/+g8t97qWyn5TPSz9qQPP9vtsQ6fCXE14CLtsCAWXD05oxtKi2AaAgL1wYRg/N8eutd5X7kDam
	izvnmD/uBfKUD5K8hgYCxsX6bjLXsVb27fqOEUwYU6Hv8E6R+FD+BRGp5CpA5/ja+YWn8KtASW3
	fF4kTKA0m5NJrlsy3mxFPJcjSThR2d+7r542SAfuhP7iRPkGQybs9ZsBxOHJz098+xZU6YbbL1j
	Vfs4TCmuYXzc/vYKHa6ExfUvLtb01pFKiAjDkP9e+3s+oPXnYF2N9w0y1IX/CWb2qRyZa8IOBId
	LUjn7GAvm/bXvFMsi0fT2RmfdPmhsnkQGnkcH9byVhd5ec2YQOCusiDSQpdLUzsGNBZeSSak22D
	wPvjMAEn8s9MPHBobHnh/Br/TYzt1GMboV+wm8dOIEceKqJ19T3b5k9ozxrh0mSGAQtdewlopl3
	3Fo/431UBpiPXPJqH6pU=
X-Received: by 2002:a05:6830:4105:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-85d362dff0bmr7694825a34.1.1793638227841;
        Mon, 02 Nov 2026 08:50:27 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354985cdsm9936779a34.10.2026.11.02.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:50:27 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH v2 0/2] rtc: mt6397: provide the RTC's 32 kHz output as a
 clock
Date: Mon, 02 Nov 2026 10:50:20 -0600
Message-Id: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/43NSw6CMBAA0Ks0s2ZMP1I+K+9hWNRSYKIF0haiE
 u5uxAu4fZu3QXSBXISabRDcSpGmEWomMwZ2MGPvkFqoGUguteDyjOEWFodxcW9c5piCM57GHn3
 SqiowJItK3pEbYYXutFKlgozBHFxHz+O5NhmDgWKawutoV/HV3yC4+HNYBXKsirzsVNkWPFeX3
 ht6nOzkodn3/QO0HV2M2gAAAA==
X-Change-ID: 20261024-rbrue-suez-upstreaming-mt6397-rtc-32k-0a1c16f63383
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793638226; l=2364;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=ZOmLqEV8DHWh2DzcDPWX0yn3ibXvLVXOQgGwZxT1ZLU=;
 b=EYIi/kP66XwXIMwPN4Sc/iR0MoBldI6Gl1SwMDFNh6FS6aWjtblle3rpmua61fZlG25Jv2kBd
 XNlFeUApXDTAnJpLQ4whIOSoDkCLs66sO0N9UcNyu4N9A7PTHVFlJuw
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The MT6397 RTC drives a 32 kHz clock out of the PMIC, which boards use as
the sleep clock of a Wi-Fi/Bluetooth combo chip. RTC_CON.F32KOB gates it,
and mainline never touches that bit, so the chip only works if the
bootloader happened to turn the output on.

On the Amazon Fire HD 10 (2017), which can boot through U-Boot instead of
the vendor's LK, nothing sets it in the former - the bit is set at every
boot, and the MT6630 combo chip's Wi-Fi and Bluetooth never come up.
Letting the RTC provide the output as a clock lets the chip's
mmc-pwrseq-simple enable it. With the clock wired up both came up on that
board in two boots out of two, and in none of three without it.

The driver registers the clock only when the RTC node has #clock-cells,
so no existing board changes. The MT6323 shares the MT6397's driver data
and gets it too; every MediaTek PMIC RTC whose registers I could read has
F32KOB at bit 5 of RTC_CON, but for the MT6323 that is inferred from the
shared driver data rather than read from a datasheet.

Both patches apply on top of the RTC nvmem layout pair, new in
v7.4-rc1. That pair went through both rtc and mfd, so I'd suggest these
two go through rtc only, with Lee's ack on patch 1, if that works for
everyone.

The board's devicetree that uses the clock is not upstream yet and follows
separately.

This series was developed with the help of an LLM.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Changes in v2:
- rtc: check for #clock-cells before reading the driver data, which is
  NULL when the PMIC has no RTC node, as on mt8173-evb (Sashiko)
- dt-bindings: add Krzysztof's Reviewed-by
- Link to v1: https://lore.kernel.org/r/20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com

---
Ryan Brue (2):
      dt-bindings: mfd: mediatek: mt6397: describe the RTC's 32 kHz output
      rtc: mt6397: provide the 32 kHz output as a clock

 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   |  6 ++
 drivers/rtc/rtc-mt6397.c                           | 85 ++++++++++++++++++++++
 include/linux/mfd/mt6397/rtc.h                     |  6 ++
 3 files changed, 97 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261024-rbrue-suez-upstreaming-mt6397-rtc-32k-0a1c16f63383

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

