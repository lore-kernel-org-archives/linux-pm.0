From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: loongson2_cpufreq fails in 3.14
Date: Wed, 2 Apr 2014 10:17:57 +0530
Message-ID: <CAKohpomWUsL5X6PZkaAdz5P2Zs4cyeHsLRkErJ2Y6aADn54N0g@mail.gmail.com>
References: <ory4zoiom4.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:62286 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbaDBEr5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Apr 2014 00:47:57 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so12107653oag.25
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2014 21:47:57 -0700 (PDT)
In-Reply-To: <ory4zoiom4.fsf@livre.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Oliva <lxoliva@fsfla.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 2 April 2014 05:33, Alexandre Oliva <lxoliva@fsfla.org> wrote:
> I've just built 3.14 for my yeeloong, and it's *slow*.  If I run
> cpufreq-info, it freezes.  If I unload loongson2_cpufreq, it freezes
> too.  I haven't started bisecting yet, but I found it odd that your
> patch 652ed95d5f introduced *cpuclk as a *static* variable in
> loongson2_cpufreq_cpu_init.  I don't see any point in making it static.
> Why can't it be automatic?  Was the static just a cut&pasto from moving
> the variable into the function?

Hmm, that was a mistake and I have just sent a patch to get that fixed.
But I don't really think that the 'static' thing would make your driver worse.
So, please do a bisect and let us know what broke your platform :)

--
viresh
