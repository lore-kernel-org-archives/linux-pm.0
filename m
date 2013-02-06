From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 linux-next 1/2] cpufreq: Convert the
 cpufreq_driver_lock to a rwlock
Date: Wed, 6 Feb 2013 08:17:45 +0530
Message-ID: <CAKohpokQwpRqy2h5EwMjP3qxXgS9pqLL1=445J-pkMXgtA6vUA@mail.gmail.com>
References: <74F10842A85F514CA8D8C487E74474BB2D2F925E@P-EXMB1-DC21.corp.sgi.com>
	<1360116290-23849-1-git-send-email-nzimmer@sgi.com>
	<1360116290-23849-2-git-send-email-nzimmer@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:57442 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab3BFCrq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Feb 2013 21:47:46 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc18so952101obb.22
        for <linux-pm@vger.kernel.org>; Tue, 05 Feb 2013 18:47:45 -0800 (PST)
In-Reply-To: <1360116290-23849-2-git-send-email-nzimmer@sgi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

On 6 February 2013 07:34, Nathan Zimmer <nzimmer@sgi.com> wrote:
> This eliminates the contention I am seeing in __cpufreq_cpu_get.
> It also nicely stages the lock to be replaced by the rcu.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>
> ---
>  drivers/cpufreq/cpufreq.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
