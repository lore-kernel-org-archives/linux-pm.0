From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH V2 3/4] cpufreq: schedutil: move slow path from workqueue
 to SCHED_FIFO task
Date: Thu, 24 Nov 2016 05:51:18 +0100
Message-ID: <20161124045118.GA18417@gmail.com>
References: <cover.1479197311.git.viresh.kumar@linaro.org>
 <09f8fe694b4491bfd20272e8c7dc0f13f35eb34e.1479197311.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34301 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753319AbcKXEvX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 23:51:23 -0500
Content-Disposition: inline
In-Reply-To: <09f8fe694b4491bfd20272e8c7dc0f13f35eb34e.1479197311.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>


* Viresh Kumar <viresh.kumar@linaro.org> wrote:

> +	/*
> +	 * For Real Time and Deadline tasks, schedutil governor shoots the
> +	 * frequency to maximum. And special care must be taken to ensure that
> +	 * this kthread doesn't result in that.
> +	 *
> +	 * This is (mostly) guaranteed by the work_in_progress flag. The flag is
> +	 * updated only at the end of the sugov_work() and before that schedutil
> +	 * rejects all other frequency scaling requests.
> +	 *
> +	 * Though there is a very rare case where the RT thread yields right
> +	 * after the work_in_progress flag is cleared. The effects of that are
> +	 * neglected for now.
> +	 */

s/schedutil governor/
  the schedutil governor

s/And special care must be taken/
  Special care must be taken

s/at the end of the sugov_work()/
  at the end of the sugov_work() function

s/before that schedutil rejects/
  before the schedutil governor rejects

s/Though there is a very rare case where
  There is a very rare case though, where

Thanks,

	Ingo
