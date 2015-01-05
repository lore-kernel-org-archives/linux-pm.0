From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 04/14] cpufreq: stats: pass 'stat' to cpufreq_stats_update()
Date: Mon, 5 Jan 2015 09:34:39 +0530
Message-ID: <CAKohpondSRi1ce5o_vcLUH7LBYiiSn4uuzFWphs9TPYXCSu_sA@mail.gmail.com>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
	<aec0c2c88ed01f32e2b5ea60c21f194b8049ef0f.1420177186.git.viresh.kumar@linaro.org>
	<3547984.Vd8ZHeRe7a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:50414 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbbAEEEj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jan 2015 23:04:39 -0500
Received: by mail-oi0-f43.google.com with SMTP id i138so41812784oig.2
        for <linux-pm@vger.kernel.org>; Sun, 04 Jan 2015 20:04:39 -0800 (PST)
In-Reply-To: <3547984.Vd8ZHeRe7a@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 4 January 2015 at 03:34, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> What about:
>
> "It is better to pass a struct cpufreq_stats pointer to cpufreq_stats_update()
>  instead of a CPU number, because ..."

Sure.

>> +static int cpufreq_stats_update(struct cpufreq_stats *stat)
>>  {
>> -     struct cpufreq_stats *stat;
>> -     unsigned long long cur_time;
>> +     unsigned long long cur_time = get_jiffies_64();
>>
>> -     cur_time = get_jiffies_64();
>
> Unrelated change.

Yeah, it was too small of a change so not that significant as well.
And so folded it into this commit only :(

Will send it separately in v3..
