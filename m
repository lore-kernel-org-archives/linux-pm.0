From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: CPUFreq platform device registration question
Date: Wed, 26 Nov 2014 12:08:16 +0530
Message-ID: <CAKohpon07w1HX7nGu2ZDBeZ-3r9bvgtS4z2JTQj0A9n3omaTPA@mail.gmail.com>
References: <CAM4voamm0hw8h=XA1iBy62n3paY48G78bsG=hHf=4Cp+FoDPjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:57441 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbaKZGiR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 01:38:17 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so1727592obc.34
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 22:38:16 -0800 (PST)
In-Reply-To: <CAM4voamm0hw8h=XA1iBy62n3paY48G78bsG=hHf=4Cp+FoDPjg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chander Kashyap <k.chander@samsung.com>

On 26 November 2014 at 11:00, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> I am looking to add CPUFreq support for an arm64 based SoC (Exynos7).
> I have been using the generic cpufreq dt driver and have a question
> regarding this. For 32 bit platforms, we have been registering a dummy
> platform device in machine specific directories (like
> arch/arm/mach-exynos/exynos.c). However, since we do not have such
> directories for arm64, can you tell me what the best way to handle
> this would be.

We are doing rounds and rounds for these issues. We need to get this
from DT someway.

The easiest is to create a file in drivers/cpufreq for exynos 7 to create this
device for you.
