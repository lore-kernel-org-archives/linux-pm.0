From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: imx6: remove pu regulator dependency for SOCs
 with no PU regulator
Date: Fri, 20 Jun 2014 14:00:10 +0530
Message-ID: <CAKohpo=h=r+Ec25-=gVthTVRsaeE-Oie4c9h3xE5AUP7j6dgGQ@mail.gmail.com>
References: <1403250138-25030-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:52218 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbaFTIaK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jun 2014 04:30:10 -0400
Received: by mail-oa0-f51.google.com with SMTP id j17so7021317oag.10
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2014 01:30:10 -0700 (PDT)
In-Reply-To: <1403250138-25030-1-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@freescale.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 20 June 2014 13:12, Anson Huang <b20788@freescale.com> wrote:
> PU regulator is not a necessary regulator for cpufreq, not all
> i.MX6 SoCs have PU regulator, only if SOC has PU regulator, then its
> voltage must be equal to SOC regulator, so remove the dependency
> to support i.MX6SX which has no PU regulator.
>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c |   35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
