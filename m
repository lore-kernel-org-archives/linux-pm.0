From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 01/30] thermal: cpu_cooling: remove unused headers
Date: Wed, 24 Apr 2013 16:38:30 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092632CA077@SHSMSX101.ccr.corp.intel.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
 <1366218743-20841-2-git-send-email-eduardo.valentin@ti.com>
 <744357E9AAD1214791ACBA4B0B9092632CA053@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63675 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755094Ab3DXQjs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2013 12:39:48 -0400
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092632CA053@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Zhang, Rui
> Sent: Thursday, April 25, 2013 12:32 AM
> To: Eduardo Valentin; amit.kachhap@linaro.org
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 01/30] thermal: cpu_cooling: remove unused headers
> 
> 
> 
> > -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> > owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> > Sent: Thursday, April 18, 2013 1:12 AM
> > To: amit.kachhap@linaro.org
> > Cc: Eduardo Valentin; Zhang, Rui; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH 01/30] thermal: cpu_cooling: remove unused headers
> > Importance: High
> >
> > As this code is not a module nor a platform device driver, this patch
> > removes some unused header files.
> >
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> > ---
> >  drivers/thermal/cpu_cooling.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/thermal/cpu_cooling.c
> > b/drivers/thermal/cpu_cooling.c index 5f5c780..778c43d 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -20,10 +20,7 @@
> >   *
> >   *
> >
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ~
> > ~~~
> >   */
> > -#include <linux/kernel.h>
> > -#include <linux/module.h>
> 
> This is still needed because of EXPORT_SYMBOL.
> Or else, I get:
> drivers/thermal/cpu_cooling.c:225:1: warning: data definition has no
> type or storage class [enabled by default]
> drivers/thermal/cpu_cooling.c:225:1: warning: type defaults to int in
> declaration of EXPORT_SYMBOL_GPL [-Wimplicit-int]
> drivers/thermal/cpu_cooling.c:225:1: warning: parameter names (without
> types) in function declaration [enabled by default]
> drivers/thermal/cpu_cooling.c:479:1: warning: data definition has no
> type or storage class [enabled by default]
> drivers/thermal/cpu_cooling.c:479:1: warning: type defaults to int in
> declaration of EXPORT_SYMBOL_GPL [-Wimplicit-int]
> drivers/thermal/cpu_cooling.c:479:1: warning: parameter names (without
> types) in function declaration [enabled by default]
> drivers/thermal/cpu_cooling.c:505:1: warning: data definition has no
> type or storage class [enabled by default]
> drivers/thermal/cpu_cooling.c:505:1: warning: type defaults to int in
> declaration of EXPORT_SYMBOL_GPL [-Wimplicit-int]
> drivers/thermal/cpu_cooling.c:505:1: warning: parameter names (without
> types) in function declaration [enabled by default]
> 
Patch refreshed with keeping "#include <linux/module.h>" and applied.

> thanks,
> rui
> 
> >  #include <linux/thermal.h>
> > -#include <linux/platform_device.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/err.h>
> >  #include <linux/slab.h>
> > --
> > 1.8.2.1.342.gfa7285d
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> > the body of a message to majordomo@vger.kernel.org More majordomo
> info
> > at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html
