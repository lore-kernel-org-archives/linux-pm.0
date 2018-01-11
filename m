From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 RESEND] cpufreq: pxa: convert to clock API
Date: Thu, 11 Jan 2018 18:26:18 +0100
Message-ID: <87inc8b939.fsf@belgarion.home>
References: <20171014215102.10424-1-robert.jarzmik@free.fr>
        <87mv1kbyth.fsf@belgarion.home> <20180111083519.GG3626@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:20184 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935307AbeAKR0W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jan 2018 12:26:22 -0500
In-Reply-To: <20180111083519.GG3626@vireshk-i7> (Viresh Kumar's message of
        "Thu, 11 Jan 2018 14:05:19 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 11-01-18, 09:10, Robert Jarzmik wrote:
>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>> 
>> > As the clock settings have been introduced into the clock pxa drivers,
>> > which are now available to change the CPU clock by themselves, remove
>> > the clock handling from this driver, and rely on pxa clock drivers.
>> >
>> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > ---
>> > This is a resend of a formerly acked patch as all dependencies have
>> > hit upstream, see :
>> > 	https://www.spinics.net/lists/arm-kernel/msg540181.html
>> > ---
>> >  drivers/cpufreq/pxa2xx-cpufreq.c | 191 ++++++++-------------------------------
>> >  1 file changed, 39 insertions(+), 152 deletions(-)
>> 
>> Hi Rafael,
>> 
>> Would you consider taking this patch in ? It was submitted and acked a long ago,
>> and as the above mail says, the dependencies have hit mainline for quite some
>> time now.
>
> Check linux-next.
>
> d9278077385f cpufreq: pxa: convert to clock API
Thanks and sorry for the noise.

Cheers.

-- 
Robert
