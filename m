From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: CPUFreq platform device registration question
Date: Wed, 26 Nov 2014 11:00:04 +0530
Message-ID: <CAM4voamm0hw8h=XA1iBy62n3paY48G78bsG=hHf=4Cp+FoDPjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:41670 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaKZFaE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 00:30:04 -0500
Received: by mail-qa0-f48.google.com with SMTP id v10so1464904qac.21
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 21:30:04 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chander Kashyap <k.chander@samsung.com>

Hi,

I am looking to add CPUFreq support for an arm64 based SoC (Exynos7).
I have been using the generic cpufreq dt driver and have a question
regarding this. For 32 bit platforms, we have been registering a dummy
platform device in machine specific directories (like
arch/arm/mach-exynos/exynos.c). However, since we do not have such
directories for arm64, can you tell me what the best way to handle
this would be.

Regards,
Abhilash
