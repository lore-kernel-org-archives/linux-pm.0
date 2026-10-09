Received: from mail-qk2-f3.google.com (mail-qk2-f3.google.com [74.125.230.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4F4FB9C3
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575099; cv=none; b=R51ME1PrDvL5qvFT47Y5H57tzWetc7S/q9GEdn0q2dOIiEpd61LSiY2VvhnZGO7zGiQX3xnUznFt3X3mPNYBYFMEOGvwRFrhFqNFIi3FT4m9crPXmVa7RqQA0xzkLAIvU2Iewk0z0sFhO6YHlkk/XaXg3zuS6ZJQ6GkGbNXCk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575099; c=relaxed/simple;
	bh=L3vc6anihw9NuQdcLcZ4gFYI/0/LOL9Q755uzReuYQk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AKkLhkyizJ8CzmbJc/72UlnC/c9F9/jorTgLaarsltn3aUT/mJF5m7kT5HNK51Ou+r0dGDBRs6gTDsPwkSecs7GIlAPJKQaPaRwfPO8WjdC/TPWW4OnoiFV1Cf2w7mfGjGE8RuCxbOSx81n7PujBt5kpLXyUxWqm3/QU4ZzmXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd2T0oDK; arc=none smtp.client-ip=74.125.230.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd2T0oDK"
Received: by mail-qk2-f3.google.com with SMTP id af79cd13be357-93cc1b028bcso2902485a.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 12:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791575087; x=1792179887; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n5sVI1GUHdT0XZZxczYNHjQkkrtpSuPJARpcgHnshWU=;
        b=gd2T0oDKeX7OtKr+ppX3C9jOOA7V7S/djhYo4Xg4ODK1qDdTRTWub1UJlvZicbA7H9
         +CrpNnkHnohBSTpv8zcvSLu+OS7zPsVn3ziaGw2g5ITK3gLfVxTqcxMTMuTdnCXmgaSX
         z9F12Z13hCNvlVDviczutAPJP/MUluWeN1ai/ZE1CAYIBC5J58hs3oumMn+d0L8/W82S
         bm4bC/Y0XOQX5Pwl0IzLb+6Ov14IW1iUeOOFCnMi8/6n13ccycPGZUeoCWb37wzKXVtS
         qonUE0E9XHmBTVyKn3mBCNHTSytHbFIuOX7CkBcVzflIXZRPtsenzuZQ+pWCcdEuyF2P
         flSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791575087; x=1792179887;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n5sVI1GUHdT0XZZxczYNHjQkkrtpSuPJARpcgHnshWU=;
        b=L1yNQ1PFwSkn3YDsIt/2A6AMnVpd9olxfSXrMPVnRLjN9v6oZ/8VYPVqysLd2W2YDd
         sDQrabZ/XbrsjQgXinRkXQJqluNzjLDojmGmabd03X76HPQc7W/0ibXBr/V/aBBG5/5L
         tugd0WnsDDTrsP5GweIa6qmLDU9y0X64VhYLk2iWFo6o5tdYslYLwaJNaosDq3lPjb20
         /YjYGytVvz4imIA9IU+P3yB2siZiFX1iOIo1W1LP+oOV8Ezj9N/2veZfXsJm4+aFJ+5X
         nzFxH01QLRtmY/p8UGI5Jo9tuUEOXxDxUQusKhEaMJHrTp8aKctY/hf71YMOpTAsZbt6
         Sk0g==
X-Forwarded-Encrypted: i=1; AKwUvBxKRNLxG7mzdieRfjFgq7w0Cy+NNyQIIOtfqUMgn9gKgaR+4cXTWTdUpCaZmxzkj6Abt7RSz4xMmg==@vger.kernel.org
X-Gm-Message-State: AFuF++l48LVCtngbw5cJPxBhFboNStzX9BY+JeulwZZu2cU/8G6yDWWp
	7n26VmIAIgywcsDfqt6cRgSAbPnhjmU2s1GhOKWUvKbw8fHk5L1xH1xR
X-Gm-Gg: AYBFou3NjS0vJn5yBoBgtrYswflMcMwMRKmbMAWfmoKqUM9FpkMqjCxZKE2nhEt4IHN
	KVhwsWYv3o56J4xMb0VjMsBZpT3ib7UiVTpNYBgp0Yi4Gpv8AjWaRuGOrELEhkgUetyrASBDZnd
	Y4OkD3qqBxEB7CleGktFQ0em5gRL/a6En1I/J7PCaKRFrGOBfR0BAbjp4LLFg5dH/kR7Huh1RzR
	wWT5v3RfC9w/28PNaivb+0JBEwZIcXEVqUrTBGUL0pujVzwiZ59VgVeP6iSYuXr2BLWPGmzvtMv
	s1zTxkYGYbCbQwf+9KplrSCpSInea5BLiqO46n3LsIN+yjrFKWoA0TrlRW6LspaackIT8EsVcfV
	N+bEB2Tv7llP+s4pAevQI71koitzkZI5cbYjwOMZkmmjiWVoXMdW6P/OKOw0OxLUuqaKBuOucqu
	GAO8bbpEbKPtrqdj2wkjsG10pUZzHDH1ugUBaeESf97cd02OiMWoUnzFFffyCWRqQUJxMqUHbjp
	EwOFmvZwvYVkqFusllro9tM2ct/Y2B26bbiaPxnhAMsIukLQU1sKgrwAcmDLyLlxg==
X-Received: by 2002:a05:620a:3186:b0:939:b057:daf2 with SMTP id af79cd13be357-93ebd26c06amr503914585a.45.1791575087187;
        Fri, 09 Oct 2026 12:44:47 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98c5633sm259293485a.35.2026.10.09.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:44:46 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH v2 0/2] cpufreq: mediatek: Suspend at the opp-suspend OPP,
 and mark one on MT8173
Date: Fri, 09 Oct 2026 14:44:42 -0500
Message-Id: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v2-0-ba13f826eae1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNQQ6CMBBFr2K6dsy0MUBdeQ/DAugAE22pLSUq4
 e5WbuDy/Z//3yoiBaYoLodVBFo48uQyqONBdGPjBgI2mYVCVaBWGkIbEkFM9IHk4xyosewGsPM
 dOp/6QM9cRk/OwOQ9VNJIZQosStmKfOoD9fzahbc688hxnsJ79y/yl+4qifi3apGAoPOyL3V7x
 gqvg234ceomK+pt275iZ9WU7AAAAA==
X-Change-ID: 20260929-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-81d12d60671b
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Roman Vivchar <rva333@protonmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791575085; l=2772;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=L3vc6anihw9NuQdcLcZ4gFYI/0/LOL9Q755uzReuYQk=;
 b=hRi+Wn9i8/fos9oTP6rkL2wurMq9Zk3718GB4hzvsxAUVc5U5D9CmncK/Q5GUIoL8THYrgpiG
 pGp5tGoInymCtt/2+7TOUdLSu6ggVJojj74K4eEy/FIuaTSyF+cQksX
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

mediatek-cpufreq has no .suspend callback, so each cluster enters system
sleep at whatever OPP the governor last chose. On the Amazon Fire HD 10
(2017), an MT8173 tablet that is not upstream yet, entering
suspend-to-RAM with both clusters at their highest OPP (2106 and
1703 MHz) measured 63.5 and 63.6 mA, against 52.0 and 52.0 mA with this
series. Those are 15-minute windows of the PMIC's coulomb counter,
alternating with and without the change; one count is about 2.9 mA.
Earlier, on the board's previous firmware path, s2idle drew 210-232 mA
against 158 mA.

Patch 1 takes the suspend frequency from the OPP table's opp-suspend
entry, as cpufreq-dt does, rather than always using the lowest OPP. That
keeps it opt-in per SoC: this driver also runs mt2701, mt7622, mt8183,
mt8186 and others I cannot test, and no MediaTek table has opp-suspend
today, so they are unchanged. Patch 2 marks the lowest OPP of both MT8173
clusters.

Patch 2 also reaches elm, hana and the EVB, which I cannot test either.
What they get is a switch to 507 MHz in cpufreq_suspend(), which runs
before any device is suspended, so the regulators it needs should still
be up. cpufreq_suspend() also runs from device_shutdown(), so reboot and
power-off switch first as well; on the tablet, reboot -f still resets in
1.4 s.

Patch 2 does nothing without patch 1 and is harmless on its own, so the
two can go through the cpufreq and MediaTek trees independently.

To: Rafael J. Wysocki <rafael@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Roman Vivchar <rva333@protonmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: devicetree@vger.kernel.org

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Changes in v2:
- Add the Signed-off-by missing from v1. No other change.
- Link to v1: https://patch.msgid.link/20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v1-0-9100f79b4080@gmail.com

---
Ryan Brue (2):
      cpufreq: mediatek: Enter system sleep at the suspend OPP
      arm64: dts: mediatek: mt8173: Mark the lowest CPU OPPs for suspend

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 ++
 drivers/cpufreq/mediatek-cpufreq.c       | 2 ++
 2 files changed, 4 insertions(+)
---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20260929-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-81d12d60671b

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

