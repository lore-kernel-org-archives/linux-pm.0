From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 linux-next 2/2] cpufreq: Convert the
 cpufreq_driver_lock to use the rcu
Date: Wed, 6 Feb 2013 08:22:57 +0530
Message-ID: <CAKohpo=3qnhtVOniYWPJQLSkAnhMkYj8_yvHR+QE46Pzdi=WhA@mail.gmail.com>
References: <74F10842A85F514CA8D8C487E74474BB2D2F925E@P-EXMB1-DC21.corp.sgi.com>
	<1360116290-23849-1-git-send-email-nzimmer@sgi.com>
	<1360116290-23849-3-git-send-email-nzimmer@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:57467 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551Ab3BFCw7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Feb 2013 21:52:59 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so965181obb.28
        for <linux-pm@vger.kernel.org>; Tue, 05 Feb 2013 18:52:58 -0800 (PST)
In-Reply-To: <1360116290-23849-3-git-send-email-nzimmer@sgi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

On 6 February 2013 07:34, Nathan Zimmer <nzimmer@sgi.com> wrote:
> In general rwlocks are discourged so we are moving it to use the rcu instead.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>
> ---
>  drivers/cpufreq/cpufreq.c | 173 +++++++++++++++++++++++++---------------------
>  1 file changed, 96 insertions(+), 77 deletions(-)

bleeding-edge got updated again and this patch would have conflicts :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
