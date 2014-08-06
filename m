From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] Thermal: imx: add i.mx6sx thermal support
Date: Wed, 6 Aug 2014 09:10:46 +0800
Message-ID: <20140806011045.GC27051@dragon>
References: <1407229963-32662-1-git-send-email-b20788@freescale.com>
 <20140805132553.GA20291@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2lp0212.outbound.protection.outlook.com ([207.46.163.212]:13947
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753729AbaHFBLN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Aug 2014 21:11:13 -0400
Content-Disposition: inline
In-Reply-To: <20140805132553.GA20291@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Anson Huang <b20788@freescale.com>, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Aug 05, 2014 at 09:25:53AM -0400, Eduardo Valentin wrote:
> > @@ -31,6 +32,10 @@
> >  
> >  #define MISC0				0x0150
> >  #define MISC0_REFTOP_SELBIASOFF		(1 << 3)
> > +#define MISC1				0x0160
> > +#define MISC1_IRQ_TEMPHIGH		(1 << 29)
> > +#define MISC1_IRQ_TEMPLOW		(1 << 28)
> > +#define MISC1_IRQ_TEMPPANIC		(1 << 27)
> 
> how about using 
> +#define MISC1_IRQ_TEMPHIGH		BIT(29)
> +#define MISC1_IRQ_TEMPLOW		BIT(28)
> +#define MISC1_IRQ_TEMPPANIC		BIT(27)

While I agree this is good, I think it's more important to keep the
style consistent for the file.  We already have a number of (1 << x)
in the file.

...

> > @@ -66,6 +76,21 @@ enum imx_thermal_trip {
> >  #define FACTOR1				15976
> >  #define FACTOR2				4297157
> >  
> > +#define TEMPMON_V1			1
> > +#define TEMPMON_V2			2
> > +
> 
> where does the V1/V2 nomenclature come from? how about:
> 
> +#define TEMPMON_IMX6Q			1
> +#define TEMPMON_IMX6SX			2

+1

If the V1/V2 nomenclature is not coming from hardware manual, we don't
want to use it, neither code nor binding doc.

Shawn
