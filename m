From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/2] Tick: Introduce tick_nohz_check() to check nohz
 enable status
Date: Fri, 15 Nov 2013 16:05:58 +0530
Message-ID: <CAKohpomwb4iAaBkHd=N_UqWJUemCZ_QnYTy=sUDsJ0nerjz9rw@mail.gmail.com>
References: <1383036537-30362-1-git-send-email-tianyu.lan@intel.com>
	<1384504535-29987-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:43366 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab3KOKf6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2013 05:35:58 -0500
Received: by mail-oa0-f45.google.com with SMTP id m1so3720077oag.18
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2013 02:35:58 -0800 (PST)
In-Reply-To: <1384504535-29987-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: dipankar@in.ibm.com, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, =?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steven Rostedt <rostedt@goodmis.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 15 November 2013 14:05, Lan Tianyu <tianyu.lan@intel.com> wrote:
> In some cases, nohz enable status needs to be checked. E.G, in RCU and cpufreq
> ondemand governor. So add tick_nohz_check() to return tick_nohz_enabled value
> And use tick_nohz_check() instead of referencing tick_nohz_enabled in the rcutree_plugin.h.
>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>
> Change since V2:
>         Add ACCESS_ONCE to tick_nohz_check().
>
>  include/linux/tick.h     | 2 ++
>  kernel/rcutree_plugin.h  | 4 +---
>  kernel/time/tick-sched.c | 8 +++++++-
>  3 files changed, 10 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
