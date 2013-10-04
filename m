From: Gene Heskett <gheskett@wdtv.com>
Subject: Re: [PATCH v2 3/6] PowerCap: Added to drivers build
Date: Fri, 4 Oct 2013 15:24:20 -0400
Message-ID: <201310041524.20634.gheskett@wdtv.com>
References: <1380904616-17519-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1380904616-17519-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wdtv.com ([66.118.69.84]:33250 "EHLO mail.wdtv.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167Ab3JDTbD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Oct 2013 15:31:03 -0400
In-Reply-To: <1380904616-17519-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com

On Friday 04 October 2013, Srinivas Pandruvada wrote:
>Added changes to Makefile and Kconfig to include in driver build.
>
>Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>---
> drivers/Kconfig  | 2 ++
> drivers/Makefile | 1 +
> 2 files changed, 3 insertions(+)
>
>diff --git a/drivers/Kconfig b/drivers/Kconfig
>index aa43b91..969e987 100644
>--- a/drivers/Kconfig
>+++ b/drivers/Kconfig
>@@ -166,4 +166,6 @@ source "drivers/reset/Kconfig"
>
> source "drivers/fmc/Kconfig"
>
>+source "drivers/powercap/Kconfig"
>+
> endmenu
>diff --git a/drivers/Makefile b/drivers/Makefile
>index ab93de8..34c1d55 100644
>--- a/drivers/Makefile
>+++ b/drivers/Makefile
>@@ -152,3 +152,4 @@ obj-$(CONFIG_VME_BUS)		+= vme/
> obj-$(CONFIG_IPACK_BUS)		+= ipack/
> obj-$(CONFIG_NTB)		+= ntb/
> obj-$(CONFIG_FMC)		+= fmc/
>+obj-$(CONFIG_POWERCAP)		+= powercap/

I would object to this whole premise if it is not under the absolute 
control of the users program. Linuxcnc for instance is intimately married 
to a parport whose status for writes is absolutely stable from write to 
write, and whose status may be in some cases, read at sub 20 u-second 
intervals.  Anything which would imped this, puts the operator of a 50+ ton 
piece of machinery's life in jeopardy because its status is not readable in 
as close to real time as possible as it may be required to initiate a stop 
from some alarm condition before it has moved far enough to injure, maim or 
kill. 50 thousandths of an inch in further movement while moving a 70 ton 
milling machines table at 150 inches a minute is not an unreasonable 
expectation for us.

Cheers, Gene
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)

Q: What does the CE in Windows CE stand for?
A: Caveat Emptor.
A pen in the hand of this president is far more
dangerous than 200 million guns in the hands of
         law-abiding citizens.
