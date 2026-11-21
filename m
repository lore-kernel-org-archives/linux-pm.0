Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795266381;
	b=hioW0ky3KJVknqaxByw0QV/yCAcCr5LHEpt2lHdXu1N4Z1y8LRa6Z6DqQCWkDgH7HtMq
	 BGHBhP6/TZje3y7x0yyi5/XXisCCCT7t4XzFW8dmfq5zahnrGLWs0gpNPgyU/Q5iZc7+p
	 yLWMovY9gWp0SdWgi9FavipJSRDPiIzy0CNpPVLPO6r+O9yLwQ6THfTWYz60Wot8OFdVn
	 nTDbiLn8xEShDuzebXTpyibwVQsSWZMH5LsX0XDX7ClnrvaVHFNVbtz40QQUFueZl1qbY
	 et83Uk02oe1wNrITI/atCVgUgkZS7eo/3+9nHQ292h+02MJsIc7UXrd86nFGDeyXC9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xGBvMhcJS11wtjrVJLfPo1Rw7P07wLWwQE89UszjvXk=;
	b=zt1pfAePNmfjtLBGSWsF3PtriS97A8gsrZXEQw8tQHDSDUqHPlk496lngAVj/eOBpi5i
	 fUAWX+ES04/bs1r34jvHc/GM/oqqQqVxi8f4gF1+dhhwkGeWajhKtYd+u7kEMl4rrGT2g
	 Mer68TbXcaq5PFZmakflIerH9kKbHryJoen+ER0UpQ6/ku0Ms9utE6p985UX2/HVO5WQu
	 r9bUcizrZ4O2YwoAV5bPIUjYGOEciXt13GEyFJ48pal7QV8SGrbat4CzC+x0i7P1f55Wo
	 bvOt0UF5yrUz8aqXWGNWCN8OlSFLtI04NJZdolzoaWs1oCM/rKQNShmdsgawGfSXyzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=DriHyNw3;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F4606A32C
	for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 13:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A80F4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=DriHyNw3
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so15442385e9.2
        for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 05:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795266379; x=1795871179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xGBvMhcJS11wtjrVJLfPo1Rw7P07wLWwQE89UszjvXk=;
        b=DriHyNw3BV9l7oU5BznimPP8Z63CFSgfNgaG9YA1VmThCVnv0tmgfUR0L7xLSyOiNW
         T8WhRoKQ2NZkPWcGtTR/mIKKd2WDndyEKhIrZzfEo9mQLoWL/EftEB6ldEkyIb9xOmuY
         c/jJlwJw86wcZ2oIELvdziYPBogwmHmulK7c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795266379; x=1795871179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGBvMhcJS11wtjrVJLfPo1Rw7P07wLWwQE89UszjvXk=;
        b=Ak7DKujLSq1rNo1RyIVrr1KiDZz1eG0h9g9PVA/VE/VZHHHM2wq0V+q2fjAFRfieuO
         zl3dE3+2KCL9sfpkblLe7fWG49MqZyakWQCTDMsXM+UEGjEB93hdvC8zQrkHqyw3ELP6
         HLRKkTSsBq/F+UPYnBpX4hIOxe+oEe033UfJY/PQw5VgCMVeVZom8zIT4m/j9IVeU7vg
         LCzrTRG6ibFXlWd5oS8FYh1utfup4bGDkB8cs/b771xxK5lu1N6epS1y7mamMxOZ2l70
         S6kJ7XAn3lFOeJra/gV4rP4H5fbtGEr8ki0uilDPI238TW0hUbmXn/0+ILDdZx+FxKUY
         GaPQ==
