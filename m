From: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend to RAM
Date: Thu, 26 Aug 2010 18:15:34 +0200
Message-ID: <201008261815.34574.stephan.diestelhorst@amd.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201008241807.23519.stephan.diestelhorst@amd.com> <201008241811.22991.stephan.diestelhorst@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <201008241811.22991.stephan.diestelhorst@amd.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 24 August 2010 18:11:22 Stephan Diestelhorst wrote:
> On Tuesday 24 August 2010 18:07:23 Stephan Diestelhorst wrote:
> > On Monday 23 August 2010 14:03:40 Tejun Heo wrote:
> > > On 08/19/2010 06:23 PM, Stephan Diestelhorst wrote:
> > > > It says "max_performance", I have not touched anyhting. So it has been
> > > > like that all the time. Would this explain why your patch did not show
> > > > the debug printout?
> > > 
> > > Hmm... okay.  Yeah, if you haven't been using IPM at all, there won't
> > > be any debug messages but at the same time the posted patch should
> > > have had the same effect as Rafael's patch as IPM path isn't traveled
> > > at all.  Can you please check the followings?
> > > 
[...]
> > > * Rafael's patch actually fixes the problem.  If you haven't been
> > >   using IPM at all, Rafael's patch and mine should behave exactly the
> > >   same (ie. no IPM operation at all during suspend/resume).  It could
> > >   be that you're seeing a different issue.
> > 
> > That next on my list...

Just did the following: Rebased Rafaels patch to 2.6.35 and tried it
again (with added prints to make sure I am running the right one) and
did >10 suspend to ram / resume cycles under I/O write load. All of
them worked fine (for comparison: your patch resulted in RO HDD at
first attempt).

(I had some extra prints around the suspend functions changed in
 Rafael's patch, tried with and without, no change--works flawlessly.)

What do you make of this?

Thanks,
  Stephan
-- 
Stephan Diestelhorst, AMD Operating System Research Center
stephan.diestelhorst@amd.com, Tel. +49 (0)351 448 356 719

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

