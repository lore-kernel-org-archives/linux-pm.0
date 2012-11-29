From: Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6 v6] cpufreq, highbank: add support for highbank cpufreq
Date: Wed, 28 Nov 2012 20:34:36 -0800
Message-ID: <20121129043436.21126.714@nucleus>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-7-git-send-email-mark.langsdorf@calxeda.com>
 <20121128023240.GA28170@S2100-06.ap.freescale.net>
 <50B60E9C.9000405@calxeda.com>
 <20121128145759.GB28170@S2100-06.ap.freescale.net>
 <20121128151741.GC28170@S2100-06.ap.freescale.net>
 <20121128160115.21126.3841@nucleus>
 <20121129015133.GD28170@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121129015133.GD28170-+NayF8gZjK2ctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Langsdorf <mark.langsdorf-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Quoting Shawn Guo (2012-11-28 17:51:36)
> > The notifiers in the clk framework might be a better place for this than
> > just simply hacking the logic into the .set_rate callback.
> 
> Ah, right.  How did I forget about that nice piece?
> 
> > I haven't looked at the definition of hb_voltage_change but does the
> > call graph make any clk api calls?  Are you talking over i2c to a
> > regulator?  If so then you'll probably hit the same reentrancy problem I
> > hit when trying to make a general solution.
> 
> So, how is your "reentrancy in the common clk framework" series[1]
> going on?  Haven't seen any update since August.
> 

I've begun to look at a dvfs api that builds on top of the clock
framework, as opposed to using clk_set_rate as the dvfs api itself.
This eliminates the need for reentrancy, at least for the dvfs case.

I'll post more when I have it.  Honestly the reentrancy stuff was just
too ugly.  I might try again some day but for now I'm thinking a less
radical approach deserves consideration.

Thanks,
Mike

> Shawn
> 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/182198
