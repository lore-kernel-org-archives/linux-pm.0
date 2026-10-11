Received: from mail-qk2-f11.google.com (mail-qk2-f11.google.com [74.125.230.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1DE137750
	for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791677494; cv=none; b=N3g3O5bxDeISN43UaHiYPYn0vvIkuqNThEAY/MdBPv9QQklNu8A2ENvr80eV/S18cUegSNeTPEV7XqkxAoUrr/tq7BRsTMm6a0A/piazLKk86qZhAoLrNKDNNEFUrwJlMk7e0KZKwUIfB6VhV38BJRexSKk7ohMY96he0I7hLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791677494; c=relaxed/simple;
	bh=m2qc5bzaGhp+P6plEuL1iHjdBLdQ+Od5wxhJthpXIyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3i63h+/NqyVflXP1xs2j4y6ilx75dE82zCT/DnAl6KjWR9cdKGwFOcYYju+PGdcRF7Qd4Dq4WH8qUj4550uUaTdENrMRVJKX2FNndU1uwI6h2CdFjAZDu5QJDSFQC2970nb76T0rvTqrd06Z6mEWy8ci+u7cNdv53D6HgozB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo2E4Z3X; arc=none smtp.client-ip=74.125.230.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo2E4Z3X"
Received: by mail-qk2-f11.google.com with SMTP id d75a77b69052e-53503aceef0so5253311cf.1
        for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791677491; x=1792282291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZSFox7DYtsZr6D8rsT6OanL7ONG4L1d4OFVS1wYXN4=;
        b=lo2E4Z3X0B74U3SFCkbqANSbBrJv7T15GOZ9F3AVAnYlKw1tHQaX3gbaqsKXma5hUG
         ds09J5WtI54C2hIsixhH0hPBOQ6Vyz1aL1D038/Ef2W3WCj0ZyzI4b+xcyjDKQ4yBfmQ
         7ihdkbLqmyMswolEShpLwK16zMLSobIeLrkD4I+K46XEygN35kr6oYndQMaeQX0YBokV
         FxHDas5MvD1fZTx68S9cZXyPPuVEcxg+3hGmdXuqXjCUNLTdSPquEw8igoBvaS1V5IKH
         hnnB0hVewYKFbf5HCjzKR1xycGlJnjnGvpnMQlm7IChMnsBTAlm7Q69EJAp8ZVZ8SZuW
         VFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791677491; x=1792282291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eZSFox7DYtsZr6D8rsT6OanL7ONG4L1d4OFVS1wYXN4=;
        b=PSjnY/TyQgC2HC3+RYCt0xHAGcd5sK6ZMQdy2W2wNVvh9bJ7v1+CSrhu2EzRdrt7Zg
         wHKXu1cd2NEUpg2WUBGdcJ6rranPjxTSVde/rebf2HdFE1GRkyXAfP0rmit/AsrEGB+U
         1c3uWXOlGpNtddsF77X2J5VwnuIVZbkBqPodhtFDAnvOTTQsb+shJ4poSyaJ6z5T3u8F
         ZZZWiQFoR4mbufcXIi0deogUjGwwjZVV+sLupa4QRZk80xsifsLKwJJLcgOBzTsZJlNU
         yF91cp6R6TWF6AFMFBbwqvppeThJDE3mKQKstkqrueQXux2hdNjVIyJe3GG4zGJf0tal
         Kf/g==
X-Forwarded-Encrypted: i=1; AKwUvBzqOTIuVm0BjcdWtq4BcgxOt+zD+t3sWevJf2rDlyYciHQwSFlsYF+49DS0O9HfhntJhnXt79s7Sg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIX6YaZkpSIC3xPmhfPERp4vXsm9y+c08advKR/5mcre8QITZ/n
	Il4N2X34dWzdZst9gZOPLdodvvyngpSXRv73fHH56Pgq9zhA3Bhwnlkm
X-Gm-Gg: AYBFou1w8vBmyvH+s3VLQY5Oo3dTySD5V022K6f9hf1CnLaXFacXnrqKa4eH7AS4Q6p
	yKxVVXyBlPnAOOn2iJDNVRE3CiTiLMM2H+4setkL8sNl6GjxRoLZ91A3GMmN4FW7bNAR3PSN34W
	oMxd58LH/MSanNKgwWoFoiMa5362zzOXIdO9OzjLTwM0ntGJmZ2ct1HjIMXUqGHCQnO+uTAy7+K
	j5phqJCa2nHu0/UfQDbPW5BpldI0m2/FY7QCm5aer69QvegKJhHmJbqgtPQw/+pjoc456cHoDYc
	QKS0I6O9UrUbp5YcY2JjtIRL6R1vOV53ubcyaYidEjaMXZ89GD8vZGOZ9PyX6VVuApV2NWB5In8
	H+90HdN9k2u3XfYPQXG6qXo4/XWZaV5ZhROYE/LK80lfkfwG9cvWJDDPIrWbn9A3mzf0CIh1J3K
	Hz4EXtWqY60A5zOLr5UHxKGdkObE+pI43I/0jwgbr3E/bdD0RCviY27R6p5N+FI5bg3Fx8RYIYp
	uXb2A==
X-Received: by 2002:ac8:5a4e:0:b0:535:341c:e2c with SMTP id d75a77b69052e-5359fb8f878mr101828041cf.39.1791677491408;
        Sat, 10 Oct 2026 17:11:31 -0700 (PDT)
Received: from omarchy ([2601:804:8780:3df1:6ff:277e:31c7:ac13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b54e7f6aesm57217596d6.2.2026.10.10.17.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 17:11:30 -0700 (PDT)
From: zoan37 <agentzoan@gmail.com>
To: "irving . ch . lin" <irving-ch.lin@mediatek.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <mbrugger@suse.com>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Qiqi Wang <qiqi.wang@mediatek.com>,
	sirius.wang@mediatek.com,
	vince-wl.liu@mediatek.com,
	jh.hsu@mediatek.com
Subject: Re: [PATCH 3/3] pmdomain: mediatek: Add power domain driver for MT8189 SoC
Date: Sat, 10 Oct 2026 20:11:23 -0400
Message-ID: <20261011001123.1092269-1-agentzoan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260202064820.347550-4-irving-ch.lin@mediatek.com>
References: <20260202064820.347550-4-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Irving,

Some findings from running this driver on an MT8189 Chromebook (Lenovo
IdeaPad Slim 3 Chromebook, board "quigon"), mostly around system
suspend (s2idle through the SPM), on next-20261008.

1. MFG1's EMI GALS sleep-protect step, BUS_PROT_WR_IGN(SMI,
   MT8189_PROT_EN_EMICFG_GALS_SLP_MFG1, ...), targets the EMI config
   block (emicfg_ao_mem at 0x10270000; SET/CLR/RDY at 0x84/0x88/0x8c),
   so on MT8189 the "SMI" regmap has to be that block. Without a
   mediatek,smi phandle in the DT, the step went to the wrong regmap and
   wrote INFRACFG_AO+0x84/0x88 instead, which was one of the causes of
   SErrors after resume here. Giving the MFG1 node
   mediatek,smi = <&emicfg_ao_mem> (a syscon node for 0x10270000) fixed
   it. It may help to document this for MT8189, and possibly to fail
   instead of falling back when a domain uses an SMI step and no SMI
   regmap was found. (access-controllers would be the modern way, but on
   this board fw_devlink then delayed boot by about 10 s waiting for a
   supplier the syscon never gets.)

2. DISP: at runtime it never powers off here (MMSYS, the mutex and the
   DVOs have no runtime PM), but in system suspend genpd tries to, and
   the power-off is rejected part way (genpd debugfs idle_states shows
   "Rejected"). That leaves the display's memory path blocked: after
   resume OVL stalls (no vblanks, larb0 stuck busy) or the display
   faults with an SError shortly after the video unmutes. Marking DISP
   MTK_SCPD_ALWAYS_ON works around it. DISP has a single bus-protect
   step (MMSYS_STA_0) while VDE0 and VEN0 have two (MMSYS_STA_0 and
   STA_1); I don't know whether DISP needs a second one, but something
   in its power-off sequence doesn't complete in this state.

3. PCIe: to keep the Wi-Fi (MT7922) up across s2idle, as ChromeOS does,
   PCIE needs MTK_SCPD_ACTIVE_WAKEUP and both PCIE and PCIE_PHY stay on
   (we use MTK_SCPD_ALWAYS_ON for both).

With these (plus a cpu-s2idle idle state in the DT and a few driver
changes elsewhere), suspend works: repeated suspend/resume cycles pass
(20/20, then 10/10 twice), with RTC, lid and keyboard wake and well
under 0.1 W asleep. The board's patches and notes are at
https://github.com/zoan37/lenovo-slim3-chromebook-omarchy
(port/quigon/patches/mainline-mt8189-suspend.patch).

This was found and tested with help from an AI assistant (Claude).

Thanks,
zoan37
