From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/6] cpufreq: suspend governors on system suspend/hibernate
Date: Wed, 27 Nov 2013 08:37:48 +0530
Message-ID: <CAKohpo=iSJSh_x3Xj3h-GRE6S25ptsdHf34MftMuD6JVSZw=rg@mail.gmail.com>
References: <cover.1385374819.git.viresh.kumar@linaro.org>
	<CAKohpok0E=m=63KXM22usiW7Rsu59cD7Q=+k3tRcW=8269tZnQ@mail.gmail.com>
	<4253729.doK7ubnxKx@vostro.rjw.lan>
	<4787675.sJF8mqYyxv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:47076 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab3K0DHt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2013 22:07:49 -0500
Received: by mail-oa0-f47.google.com with SMTP id k1so7069944oag.34
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2013 19:07:48 -0800 (PST)
In-Reply-To: <4787675.sJF8mqYyxv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Kgene Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-tegra@vger.kernel.org, jinchoi@broadcom.com, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>

On 27 November 2013 07:12, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Anyway, if you did what I asked you to do and put the cpufreq suspend/resume
> into dpm_suspend/resume_noirq(), I'd probably take this for 3.13.  However,
> since you've decided to put those things somewhere else thus making the
> change much more intrusive, I can only queue it up for 3.14.
>
> This means I'm going to take the Tianyu's patch as a stop gap for 3.13.

There were design issues with that patch actually, as I pointed out earlier
(handling EXIT part in core and INIT in governors).. And so in case we
need to get something for v3.13, I will send a short version of this series
with callbacks from suspend_noirq.

Get that one instead.

--
viresh
