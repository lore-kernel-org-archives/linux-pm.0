From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V3 0/5] thermal: minor cleanup/fixes
Date: Mon, 13 Mar 2017 19:37:39 +0800
Message-ID: <1489405059.5841.23.camel@intel.com>
References: <cover.1489399567.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61523 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbdCMLhb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Mar 2017 07:37:31 -0400
In-Reply-To: <cover.1489399567.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dan.carpenter@oracle.com

On Mon, 2017-03-13 at 15:37 +0530, Viresh Kumar wrote:
> Hi,
> 
> This series contains minor fixes/cleanups for thermal cooling
> drivers.
> 
> V2->V3:
> - Added Acks from Rui
> - Resending as it was getting ignored until now :(

I just applied V2 this morning, and has not pushed to kernel.org yet.
The patch set should be queued for next -rc.

thanks,
rui
> 
> V1->V2:
> - s/dev_warn/dev_err (Rafael)
>   - Two new patches to make similar (^^) change at other places
> 
> Viresh Kumar (5):
>   thermal: devfreq: Simplify expression
>   thermal: devfreq_cooling: Replace dev_warn with dev_err
>   thermal: devfreq: Check OPP for errors
>   thermal: cpu_cooling: Replace dev_warn with dev_err
>   thermal: cpu_cooling: Check OPP for errors
> 
>  drivers/thermal/cpu_cooling.c     | 19 +++++++++++++------
>  drivers/thermal/devfreq_cooling.c | 14 ++++++++++----
>  2 files changed, 23 insertions(+), 10 deletions(-)
> 
