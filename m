From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 2/7] thermal: rcar_gen3_thermal: fix probe error path
Date: Fri, 17 Mar 2017 11:12:14 +0100
Message-ID: <20170317101213.GC20587@bigcity.dyn.berto.se>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
 <20170306200401.29923-3-niklas.soderlund+renesas@ragnatech.se>
 <20170307195203.GB2554@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170307195203.GB2554@tetsubishi>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Wolfram,

Thanks for your feedback.

On 2017-03-07 20:52:03 +0100, Wolfram Sang wrote:
> On Mon, Mar 06, 2017 at 09:03:56PM +0100, Niklas Söderlund wrote:
> > If the memory resource for a TSC is unviable probe should fail not try
> > to go ahead with the remaining TSC. This fix is aligned with other
> > checks in probe where probe fails if they are unavailable.
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> I disagree. There are likely SoCs in the future which have less than
> TSC_MAX_NUM sensors (V3M shall have only 1 according to chapter 10C in
> v0.52 documentation). So, the code exits the loop for this case. We
> should move it before the devm_kzalloc(), however.

Ahh I did not think of that. I will drop this patch and instead do as 
you suggest move this before the devm_kzalloc().

> 
> That also means that you can't really iterate over TSC_MAX_NUM in later
> patches, but rather store the amount of instances in the main struct and
> iterate over that value.
> 

I will see how to best solve this, probably we need then to recoded in 
struct rcar_gen3_thermal_priv how many zones are in use so we can 
iterate over all active zones.

-- 
Regards,
Niklas Söderlund
