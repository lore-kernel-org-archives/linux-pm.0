From: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend to RAM
Date: Tue, 24 Aug 2010 18:07:23 +0200
Message-ID: <201008241807.23519.stephan.diestelhorst@amd.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201008191823.57915.stephan.diestelhorst@amd.com> <4C72639C.6090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <4C72639C.6090108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Monday 23 August 2010 14:03:40 Tejun Heo wrote:
> On 08/19/2010 06:23 PM, Stephan Diestelhorst wrote:
> > It says "max_performance", I have not touched anyhting. So it has been
> > like that all the time. Would this explain why your patch did not show
> > the debug printout?
> 
> Hmm... okay.  Yeah, if you haven't been using IPM at all, there won't
> be any debug messages but at the same time the posted patch should
> have had the same effect as Rafael's patch as IPM path isn't traveled
> at all.  Can you please check the followings?
> 
> * You're actually running the correct patched kernel and modules.  It
>   probably is a good idea to add a printk message.  ie. Apply the
>   patch and add a printk() in ata_host_request_pm() in libata-core.c
>   and make sure the debug messages appears.

Did that. Actually also added some printks to the XXX function, called
early during boot. Output confirms that your patch is loaded. And even
on the first resume the machine dies.

> * Rafael's patch actually fixes the problem.  If you haven't been
>   using IPM at all, Rafael's patch and mine should behave exactly the
>   same (ie. no IPM operation at all during suspend/resume).  It could
>   be that you're seeing a different issue.

That next on my list...

Many thanks!

Stephan

-- 
Stephan Diestelhorst, AMD Operating System Research Center
stephan.diestelhorst@amd.com, Tel. +49 (0)351 448 356 719

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

