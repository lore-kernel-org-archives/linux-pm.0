From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/5] cpufreq, dbs_data->usage count must be atomic
Date: Tue, 11 Nov 2014 09:10:13 +0530
Message-ID: <CAKohpon9XOdrHW2HyctWmadT=F2NH8KLn7SMBE-hPLMAbTs+ZA@mail.gmail.com>
References: <1415199239-19019-1-git-send-email-prarit@redhat.com>
	<1415199239-19019-4-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:59602 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaKKDkN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 22:40:13 -0500
Received: by mail-oi0-f41.google.com with SMTP id e131so6482864oig.28
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2014 19:40:13 -0800 (PST)
In-Reply-To: <1415199239-19019-4-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 5 November 2014 20:23, Prarit Bhargava <prarit@redhat.com> wrote:
> The usage_count value can be modified from several cpus concurrently if
> !CPUFREQ_HAVE_GOVERNOR_PER_POLICY.  This leads to a variety of panics in
> which the usage_count is negative or exceeds the number of cpus in the
> system.  It must be switched to atomic_t and protected with a mutex to make sure
> that future read/writes obtain the correct data.

I think it would be best to serialize calls to ->governor() with some
locking in place
instead of adding per-variable locks. There can be other points of
contention as well.

I have done something similar in the solution I tried. Can pick some
of those patches.
