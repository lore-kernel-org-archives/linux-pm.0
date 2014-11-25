From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating
 cpufreq table
Date: Tue, 25 Nov 2014 20:56:00 +0530
Message-ID: <CAKohpomFOJWc4C9rWbCmcW7e1kUO=C=awO9RFvBVA0-H2dHjZQ@mail.gmail.com>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
	<20141124181049.GB1449@developer>
	<CAKohpokF8qFUz-bmKT61L879L60GYzsc3X3BRHofLYWAdHa3rg@mail.gmail.com>
	<20141125014435.GA28906@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:49400 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaKYP0B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 10:26:01 -0500
Received: by mail-qg0-f53.google.com with SMTP id q108so554116qgd.26
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 07:26:00 -0800 (PST)
In-Reply-To: <20141125014435.GA28906@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>

On 25 November 2014 at 07:14, Eduardo Valentin <edubezval@gmail.com> wrote:
> You are right! I got confused because even with your patch, the
> sequencing is not working. Looking to that behavior I, somehow, thought
> the _init function in cpufreq-dt was about init() calls. But in fact, it
> is driver initialization callback.

:)

> However, by the time of ->init() the cpufreq_driver is not really ready.

I agree.

> Or at least, the cpufreq layer is not ready. A call to
>
> cpufreq_frequency_get_table()
>
> for instance, it is not working.

I know the story you pasted here :)

> The cpufreq-dt would need to add the of based cpufreq cooling only when
> cpufreq layer is ready. Any other better cpufreq driver callback to add
> the cpu cooling?

There is nothing as of now atleast.

> We could sort this out by polling in thermal layer for the cpufreq table
> until it gets ready, but I believe that would be a dirty hack.

Yeah. Probably we can add a notifier for cpufreq-driver addition/removal.
That's the best we can do I believe.
