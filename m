From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/3] cpufreq:boost: CPU Boost mode support
Date: Wed, 12 Jun 2013 10:45:01 +0530
Message-ID: <CAKohpo=VpMvxMb-r4Hgga1ZM9m9egyUH_Ee+S=q25RdT7DAE-Q@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1370941408-29304-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:53588 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab3FLFPC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 01:15:02 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so12999628obb.14
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2013 22:15:01 -0700 (PDT)
In-Reply-To: <1370941408-29304-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>

On 11 June 2013 14:33, Lukasz Majewski <l.majewski@samsung.com> wrote:
> This patch series introduces support for CPU overclocking technique
> called Boost.
>
> It is a follow up of a LAB governor proposal. Boost is a LAB component:
> http://thread.gmane.org/gmane.linux.kernel/1484746/match=cpufreq
>
> Boost unifies hardware based solution (e.g. Intel Nehalem) with
> software oriented one (like the one done at Exynos).
> For this reason cpufreq/freq_table code has been reorganized to include
> common code.

To be honest, I haven't given a review to patches 2/3 and 3/3 as I am
concerned more about 1/3.

Maybe you can just send v3 of 1/3. 2/3 and 3/3 can be sent when we have
finalized 2/3 and 3/3 's version.
