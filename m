From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] PM / Runtime: Add sysfs switch for
	disabling	device run-time PM (rev. 2)
Date: Fri, 5 Feb 2010 07:27:19 +0100
Message-ID: <20100205062718.GA1384__43094.5739652545$1265364500$gmane$org@ucw.cz>
References: <201001180129.55219.rjw@sisk.pl> <201001212359.38886.rjw@sisk.pl>
	<20100204224623.GB1436@ucw.cz> <201002050008.52699.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201002050008.52699.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> > > + *	The default for all devices is "auto", which means that devices may be
> > > + *	subject to automatic power management, depending on their drivers.
> > 
> > Is it wise to specify 'auto' default value for devices without runtime
> > pm?
> 
> Yes, it is.  It means the user space doesn't care whether or not the device is
> power managed at run-time.

Well, defaulting to 'on' for drivers when runtime pm is experimental
seems logical. and there will be such drivers...

> > > +		len = cp - buf;
> > > +	if (len == sizeof ctrl_auto - 1 && strncmp(buf, ctrl_auto, len) == 0)
> > > +		pm_runtime_allow(dev);
> > 
> > parenthesis after sizeof?
> 
> This notation is used throughout this file too.

...but is inconsistent with rest of kernel.

> > Do I read it correctly that all of
> > 
> > "auto"
> > "auto\n"
> > "auto\non\nIm confused"
> > 
> > will switch to auto?
> 
> Perhaps it would, but what exactly is the problem with that?

That apps will start depending on such broken behaviour?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
