From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: linux-next: Tree for Mar 22 (thermal)
Date: Mon, 26 Mar 2018 14:05:27 -0700
Message-ID: <20180326210524.GB1899@localhost.localdomain>
References: <20180322193847.63181403@canb.auug.org.au>
 <5449db25-c11e-68a1-532c-044689794aad@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5449db25-c11e-68a1-532c-044689794aad@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Rui,

On Thu, Mar 22, 2018 at 10:36:38AM -0700, Randy Dunlap wrote:
> On 03/22/2018 01:38 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20180321:
> > 
> > The vfs tree still had its build failure for which I reverted a commit.
> > 
> 
> on i386:
> 
> ERROR: "nsec_to_clock_t" [drivers/thermal/thermal_sys.ko] undefined!
> 
> so in drivers/thermal/thermal_sysfs.c, please add:
> 
> #include <linux/jiffies.h>
> 
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Are you taking care of this?

> 
> thanks,
> -- 
> ~Randy
