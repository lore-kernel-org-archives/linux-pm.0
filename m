Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2852A38B122
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454905; cv=none; b=PlZndmNZF+INyoNO0+NgKNmW2Vjt8VubSawluprbnD7JT/AutvIX4Hjwp9i2bSddZNZxQ+pJZqGpsU7gzdoD0c2VYAB5tQumLcE4C0qB3MfgKofS1AQHdu81EoFz9ddvuqysIr413vWlAdkKrKgTw4W8fBfFWRZbtDSaxo8/FT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454905; c=relaxed/simple;
	bh=qG2fpS8Bp8PBVnw1VsQ3FC3OcFZwdseL7ptkKXKtlJw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dacxhvQ2am5iO6gaE6LkQh8jsuEW+99jdeka29VWWpGIowg/koTSaZ7Q6FEzBlutXNkDswQqnXrsg0txMs8qvEBY/jQoppgy1va444RdvlfKsUHyG4w5qFBRLRVQ6czlmpBXoHNWmt/T7H5IfBZ1aDirvNUF8Y0AjepRRJ9w4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4c4Yoqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4c4Yoqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9F61F00A3E
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454904;
	bh=ia2a5ddOD6+3aaTxcULmJ18Vjiomx635zcxNcvdP1gE=;
	h=From:Date:Subject:To:Cc;
	b=j4c4YoqhmgD7vEVJ8qtVOIFCVvPQUXHXv9EEgZ+Oy9SQvYzOqGjVRlFP2Fiyqocl+
	 xRVeTrDA40244Ue4SVutN/Z55TaWHxVEq4fbGhXicEvl2JBbvpW2cUCxM6lf9/XwBz
	 fkKXAbSAfG9Ii3nSvjjEt9g39agiPu2+W7IBNoEruj8rQiX00wD6KhWOe4JnDPVe0w
	 PX48RrZ8lAGgumM0MznWR7IZO2Kq16BiFUsW9/C/gYlu36OOrV8+N7kF+YXny3BoJo
	 GEy0p7W49ag7lUFEx/G5R4dXO16+A/tKZgFEaScrN9qLIk/nbrWbrqBOOo2nD/8bcA
	 2no9SUMxolSaA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a877510541so8425076e87.2
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 06:01:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+26BjHggRUNfdcxltoDpikBJ1/ZFON/DdTJ7NHVnX5fPJD4YvTpZaVNvpqNMs8MOovGlU5vsjTKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdykvsYMpXCuIoIYwGZGudH0JqRJnaFXvLhm+thQWm8sv1ldWp
	XCrWrqdsCcEHsnnREhg3XopWQiBMOKbox7MpPi2TbkDRrV/Br76nxAirbZ8R2l8uHIfljMyfjmL
	AUMA4bFJ4S1J4PcL43AqdVdQzNlNHZ2o=
X-Received: by 2002:a05:6512:131e:b0:5aa:10e2:29ab with SMTP id
 2adb3069b0e04-5aa32397b7bmr1217511e87.18.1779454891032; Fri, 22 May 2026
 06:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 15:01:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hcQ4bOP_5krEuPCVasPYfJxCjq1s4+ot6bCyhAtpFmkg@mail.gmail.com>
X-Gm-Features: AVHnY4IpAjG-EGAqLgAfm-IfCQn4MNT_0R4Xfzd8yU9-N1FyxCZft1iwbmzXSes
Message-ID: <CAJZ5v0hcQ4bOP_5krEuPCVasPYfJxCjq1s4+ot6bCyhAtpFmkg@mail.gmail.com>
Subject: [GIT PULL] ACPI support fix for v7.1-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.1-rc5

with top-most commit c35cb4fc7231702d1e9952aec1a442f3e27df6f5

 ACPI: battery: Fix system wakeup on critical battery status

on top of commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8

 Linux 7.1-rc4

to receive an ACPI support fix for 7.1-rc5.

This unbreaks system wakeup on critical battery status in the ACPI
battery driver inadvertently broken during the 7.0 development cycle.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: battery: Fix system wakeup on critical battery status

---------------

 drivers/acpi/battery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
