From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH RESEND 1/1] cpufreq: imx6q: switch to Use clk_bulk_get to
 refine clk operations
Date: Thu, 21 Dec 2017 21:18:01 +0800
Message-ID: <20171221131733.GA24403@b29396-OptiPlex-7040>
References: <1504179837-18842-1-git-send-email-aisheng.dong@nxp.com>
 <20170914214032.GE11836@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170914214032.GE11836@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vireshk@kernel.org, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, Leonard Crestez <leonard.crestez@nxp.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Thu, Sep 14, 2017 at 02:40:32PM -0700, Viresh Kumar wrote:
> On 31-08-17, 19:43, Dong Aisheng wrote:
> > Use clk_bulk_get to ease the driver clocks handling.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Anson Huang <anson.huang@nxp.com>
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > --
> > The original one is here which depends on clk_bulk APIs.
> > https://patchwork.kernel.org/patch/9737337/
> > Now the clk_bulk APIs are already in kernel, so resend the patch.
> > (Patch title changed a bit to be more specific.)
> > ---
> >  drivers/cpufreq/imx6q-cpufreq.c | 125 ++++++++++++++++++----------------------
> >  1 file changed, 56 insertions(+), 69 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Would you help pick it?
I did not see it in latest kernel.
It still applies.

Regards
Dong Aisheng
