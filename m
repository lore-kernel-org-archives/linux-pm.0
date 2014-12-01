From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/8] arm_big_little: free OPP table created during ->init()
Date: Mon, 1 Dec 2014 12:41:59 +0530
Message-ID: <CAKohpom2tLb6Krq94xsU9ra22ErNV=j6f5QCoR3ctaRj43=Jcw@mail.gmail.com>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
	<b5fca3025ec6411bb134306059c119b6b58f5ee2.1416910766.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:55896 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbaLAHMA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 02:12:00 -0500
Received: by mail-ob0-f172.google.com with SMTP id wn1so7548820obc.31
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2014 23:11:59 -0800 (PST)
In-Reply-To: <b5fca3025ec6411bb134306059c119b6b58f5ee2.1416910766.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

On 25 November 2014 at 16:04, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> OPP layer now supports freeing of OPPs and we should free them once they aren't
> useful anymore.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/arm_big_little.c    | 7 ++++++-
>  drivers/cpufreq/arm_big_little.h    | 5 ++++-
>  drivers/cpufreq/arm_big_little_dt.c | 1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)

Looks like you missed applying this one from this series ?
