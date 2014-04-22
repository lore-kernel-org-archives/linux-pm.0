From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 5/8] mfd: db8500-prcmu: Use cpufreq_for_each_entry
 macro for iteration
Date: Tue, 22 Apr 2014 08:15:41 +0100
Message-ID: <20140422071541.GA17657@lee--X1>
References: <534DB213.7080802@semaphore.gr>
 <5355A349.50908@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:50861 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbaDVHPs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 03:15:48 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so3437385wgg.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2014 00:15:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5355A349.50908@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> The cpufreq core now supports the cpufreq_for_each_entry macro helper
> for iteration over the cpufreq_frequency_table, so use it.
>=20
> It should have no functional changes.

> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---

It would be good to have a changelog which describes the differences
between the versions, so we can keep track.

>  drivers/mfd/db8500-prcmu.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

So it looks like I already applied v2 of this patch to my tree. What
changed in v3 and v4? Should I remove that patch from MFD and apply
this one instead?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
