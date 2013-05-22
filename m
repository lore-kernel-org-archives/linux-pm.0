From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC v2 0/3] LAB: Support for Legacy Application Booster governor
Date: Wed, 22 May 2013 14:37:33 +0530
Message-ID: <CAKohpokXNUmMbk0KOh58-0=sAs7yzD=cQe24eaoArpRSwM__Gg@mail.gmail.com>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:41687 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab3EVJHe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2013 05:07:34 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so2187147oag.18
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2013 02:07:33 -0700 (PDT)
In-Reply-To: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>, "Rafael J. Wysocky" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vicent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

On 3 May 2013 19:37, Jonghwa Lee <jonghwa3.lee@samsung.com> wrote:
> From: Lukasz Majewski <l.majewski@samsung.com>

> 2. New LAB governor.
> It calculates number of idle CPUs (based on scheduler data). On this basis it
> chose proper first level polynomial function for approximation.
> Moreover it enables overclocking when single, heavy loaded CPU is running.

Hi Lukasz,

I am still not sure about this governor. Do you have some results with which
you can tell how is it better than ondemand/conservative?

With or without overclocking. i.e. Apply only overclocking support to
ondemand/conservative..

If you are using Android, maybe check Interactive too (Though it itsn't
mainlined yet).

@Rafael: What do you think about this patchset?

--
viresh
