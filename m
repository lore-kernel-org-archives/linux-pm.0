From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: linux-next: Tree for Mar 22 (thermal)
Date: Tue, 27 Mar 2018 02:09:00 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092636BF28012@SHSMSX101.ccr.corp.intel.com>
References: <20180322193847.63181403@canb.auug.org.au>
 <5449db25-c11e-68a1-532c-044689794aad@infradead.org>
 <20180326210524.GB1899@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180326210524.GB1899@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Eduardo Valentin [mailto:edubezval@gmail.com]
> Sent: Tuesday, March 27, 2018 5:05 AM
> To: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>; Linux-Next Mailing List <linux-
> next@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Linux PM list <linux-pm@vger.kernel.org>; Zhang,
> Rui <rui.zhang@intel.com>
> Subject: Re: linux-next: Tree for Mar 22 (thermal)
> Importance: High
> 
> Rui,
> 
> On Thu, Mar 22, 2018 at 10:36:38AM -0700, Randy Dunlap wrote:
> > On 03/22/2018 01:38 AM, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Changes since 20180321:
> > >
> > > The vfs tree still had its build failure for which I reverted a commit.
> > >
> >
> > on i386:
> >
> > ERROR: "nsec_to_clock_t" [drivers/thermal/thermal_sys.ko] undefined!
> >
> > so in drivers/thermal/thermal_sysfs.c, please add:
> >
> > #include <linux/jiffies.h>
> >
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Are you taking care of this?
> 
No, I missed that email.
Will check it today.

Thanks,
rui
> >
> > thanks,
> > --
> > ~Randy
