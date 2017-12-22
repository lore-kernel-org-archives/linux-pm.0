From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RESEND 1/1] cpufreq: imx6q: switch to Use clk_bulk_get to refine clk operations
Date: Fri, 22 Dec 2017 19:34:57 +0100
Message-ID: <2124437.LcYqgt3btA@aspire.rjw.lan>
References: <1504179837-18842-1-git-send-email-aisheng.dong@nxp.com> <20170914214032.GE11836@ubuntu> <20171221131733.GA24403@b29396-OptiPlex-7040>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171221131733.GA24403@b29396-OptiPlex-7040>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vireshk@kernel.org, shawnguo@kernel.org, Anson.Huang@nxp.com, Leonard Crestez <leonard.crestez@nxp.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 21, 2017 2:18:01 PM CET Dong Aisheng wrote:
> Hi Rafael,
> 
> On Thu, Sep 14, 2017 at 02:40:32PM -0700, Viresh Kumar wrote:
> > On 31-08-17, 19:43, Dong Aisheng wrote:
> > > Use clk_bulk_get to ease the driver clocks handling.
> > > 
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Anson Huang <anson.huang@nxp.com>
> > > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > --
> > > The original one is here which depends on clk_bulk APIs.
> > > https://patchwork.kernel.org/patch/9737337/
> > > Now the clk_bulk APIs are already in kernel, so resend the patch.
> > > (Patch title changed a bit to be more specific.)
> > > ---
> > >  drivers/cpufreq/imx6q-cpufreq.c | 125 ++++++++++++++++++----------------------
> > >  1 file changed, 56 insertions(+), 69 deletions(-)
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> 
> Would you help pick it?
> I did not see it in latest kernel.
> It still applies.

OK

Can you please resend the patch again with the ACK from Viresh?

It looks like it fell through the cracks, sorry about that.

Thanks,
Rafael
