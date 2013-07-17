From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 7/7] Documentation:cpufreq:boost: Update BOOST documentation
Date: Wed, 17 Jul 2013 10:52:18 +0530
Message-ID: <CAKohponeZ15ruJA9__V70u1Ztr4F9aT+zBinMT5Ewyew53rbyQ@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1372927830-2949-1-git-send-email-l.majewski@samsung.com>
	<1372927830-2949-8-git-send-email-l.majewski@samsung.com>
	<CAKohpo=oB_4gGtNn6jvxSCp665pOq6oqeTCCyGzmN_eWqt0Lhg@mail.gmail.com>
	<20130716133319.49ed0838@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44950 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab3GQFWT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2013 01:22:19 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so1736170obb.5
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2013 22:22:18 -0700 (PDT)
In-Reply-To: <20130716133319.49ed0838@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>

On 16 July 2013 17:03, Lukasz Majewski <l.majewski@samsung.com> wrote:
> As fair as I've understood our previous discussion (at [*]) we have
> agreed about this. We only export boost attribute when it is supported
> by cpufreq_driver. Rafael was very clear about exporting boost
> attribute:
>
> "Simple: Export it only when supported."
>
> [*]: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core

I don't want to search in the Archives but I am sure what we decided
earlier.

Rafael Said:
"Simple: Export it only when supported."

AND

"Don't change behavior of acpi-cpufreq driver"

If you see acpi-cpufreq driver carefully, it always creates "boost"
sysfs entry. If its not supported then it creates a read only entry.

So, please preserve that.
