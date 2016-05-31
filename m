From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] cpufreq: Use sorted frequency tables
Date: Wed, 1 Jun 2016 00:50:41 +0200
Message-ID: <CAJZ5v0ig61Q+EDjjcyHef5e9B4dKY+BhF802uV61w-G5CdRQvA@mail.gmail.com>
References: <cover.1464694144.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38354 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbcEaWum (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 18:50:42 -0400
Received: by mail-wm0-f45.google.com with SMTP id a20so4022960wma.1
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 15:50:42 -0700 (PDT)
In-Reply-To: <cover.1464694144.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Steve Muckle <smuckle@linaro.org>

On Tue, May 31, 2016 at 1:36 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Guys,
>
> This work in inspired by some of the concerns raised by Steve in one of
> his patchset.
>
> Currently, the cpufreq drivers aren't required to provide a sorted list
> of frequencies to the cpufreq-core and so traversing that list match a
> target frequency is very inefficient.
>
> This is not bearable by, for example, the fast-switch path of schedutil
> governor and so we have moved the traversing logic local to the
> acpi-cpufreq driver for now. That is better handled in the core, but it
> has to be efficient.
>
> OTOH, even for traditional governors without a fast-switch path, it
> would be much better to be able to traverse this table quickly.
>
> The ideal solution would be to keep a single freq-table in struct
> cpufreq_policy, that will be sorted as well. But there are few
> dependencies due to which it can't be done today (Hint: cpufreq drivers
> are abusing the 'index' passed to them, to refer to multiple arrays).
>
> And so for now, lets create a separate table local to the cpufreq-core
> only.
>
> To use that, another API cpufreq_find_target_index() is created as well
> and few users are migrated to it.
>
> Lightly tested on Exynos board, frequencies were getting selected as
> expected.

I'm not particularly liking this due to the possible confusion that
may result from it.

Perhaps we can require drivers implementing ->fast_switch to sort
their frequency tables to start with?  Or maybe make the core check
whether or not the table is sorted and in what order and handle it
accordingly?

Let's just think about the design here for a while, OK?
