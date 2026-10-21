Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569929;
	b=bwz6nPb0gHsfOVSUiPb13+b/gzQrW5w7awMEpI/t8pdSSrOL6FrichbKT9GbB03ZNE/6
	 gQ1zN8oTFzVDgX3aXS5CwZue9We1OSMLYzL7XFXAK+QvT0opY9j/gQenFgPbAAfywityU
	 Pfksp3V5FUFp2JA228hosatGWbmAoeVc+0LP9vi/RzEGsDJxoIi9ZwhLyZYxJKzwaUfP9
	 W0902vM2V1b5AM7vgZZhpa5Ci2D0dY9gGdBal4MMppzrVjIrtNxQUymDBaDAzpgm//SqU
	 zT7Tv9z3SLSebpVevnhiILC/fV1HlSPGEkXJ8xbeNSLw/pjq2iNZ+ayGl3IojDJJ/5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ucrcGnxXyuYhogAmjNJch54rUpgpdnz/8hQqaKskjsk=;
	b=Ps1ZTkQOrjdlw5B6EEZ00pS57IVldX/m4vvL0HiC7/ohjmlxusI5J6xVJq0gQqVMrcdD
	 ZUc4LCdXQ2RaY99XQyJKVRBAO5mGiI9/+BTXCMePLjKov5p7406qjqodbUL6ZDpq9ElND
	 PFVl4/c2IMw4vp+EicsZIQWt6BsFfI2kt6lFazy5ChnENNAtC1lfEXgB9Qk9Pp7Qcptfu
	 zY3K4+GoZ9mQYSvY3q7RtjBl8+VBU9WIE0OGvz+FqWsJ/5GG+QOaaeMNXq4Yxa3IUYAT+
	 kAtL/n2NIqT2WR8nTx4jCj9mNTG4cmGmx7xrCMgRVOdKvMQUvpiRNQ6bId9HZTebqlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jwG847XJ;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BB606A31E
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E9BB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jwG847XJ
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so3114925e9.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 01:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792569927; x=1793174727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ucrcGnxXyuYhogAmjNJch54rUpgpdnz/8hQqaKskjsk=;
        b=jwG847XJhJbV9MnwCiFohonUbKnj6JWHGBY63H4xDYKx9C8HSElWVEdTmW0dTxn5qB
         sg+ehAJ1WM3rvjLZsCQAyeWcyIn+yGDKvq915orp0dRrGGSNEMqdlaUHwuIrPYs9YmT6
         uinEITawyfHiGrsnhbTCBBwIZtLGAoDcVMadKyOc7LT0ycdfZZusmUyj53GLqnRHFaB2
         4H6I+ZKSN4c7bynljJJHON45X1/mIBtXjHBmBFiE8aDfiJBB71OufeK4MVFGiyH6LSDR
         PfXTgcOPZbpUcUyuE5ma1VNoCVyh6XnM+A7hD72MD0yxKr+OjxIxyJnZyh4dPNpuluyB
         1HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569927; x=1793174727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucrcGnxXyuYhogAmjNJch54rUpgpdnz/8hQqaKskjsk=;
        b=Tks1YYF4Qd617D/uF7SSAEnlvYdz22LvBYyRbRJom9GwiKk1mstXWEEnLIEYo2xdpc
         7yJiutm5Jr+G2tFkx0mmR9vghQJI/XSindr5Cgc7b3UI8HH41D46iDCZJaBwnULfbyIW
         wnwedGcqovm3lvpPPakxjWV0bv452LCPWphLPOqvvMcm09vDkqkuyzaCAPBHbNKdobB/
         FbtrhU7dB+Cq3A7nh5ntphfrmT1yDTW8AB1da6VUWLzSTXS+FWg1Q7tQgTGu0j/IfIY1
         FIfAp9exw6etW07IRhuIU0FL/V643EVEBdEvw9rZokv0aQOl0e584l8HHaQ9oA1NwTW5
         L4/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxuqYhqbtNBdb7hwq0kRf3MxhJoRSL8TCXz/ZLtBEjL/zid3bh1eWRaKyFbMY+TcjYaMWCxuUYRKw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL41LJ4bIoY94b2+GYEK90jFwIutdajZ9qLsPmlgP4Jo+uAnjzA
	nhKaK7fu0WVXIRqL7g4F2D9nVoVMeQIxF+DA3mP+1/SV5jAKYCYqVMjU
