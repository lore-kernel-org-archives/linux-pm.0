From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 04/14] cpufreq: stats: pass 'stat' to
 cpufreq_stats_update() *
Date: Mon, 5 Jan 2015 12:55:35 +0530
Message-ID: <CAKohpo=G6n7vfptvxgON3Lbz=ObBm1_GoNCFFOC1DawSwH4C=A@mail.gmail.com>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
	<aec0c2c88ed01f32e2b5ea60c21f194b8049ef0f.1420177186.git.viresh.kumar@linaro.org>
	<3547984.Vd8ZHeRe7a@vostro.rjw.lan>
	<CAKohpondSRi1ce5o_vcLUH7LBYiiSn4uuzFWphs9TPYXCSu_sA@mail.gmail.com>
	<OF5E9CEA82.619493CC-ONC1257DC4.0027BC08-C1257DC4.0027BC14@lonatigroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36427 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbbAEHZf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jan 2015 02:25:35 -0500
Received: by mail-oi0-f47.google.com with SMTP id v63so46795456oia.6
        for <linux-pm@vger.kernel.org>; Sun, 04 Jan 2015 23:25:35 -0800 (PST)
In-Reply-To: <OF5E9CEA82.619493CC-ONC1257DC4.0027BC08-C1257DC4.0027BC14@lonatigroup.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luigi Fioretti <luigi.fioretti@dinema.it>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Saravana Kannan <skannan@codeaurora.org>

On 5 January 2015 at 12:44, Luigi Fioretti <luigi.fioretti@dinema.it> wrote:
> Hi,
> thanks for your help but I don't think to be solution.
> I had apply this patch :
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December/036055.html
>
> You can read the first problems here:
> http://lists.linaro.org/pipermail/linaro-kernel/2014-March/012635.html
>
> I had found a solution to this problem, and I write to you into my first
> e-mail.
> Now I have this problems:
> When resume  and run this function

What does all this has to do with the mail below ?

> -----linaro-kernel-bounces@lists.linaro.org ha scritto: -----
> Per: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Da: Viresh Kumar
> Inviato da: linaro-kernel-bounces@lists.linaro.org
> Data: 05/01/2015 05.05AM
> Cc: Prarit Bhargava <prarit@redhat.com>, Lists linaro-kernel
> <linaro-kernel@lists.linaro.org>, Saravana Kannan <skannan@codeaurora.org>,
> "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
> Oggetto: Re: [PATCH V2 04/14] cpufreq: stats: pass 'stat' to
> cpufreq_stats_update() *
>
> On 4 January 2015 at 03:34, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> What about:
>>
>> "It is better to pass a struct cpufreq_stats pointer to
>> cpufreq_stats_update()
>>  instead of a CPU number, because ..."
>
> Sure.
>
>>> +static int cpufreq_stats_update(struct cpufreq_stats *stat)
>>>  {
>>> -     struct cpufreq_stats *stat;
>>> -     unsigned long long cur_time;
>>> +     unsigned long long cur_time = get_jiffies_64();
>>>
>>> -     cur_time = get_jiffies_64();
>>
>> Unrelated change.
>
> Yeah, it was too small of a change so not that significant as well.
> And so folded it into this commit only :(
>
> Will send it separately in v3..
>
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
