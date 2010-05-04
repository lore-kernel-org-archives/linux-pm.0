From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.33-2.6.34-rc5 suspend issues
Date: Tue, 4 May 2010 06:18:50 +0200
Message-ID: <20100504041849.GA1262@ucw.cz>
References: <20100427074609.GA3261@ikn.schottelius.org>
 <20100427083202.GA3143@ikn.schottelius.org>
 <20100428160935.GA4010@schottelius.org>
 <20100429191241.GA3407@schottelius.org>
 <20100501122441.GA3273@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100501122441.GA3273@schottelius.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nico Schottelius <nico-linux-20100427@schottelius.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2010-05-01 14:24:41, Nico Schottelius wrote:
> Nico Schottelius [Thu, Apr 29, 2010 at 09:12:42PM +0200]:
> > Nico Schottelius [Wed, Apr 28, 2010 at 06:09:36PM +0200]:
> > > Nico Schottelius [Tue, Apr 27, 2010 at 10:32:02AM +0200]:
> > > > 
> > > > Nico Schottelius [Tue, Apr 27, 2010 at 09:46:09AM +0200]:
> > > > > [..] 
> > > > > - suspend & resume works once
> > > > > - second time system
> > > > >   b) suspends, but comes up with the bios screen after resume
> > > > >      and hangs there forever (2.6.34-*)
...
> Same happens on 2.6.34-rc5-00340-g79dba2e, now testing
> 2.6.34-rc6-00063-gbe1066b.

There's one bit that needs to be set to stay in the acpi mode, and
there's blacklist somewhere...?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
