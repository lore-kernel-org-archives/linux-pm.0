From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 06/18] cpufreq: Reuse policy list instead of per-cpu
 variable 'cpufreq_cpu_data'
Date: Thu, 12 Feb 2015 15:48:54 +0800
Message-ID: <CAKohpokqVhT3DNaLJWEWVuUV4UiQsVUjLh8oSrZ6dezeQSde0g@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<f3c1c9e77b044ec1f39b3a80f42cde45bb258f39.1422346933.git.viresh.kumar@linaro.org>
	<54DC1A4B.7060405@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36064 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114AbbBLHsz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 02:48:55 -0500
Received: by mail-ob0-f169.google.com with SMTP id wp4so8439287obc.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 23:48:54 -0800 (PST)
In-Reply-To: <54DC1A4B.7060405@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 12 February 2015 at 11:13, Saravana Kannan <skannan@codeaurora.org> wrote:
>> +struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>
> Rename this to cpufreq_cpu_get_unsafe or _nolock?

Its done in a later patch..

> Seems more descriptive. Hmm... you are just moving this function around. Ok,
> your call.

Yeah, as it has to be used earlier.

> For the current version of the patch series, this patch looks ok. But when
> you update it so that you don't have a separate "fallback policies list",
> the change you made to __cpufreq_add_dev in this patch might need more
> review.

Things will change, lets see how they look like..
