Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793392034;
	b=Ys9C7RTf7KL8w1japzghd3M/YNZk4MiAi0gUIC79opr6Kc1RKB4PmnmQg0IKXWLfJYvJ
	 8ycDsDKYfCdb9UT5P9Mi2R+9fLp9H/Nyz3Xxy/CqkNmWwMgMMiISW8tghBfeYs7bhl3cO
	 BClcP/GS04qkxkCoRdEnquQkN4dw8LKUWDPbVJjKFmJY6MkNx/m5gkIAK/1ROo9kR6CY0
	 ebyxm0iYW5qvHl7/cpLquqPEfetRbyfDVL44T7eCcjplRvtv6ZJqKumSVfr/0L/FsyIoB
	 a5NvkO6yRooDOGqPGkRkHKy7ja6qO9LL78yUUyYizycE3Q9xRGyq2Au2nfkziGmhuCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392034;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=pqXtFs5AG3LRq9IHK1NyNxo49Fa15UvJPSBSbnkjgGM=;
	b=Gw/MK+LU7UhT713Mgz/jJKgdfash6r1Ab/t0nZPXsXug4+dLzpHxSCftTLMOVtzIWxm1
	 +E1X4fWzt4q77MNLNYmaYOSQnrJ6j6i/NhEeYgs0AkxnB2xZrFvwFd+ilV0sHD/ASRU1w
	 LbWMigbs7bLaofpX84p7hBDhwHB4qecanjFnGPtLS5wCWMtaM/9JkeZqUreybWNBif4/j
	 kCT7eyC+cBPLzJ4jO2lEuks9E7XBtlEh4zDuP1MwNfPL1TJo25+cpjsR0wZ9sWbWInHrU
	 AIaJ9eluX7TlmV2hgnNCHebl8h94n75pCt8cj171KvPBYtQ84ENyxCVeJsRCrau89gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWL1UzBb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D8606A31C
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWL1UzBb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632201F00A16
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 20:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793392034;
	bh=pqXtFs5AG3LRq9IHK1NyNxo49Fa15UvJPSBSbnkjgGM=;
	h=From:Date:Subject:To:Cc;
	b=nWL1UzBbxtJpdLv9+0CU0zRqqOH5mG5Kt1H15HVsF6FkknucbdKB2Z3mpRftM9AtZ
	 RMPIzo8AHlYvwiLJjURF3FrLAn4mjeeC/Di13tpuZEPMebPuABOOMG/HvqFuLAYN4C
	 Gdm7MVQ8pwfk2YLVTjViUmkpXMolXZRG5uxaQ7afjyYGfyvMtdZVKOsbx/8hp8Higd
	 prziwV3Dp5cYYcCpAapeKKAb5bs7K9TGrsCKIZ1Srl50yFbx0x7PacMrAjO5qVpTm/
	 E+5ElLp4E0/w+uneSIVwa8HbCMRzs2er1XpteuIx01C0aip2m92WzkNCcwjvf2HF2x
	 3skClmysaT81w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so1099769e87.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 13:27:14 -0700 (PDT)
X-Gm-Message-State: AFq9FYIl09SwYhqiCpMZmjiOfaV/QwNS28R4mtUdRz2MfQKWx4W7AoD6
	y1wFzpmMsuitV8J4wceWRP4SEBIMWGgy4AScrQbEXEkzo8Z2hnUIGz7ZdaCTzUIACzQGp1yg4EK
	9Y1jIDQImdIj4UhVOqFay33Z/vZUlcx4=
X-Received: by 2002:a05:6512:3f01:b0:5bf:9f5e:fe0d with SMTP id
 2adb3069b0e04-5bfd95605d9mr1305709e87.23.1793392032873; Fri, 30 Oct 2026
 13:27:12 -0700 (PDT)
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
Date: Fri, 30 Oct 2026 21:27:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iNLS=-XW+LeJTa5ttDJGs6AcQdMOxaFTCxhXu78jnsjQ@mail.gmail.com>
X-Gm-Features: AclHuK8SSOaqftR9NTiZdUwfLGjA_LieVokjUgZaaB5F0Z1De1XQKPUmop8daEM
Message-ID: <CAJZ5v0iNLS=-XW+LeJTa5ttDJGs6AcQdMOxaFTCxhXu78jnsjQ@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for 7.4-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.4-rc1-2

with top-most commit 4358090906b01806ee483229e8d7163b806bd116

 Merge branch 'thermal-intel'

on top of commit 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614

 Merge tag 'driver-core-7.4-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core

to receive thermal control fixes for 7.4-rc1.

These fix three issues related to thermal control:

 - Fix CPU mask truncation in power limit trace event used by the power
   allocator thermal governor (Hungyu Lin)

 - Fix code indentation in create_s32_tzp_attr() and rearrange it to
   use early return when applicable (Thorsten Blum)

 - Allow cross builds of the Intel thermal tests (Sasha Levin)

Thanks!


---------------

Hungyu Lin (1):
      thermal: Fix CPU mask truncation in power limit trace event

Sasha Levin (1):
      selftests/thermal: allow cross builds of the Intel tests

Thorsten Blum (1):
      thermal: sysfs: Fix indentation in create_s32_tzp_attr()

---------------

 drivers/thermal/thermal_sysfs.c                              |  8 ++++----
 drivers/thermal/thermal_trace.h                              |  4 ++--
 tools/testing/selftests/thermal/intel/power_floor/Makefile   | 12 +++++-------
 tools/testing/selftests/thermal/intel/workload_hint/Makefile | 12 +++++-------
 4 files changed, 16 insertions(+), 20 deletions(-)
