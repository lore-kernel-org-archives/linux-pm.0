From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/18] cpufreq: don't loose cpufreq history on CPU hotplug
Date: Thu, 29 Jan 2015 07:13:20 +0530
Message-ID: <CAKohpomt4x8qDJdT6GzAyegwop=WU0_VWEG1ArC1-E=H=OQOjQ@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<54C939ED.8090000@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34584 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274AbbA2BnV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jan 2015 20:43:21 -0500
Received: by mail-oi0-f52.google.com with SMTP id h136so22189390oig.11
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2015 17:43:20 -0800 (PST)
In-Reply-To: <54C939ED.8090000@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 29 January 2015 at 01:05, Saravana Kannan <skannan@codeaurora.org> wrote:
> @Viresh, thanks for taking up the patches and working on it. I wish I could
> have spent more time to get this in myself.

> For the patches that are very similar to the ones I sent out, could you
> please leave the author as me? I spent quite some time figuring out the
> different corner cases and coding it up and don't want to completely lose
> authorship for the work I did. Would appreciate it if you could accommodate
> that.

Actually I haven't applied any of your patches as is, but wrote them myself. On
some occasions they finally got similar to what you have done. Still I will
try to identify the ones which match exactly and mark you the author.

> I'll definitely review this. One thing that's not done in this patchset
> which I think should eventually be done (so, we should make sure we don't
> have any code that makes that harder to do in the future) is to allow
> setting the cpufreq parameters even when all the CPUs in the policy are
> offline. It's actually trivial for most of the parameters except a few
> governor specific tunables.

I disagree. The cpufreq-policy is inactive at that time and must not be updated
at all. I have specifically marked the policy inactive in this case and wouldn't
like to make the code unnecessarily complex without much need. If you have
a good case why you want it, then we can discuss.
