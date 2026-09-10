Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA646EC6C
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065830; cv=none; b=CmRD+v7cFLlAgtbxMZxMt1tQkenKVv+RLcgZqAIHeJEO1H7fp63EDV6TiHbapAGeZNLnvs0+Yl6N25uXpT8fC1X8t7r2Gkx7Nl0IE/zuslv0uZcao3UsirM1I8BjYi1vlcYdlc6vSNozJDGC5jEf0Kzzu6mMxEm7d0T6ijq4hyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065830; c=relaxed/simple;
	bh=CzOLFf01jrlECz3kkiAI/PQhyIg6Nm9A/E19QSy30/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TsqKnC7zoBn4NClF7+F8xLUW5mc5aMmW+5udo6OW5wngStqofUrOCK3i35gqLXQoEEcciaaGhM77RWLBSU8SOgaV2IlhSDReJM4jZ01iHyhR27GIeq7+qM6piNJjtSUFu7rMc1gvgOOYeNWhG5ef22LbTp8rsaQ64sqttd0yNQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJmvM1zb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJmvM1zb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01951F00893
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 18:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789065828;
	bh=7fXv85CXNeQf5/ACIK20zObOnuXNRCrEK97tfYFgOO0=;
	h=From:Date:Subject:To:Cc;
	b=DJmvM1zbZrTUYdwbck1XSp0IJleDipWqlFbtEbdT8tdS8kaYN/T5t6Ldxy367Wwl+
	 85/wxFh+q6Ve6fkNYRZVkhRhbRTDn6eH55kzQfaCKrYA5o2o3ZkkyxarBgYcSl8qlU
	 ydg/JEaFUQ/Rc2hCsRRFsGkFRZoqI624TsAVltR0N9PyJ3n1HhyTw1pdf/I3xFSSeM
	 znDzneOnvGW1sb+LDM/tUCIK9DLZ9r3fMXZHaXHQqox4jBnKd4hQDrVcAc1BZGGpZV
	 WkX5CMHsxPz1PBRxOaYCp3DrvwGHuLldEOPbZrGezcKS5aDrA56h5K70kHhcCCAYVC
	 xx8+QyQ2e2p+w==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f16so141228e87.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 11:43:48 -0700 (PDT)
X-Gm-Message-State: AFuF++nkBE36sU2x9YyvGi3ykM997CZrZQdnxovcCVqAkDNB3P/6WORm
	u/KVh9okLRc/vKF2FNM9E69aHN28LDppt1Zgl319bojw7ytUSTssdMEAYvJD8dy7Ob54vmw3Ynu
	URnnKjwWQHxeNgl4ixA7WId+Q3R9ZHcQ=
X-Received: by 2002:a05:6512:2395:b0:5b1:5ccf:5268 with SMTP id
 2adb3069b0e04-5b8a02dcebemr253654e87.1.1789065827036; Thu, 10 Sep 2026
 11:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 10 Sep 2026 20:42:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hu=AqKVTSoLbid21uYiwBJpWQv3_3e4eZwge-DHdwLVA@mail.gmail.com>
X-Gm-Features: AcwNN1Uqo16JGGE55ShEDwXxtd9xrUD2-5Bp3HEmCwhtMik5RKv2kjCYRwFOC9k
Message-ID: <CAJZ5v0hu=AqKVTSoLbid21uYiwBJpWQv3_3e4eZwge-DHdwLVA@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for 7.3-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.3-rc3

with top-most commit 5ad0af4f4367202b1bc71813052fe39b5116cdb9

 thermal: sysfs: switch to use scnprintf() to suppress truncation warning

on top of commit cee9395acd8043be0644b25c34bfa86623f2b935

 Linux 7.3-rc1

to receive a thermal control fix for 7.3-rc3.

This replaces snprintf() with scnprintf() in the thermal core sysfs code
to avoid compiler warnings about potential truncation of the names of
the sysfs attributes (Andy Shevchenko)

Thanks!


---------------

Andy Shevchenko (1):
      thermal: sysfs: switch to use scnprintf() to suppress truncation warning

---------------

 drivers/thermal/thermal_sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
