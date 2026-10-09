Received: from mail-qk2-f4.google.com (mail-qk2-f4.google.com [74.125.230.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1450C2B0
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570720; cv=none; b=hkApH54Bqs8h540lMuu+u5b39Ne84Ho7WelzHSIGMFzmtWGMMZN5SUZoNMoF1lzORC6oGcga9GNoEwseB8H8fwRAXFtEvi8tk70+AqXXJhtVU4AVAh21K+h48pLSZXOB/iukG7AQlztEmJwhC1oAn5J1xruXT3G4zNZVvWfC6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570720; c=relaxed/simple;
	bh=U4dHBbZoLn3vaeQbmgOV5MgVtEDo4RA4KvvRpivcR9s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mwkEnz5G8TPPd1Gpdo2RPbMU2MNgjgu4WsCMz/Z0F4KuJ+3phmt89rdpAEJTnhVmXQSyPushRg/s6DX8gL8eVFVgubMyRNOmZaRy0V6J19dPwC7GpVo36bxskIVfZVL9VgB2oKeTwJbTKdGBOx3p3D3cdC3GGvJHC8VhEg4ErK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA4SZJ64; arc=none smtp.client-ip=74.125.230.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA4SZJ64"
Received: by mail-qk2-f4.google.com with SMTP id af79cd13be357-93cc7e652d7so483422285a.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791570712; x=1792175512; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aaMaFxdym4cWsHL9+RBt8IvSWstCqEIA0PpJYwb/eW4=;
        b=OA4SZJ644u8SFRCFg5ZC0jk4uGR7Dd5uCMPpnp59uE3Yco+mnRmq4CZYNW/1UyViBR
         QbBbEC/pVpd6XNEmVAgyFKKnKRh5pXZL9IMx7FEQmDWK3y0ga1c/gaHuSOM7KeQzkWW/
         1FbJMch2yzyKJjF9Oe72Stg7XMxdfimRbjE+nmh+bYZFlKIN5TVk4yEcx0TSsFDdvwST
         xTvO+hIsbhdIu8GtoirfBbVScXH4QLrg7bUVPEB6LNxBZPGXhXc+jDR6CObJDg/C7/L5
         KNxrkLfkeCi3M7vs73fYu6AlN3dCQ6Ge3jRHaKAnyzWnYzBNR6exkauid4XRqTdbEZLI
         fBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570712; x=1792175512;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aaMaFxdym4cWsHL9+RBt8IvSWstCqEIA0PpJYwb/eW4=;
        b=xLt/QFAVbPYu+VCKlKGKcJFnhW0bRVDC3Drvzv0t9nIw/FIcgUBL3ZjGf03V8UpGul
         wm+SvxtnXufLCpUUL9ucUzZMG+S06DwhVcY0GfGEWxyNvKmQ8Is9qLHKVp/7vBAknx/U
         dzkHvdgR7ZBUzO1AZw61EWQVpnvp6wkdLmuirRDGTBoLSOOFE4oEgRStAyVtHNP3BUSI
         ZJe3bv/HwyEZKbYX/96785uZ4rg8Nc5Z1T6Uye20uT3VIyU1eg6JYvIAgnrw/QAgY+2h
         isigJ4tWuprgqfEdoyan34s5dRpAU0hITGDAodYj24hgwkvU4THooybAO/gdHi/CUe+C
         pmoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsLg17+pjmwxsRvKCDKUNOhCvTuh8ACra3BGXiC/y3LRe0OWGJPQNmUP6SzzU1tzQ6dLUoxjAC3g==@vger.kernel.org
X-Gm-Message-State: AFuF++mbp/DQWvEXinIvpZIJuVgxoLheF9+3gnrQfcKhEQ8pWg7UiUse
	cs9rtMqKyLivDDn/nkanopNBMM4nt4f4yDzB9VKIbH3Ek7XlA0+lbpaK
X-Gm-Gg: AYBFou2xJAJgIuXK8ErTnEMFB/sPkchxCOyK1UJ3TwzN8Dx1h+LmgwFflRsg2vXy3PP
	crTOivggci0xPyrKZAvzwFu+a9YhU6SH+G4mBauvib+hlUDt2EEgJE0wVborJRq3gn9rz3W7zR5
	+Uq/dGBEryZluyhEbaq4PA5DqDEXMtHSBBNgZlIKuV+Np9Aqz7IfMMF1d14pLTnBi+o6cKL4txF
	9UT8aPx0+GFd2wpAVB+4wm3CG2ohrGp97KNICACNQ6xjBfHYCXJVoqLqHb4xXEtA6DalP3t3nUN
	P7R377w1E/ajqm97a0B6mFCNHCyDmkzLjargCkR5LiVdTAhVajdPLNuPjQ/OBgqdYfbpJYwjQNr
	stAIoNTFZ/x6MMqif5Sz1ThsCuqknLVBJXWvWI/Wf6lMgNHR3kPRw/TEa5r/Na8Lc96+AXhX0Ix
	WetKncEDE+t+UnDzWZW+rdlKLBgQkbiD9gdenDWat8i+q5Y4sZf+Pp1dpITc9SEVhpXGSLrapW3
	lSClyWDQy57mnBzNcifEZ2YatJVUmZ2pGPCm2GzPdTuR13KIZNUjpT/SZ3q560x
X-Received: by 2002:a05:620a:c53:b0:93c:779f:3e02 with SMTP id af79cd13be357-93ebd0c0021mr428898785a.11.1791570712447;
        Fri, 09 Oct 2026 11:31:52 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9898b5fsm245594685a.32.2026.10.09.11.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:31:51 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH 0/2] cpufreq: mediatek: Suspend at the opp-suspend OPP, and
 mark one on MT8173
Date: Fri, 09 Oct 2026 13:31:45 -0500
Message-Id: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v1-0-9100f79b4080@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqDMBAAvyJ77kKSQ6z9SulBzWqXYtzumlIq/
 r3B4zAws4ORMhncmh2UPmy85gr+0sD47PNMyKkyBBei60KHOmghtEI/LGKbUr9wnnHZXjhKmZT
 eVZpQTriK4NUnH1J0sfUD1KgoTfw9h/fHcfwBNjPGEIAAAAA=
X-Change-ID: 20260929-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-81d12d60671b
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Roman Vivchar <rva333@protonmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791570710; l=1963;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=U4dHBbZoLn3vaeQbmgOV5MgVtEDo4RA4KvvRpivcR9s=;
 b=sG8+NEHSW7BcEfXRhD7UEaX0Q4sFLMKTDlhA+uK12NJiwNn5hVhLgUdAt/DYzkxlyTEend9Sq
 BnZpSmH3IaoDHNBa2QeeCXCgHYHgznhWr24NPefLgNz5Dd1iPxON7b4
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

