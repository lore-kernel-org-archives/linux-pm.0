From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V3] Thermal: imx: add i.mx6sx thermal support
Date: Sat, 9 Aug 2014 21:25:47 +0800
Message-ID: <20140809132544.GA8981@dragon>
References: <1407309129-5562-1-git-send-email-b20788@freescale.com>
 <20140807085024.GE27051@dragon>
 <CAC-25o_C1ijr64NyA22JqfS9Z90-v9iseaYzcf1ojy_QNXzExA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2lp0209.outbound.protection.outlook.com ([207.46.163.209]:23008
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750900AbaHIN0I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 9 Aug 2014 09:26:08 -0400
Content-Disposition: inline
In-Reply-To: <CAC-25o_C1ijr64NyA22JqfS9Z90-v9iseaYzcf1ojy_QNXzExA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "edubezval@gmail.com" <edubezval@gmail.com>
Cc: Anson Huang <b20788@freescale.com>, Zhang Rui <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Aug 08, 2014 at 08:15:54AM -0400, edubezval@gmail.com wrote:
> Hello Shawn,
> 
> On Thu, Aug 7, 2014 at 4:50 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Wed, Aug 06, 2014 at 03:12:09PM +0800, Anson Huang wrote:
> >> i.MX6SX has some new features of thermal interrupt function,
> >> there are LOW, HIGH and PANIC irq for thermal sensor, so add
> >> platform data to separate different thermal version;
> >>
> >> The reset value of LOW ALARM is 0 which means the highest
> >> temp, so the LOW ALARM will be triggered once irq is enabled,
> >> so we need to correct it before enabling thermal irq;
> >>
> >> Enable PANIC ALARM as critical trip point, it will trigger
> >> system reset via SRC module once PANIC IRQ is triggered, it
> >> is pure hardware function, so use it instead of software
> >> reset by cooling device.
> >>
> >> Signed-off-by: Anson Huang <b20788@freescale.com>
> >
> > Tested-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Thanks!
> 
> Did you have the chance to test on both? i.MX6Q and i.MX6SX?

Yes, I did test on both i.MX6Q and i.MX6SX.

Shawn
