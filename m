From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [RFC PATCH 2/6] Introduce ACPI style match in platform_match
Date: Mon, 1 Oct 2012 14:00:17 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926322D953@SHSMSX101.ccr.corp.intel.com>
References: <1348817955.10877.322.camel@rui.sh.intel.com>
 <20121001064709.GG15548@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20121001064709.GG15548@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Len, Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@secretlab.ca>, Dirk Brandewie <dirk.brandewie@gmail.com>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Mika Westerberg
> Sent: Monday, October 01, 2012 2:47 PM
> To: Zhang, Rui
> Cc: LKML; linux-pm; linux-i2c; linux-acpi@vger.kernel.org; Len, Brown;
> Rafael J. Wysocki; Grant Likely; Dirk Brandewie
> Subject: Re: [RFC PATCH 2/6] Introduce ACPI style match in
> platform_match
> Importance: High
> 
> On Fri, Sep 28, 2012 at 03:39:15PM +0800, Zhang Rui wrote:
> > >From 5d7ecd12c2994b8c5905d52718c2870c3b62746e Mon Sep 17 00:00:00
> > >2001
> > From: Zhang Rui <rui.zhang@intel.com>
> > Date: Fri, 28 Sep 2012 14:51:03 +0800
> > Subject: [RFC PATCH 2/6] Introduce ACPI style match in platform_match
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/base/platform.c |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c index
> > a1a7225..90e64c6f 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/err.h>
> >  #include <linux/slab.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/acpi.h>
> >
> >  #include "base.h"
> >
> > @@ -635,6 +636,13 @@ static const struct platform_device_id
> *platform_match_id(
> >  			struct platform_device *pdev)
> >  {
> >  	while (id->name[0]) {
> > +#ifdef CONFIG_ACPI
> 
> I don't think the above is needed as you stub the acpi_match_device_id()
> out when !CONFIG_ACPI.
> 
You're right, I'll remove this.

> How about I2C and SPI slave devices?
> 
We're introduce the I2C/SPI bus ACPI binding, and the i2c/spi bus .match
method can be redirected to acpi callbacks.

Thanks,
rui 