X-Forwarded-Encrypted: i=1; AL+hErFJ4Q6gSD8SXclf+BPYjZPBAUVUeFqn65x7ZmoYEiOld2TVWQIwHB9p9P0kyH52lGVZVLxgbUhYKA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8I6pYtWNAlZA6JDjRRPFvJR7U/AaxLukNQ+80OpygHDGXxYID1
	CTr7LCrWbm95+m9Tx2JXnO4fANndL3jUbzuiSRvkcCLtmmgCqf1KwsP0XvhwnULD2zdCJ04MZPd
	ZisZ3
X-Gm-Gg: AZFdTZegbDIGd2JJnkQqNdkBhKWxLGEv1wOvGk97riWPdwXJm7S1Q96q6R4BD0JQ2bP
	25oOykalWJQJxWDzl7MtidkVY7AEMSRZSCFTCSjAtxhqjvE2EbzAzg7FRNvAtGk1RqasKSTOdKt
	SUMXhoV6a+fPxyzz4tmEAIDc70eq61eRDesGy9y++ygJGX8OVUOtMiz1MS3uhp6kMYoSgS+H8IS
	0tM4fyBovJWdOZtvJIfpJGL4BB/epJgLvSz8wnV5kRxrCRpREXBEh1l32Rl9LyM1b2KhblAfkp2
	ETESgCgtcA2W34H09+J4uCwJhVPPuGVprbmwy+gdIj96vmO0sZCVFlBzx+RXbsQz37kj/rOmidt
	S64WndKdGCf//ia4+Q7ovf/rqvLNH4jHmt1zAB7BF8rS4FeKKbRqlhER2XU+Z5c1czkXJ5EcP0z
	G+wX4BLtULHuJQ97KrNuCt5EfwTRC7DUfSUNXsehBw51ln7dLGac4I8bgDke0m+w09bYkaqlzVI
	4G22nOrk3Gur9nCWdAxalxdCt06ZqD0OISrmEM+NHicJusluVJQarVjnYq8XFg2RYpzMyYvev8y
	Qu/vbo8/DRMCbiKVFfZubiXjurLqcdRRtMcQJP+2l+sAq3mSIBsOPmhLIyQulYA6BSwpkiyLRzm
	GuX6ZdOXPkTnVMQvmmudt7RR9xLw19pMDVKxCV74fnhc6kY49ZKmaa7Hx4wnZzo4oyAeBmAvXyt
	kwpMTKawvHfWlVmUt/P2ybbKG07fUAS9bia07fc2IqAFJ6HWg=
X-Received: by 2002:a05:600c:3b8a:b0:4ba:761:c0c5 with SMTP id 5b1f17b1804b1-4bb8880f0e0mr139372685e9.5.1795266379055;
        Sat, 21 Nov 2026 05:06:19 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm47196545e9.3.2026.11.21.05.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 05:06:17 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Lucas Stach <l.stach@pengutronix.de>,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/3] pmdomain: imx: Keep the domains left on by the bootloader
Date: Sat, 21 Nov 2026 14:06:07 +0100
Message-ID: <20261121130614.2482656-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

The i.MX8M power domain drivers register all their domains as off.
A domain left on by the bootloader, e.g. to show a splash screen, is
then powered up again by its first consumer, which on the i.MX8MN
turns the display off and hangs the system.

This series reads the state of the domains from the hardware, so that
the ones left on are kept on until their consumers have probed.

Tested on i.MX8MN (BSH SMM S2 PRO) and i.MX8MP (Engicam i.Core MX8M
Plus Fast Ethernet C.TOUCH 2.0).


Dario Binacchi (3):
  pmdomain: imx: gpcv2: Keep the domains left on by the bootloader
  pmdomain: imx8m-blk-ctrl: Keep the domains left on by the bootloader
  pmdomain: imx8m-blk-ctrl: Hold boot-on domain clocks until sync_state

 drivers/pmdomain/imx/gpcv2.c          |  61 +++++++++++++-
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 115 +++++++++++++++++++++++++-
 2 files changed, 173 insertions(+), 3 deletions(-)

---
base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
branch: imx-pmdomain-boot-on

-- 
2.43.0