X-Gm-Gg: AYBFou3X4Ey4neLvW7EXSpWmDAADYCCAF2Lk34ZixLGPcyhgP1/bNyaY8/E8j0CED/m
	wN6lKAl22Wyn9qwqX3Sjmqck6jXBcB5Yxe1zEBeypk0uU5ey2dKsq/X6DzrRhHPBOFHGcnDefwf
	IZYX76RHbedM4nBoLBRkoGNAXkU2goobDF7Jx+6eCWTBB395vX4SkYkf+mxGSgZLRJwuc7OgmvL
	Htz41tsEaXjipoV9kgJu8VdClEbMZlS7eOxTDsEUBud6lqHjFhA8pBG1cvI4q50Cpws51SUVXco
	IXVu73kV7ClgmTfOjvA58DmCZSzY1VM5cyXI2XRtAhTqo+g6wp52OCFHWRlBHC2FEOXCURysmmN
	TXBAqZ/SbC6dzh0hpEQpUartJgfURIQvJ9tRQjkZxgkfNzkVXYzewlLSwTPLB1dn77sV5RHMHLJ
	3z0lr+6Ab6RBCLdcu/hH5GEA7DRoP86UN72KLf4VYn/e7/7L5Zoe4tkBj80/xfqNbEn8CL6remv
	h1PX4e1GSp6qhTd8y+3IlRWioXpkmJ9TAUILSBYytnHqluPcLmee5JZa/6z6YtPTw==
X-Received: by 2002:a05:600c:c4a7:b0:4a1:d41a:afc2 with SMTP id 5b1f17b1804b1-4a1fd8cb7aemr24443845e9.3.1792569926424;
        Wed, 21 Oct 2026 01:05:26 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.12])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1fc1066cfsm38928165e9.1.2026.10.21.01.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:05:26 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Rob Clark <rob.clark@oss.qualcomm.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [PATCH] pmdomain: qcom: rpmhpd: don't clamp gfx and gmxc before sync_state
Date: Wed, 21 Oct 2026 10:05:17 +0200
Message-ID: <20261021080517.2161-1-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Until rpmhpd's sync_state every vote is clamped to the highest corner,
so that hardware the bootloader left running keeps the rail level it
needs until its driver takes over.  Nothing the bootloader leaves behind
runs on the GPU rails, but the clamp hits them anyway: the GPU clock
controller's probe runtime-resumes and suspends its GFX and GMXC
domains, and from then on both rails are pinned at their highest corner
until sync_state.

On Glymur gfx.lvl has 14 levels and the clamp holds the rail at the top
one, 0x1d0, while the GMU's own performance table ends at level 11,
0x1c4.  With the GPU driver and firmware built in, the GMU boots long
before sync_state, and its CLX DCVS calibration does not survive a gfx
rail held that high: the firmware gives up with HFI_F2H_MSG_ERROR
0x007306c7 (ResMgrCalibrateDcvsLvl), the first HFI_H2F_MSG_GX_BW_PERF_VOTE
times out and the first GPU init fails.  On the Lenovo Yoga Slim 7x
Gen 11 this means the compositor cannot start at first login.  Pinning
gfx at level 11 or 12 instead fails the same way, level 10 and below
boot fine, and pinning gmxc alone has no effect.

Leave gfx and gmxc out of the clamp: they have no bootloader-configured
consumer to protect, and the GMU votes them through its own RSC.

Fixes: 93b6c8d10fad ("drm/msm/a8xx: Enable CLX feature on Adreno X2-85")
Link: https://lore.kernel.org/r/179248663855.32151.9955864156939592299@gmail.com
Acked-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index fa8fed5bd3e5..2c9d4beeffbe 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -1006,7 +1006,7 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
 	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
 	unsigned int peer_enabled_corner;
 
-	if (pd->state_synced) {
+	if (pd->state_synced || pd == &gfx || pd == &gmxc) {
 		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
 	} else {
 		/* Clamp to highest corner if sync_state hasn't happened */

base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
-- 
2.55.0

