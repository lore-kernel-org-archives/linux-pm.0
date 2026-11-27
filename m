Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798682;
	b=kaqX2tWoR/X6++m8MRDXFsX1KCveyspcTLuU1xIgKgI3WRrWTDAEqs6jKfOnq0hZ5O/s
	 H9iPQuZE98jMXA0uIE9PXWhZeGVTbpcx30foIEZPOmkwN2qyU2WqUFi4HHYxc5CADAg1x
	 gH2CAdf91D+2o2E7aghYFs87vhxS87E7aQG6/54HzrnHkIChqi7DWaY6yDSY804LO8wMP
	 b37gQtesMujKT7URIdh5tujhcs7dJ7IS0E7/7Yr+GHXaeFYJDjv7aws/XsXMe7j9J8NMK
	 K/JWzvJSdolcO29Xxq9MyJLuqaqSrCfsXrdWYZnjNWcA5CSjFE4rpvpqom3gLdBQgkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798682;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=dDRUfH0o20Iw7H1ahxTXrk/aD+0O0X9e+lhbcvj0Hyc=;
	b=UAJ63Sde1FsG6qOUPx/Gl5+NxkXwhdpMGqgTgkZLF5KvbSq52etbmODtw6mhhAjbliZ0
	 haiKZtak1LMN52zKq3g0419gbfAN5yVI5rxMsXvd5tT+jYsUWDML3Xh18z//tNAGTbBNT
	 BlylYa54tpmIooMHApmuiZiO+7FoYEE20mN0Vu5ES95MElU2GWGX4/XcEe/wPIAzRy2zi
	 kztgiNOIq7irZx913l68zu5ATESi1MV5hRsRRm2lqeoOJEbbJU7aV7tFFtLhcdtBTD/gz
	 msKVU5ax8ezRI/2LqHAPkr0Rtr+EHMXBLzFumolTrbxHkgyDTjRDwiAsNCZMm1iZSFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZadOtZj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276F606A31F
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZadOtZj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3001F00919
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798682;
	bh=dDRUfH0o20Iw7H1ahxTXrk/aD+0O0X9e+lhbcvj0Hyc=;
	h=From:Date:Subject:To:Cc;
	b=gZadOtZju3oA0OnCDHSKPuPrmZ7fNiKc+qHVH9FLh9Lp3to5jZRGeZ4MCQjwW+cVj
	 HRgB5jrlLlBwSW8LPfpKm0UAqPwQaDB91/uXA78xg8fRaXt4MkFI7oLDZs2IxLK2wa
	 sr+5oRzcZMIEjQy+Jdd6yyLwm9QbRb0KmzSsOLgIXU4gZ3TjNoVimdrJVDvqAKS2uA
	 0SvUxyWq+eul9PqsMtI7POu8HuqpHisSCrhEZZ0Eyipdalysxzt8t6nUDcyWubgVHT
	 lgeX5s+6ZUjGbhZRNVDzppnGzdv0soX0rhygCSb7pp6Q5P32o+B09XMYVW7n37mzen
	 LAAWh5Yt2FUAA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso3429097e87.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 08:58:02 -0800 (PST)
X-Gm-Message-State: APuU4Z/kr5ViWooy/pamSdVt1sl1ujVmx2y38MUCNlyIjTUbZAqE+L/5
	kyGxU/J8IWDOVIutecTrtPXVz7Jz/XSS3uv5gOtv4FVWHiFPV9I/mwgjIDVl6k8P3oSC9zVnTNq
	CMaG6kFitgyclztui15Jx7STPxkSs7bY=
X-Received: by 2002:a05:6512:31c3:b0:5bf:dc95:3817 with SMTP id
 2adb3069b0e04-5c1bc7bcbe9mr7212492e87.15.1795798680797; Fri, 27 Nov 2026
 08:58:00 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 27 Nov 2026 17:57:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0goDeyB0c_g5YvKGGZZNKaSLqWKkei_9pb50BHseizSmw@mail.gmail.com>
X-Gm-Features: Aa3M54oQ7BNHJy2Wa8RGUivkc57ynpI4AcAhusGbno5lGHN1hzrmMCxfQDeAJaY
Message-ID: <CAJZ5v0goDeyB0c_g5YvKGGZZNKaSLqWKkei_9pb50BHseizSmw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for 7.4-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.4-rc5

with top-most commit 52424a7805a05286743a5e9cb2dfe6548480b4af

 thermal: sysfs: take the zone lock in the tzp attribute handlers

on top of commit b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f

 Linux 7.4-rc4

to receive a thermal control fix for 7.4-rc5.

This addresses a possible NULL pointer dereference in the thermal
sysfs interface by adding thermal zone locking to some show/store
callbacks (Yu Zhang).

Thanks!


---------------

Yu Zhang (1):
      thermal: sysfs: take the zone lock in the tzp attribute handlers

---------------

 drivers/thermal/thermal_sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)
