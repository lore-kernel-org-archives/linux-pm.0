From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3][update] PM / sleep: Introduce command line
 argument for sleep state enumeration
Date: Tue, 10 Jun 2014 21:59:05 +0200
Message-ID: <20140610195905.GA6805@amd.pavel.ucw.cz>
References: <1817539.9KW2IGGbDV@vostro.rjw.lan>
 <1579932.qSkFQPvI6f@vostro.rjw.lan>
 <20140610131206.GA7626@amd.pavel.ucw.cz>
 <1848200.GDD9x0Rptb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1848200.GDD9x0Rptb@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2014-06-10 17:23:24, Rafael J. Wysocki wrote:
> On Tuesday, June 10, 2014 03:12:06 PM Pavel Machek wrote:
> > Hi!
> > 
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > On some systems the platform doesn't support neither
> > > PM_SUSPEND_MEM nor PM_SUSPEND_STANDBY, so PM_SUSPEND_FREEZE is the
> > > only available system sleep state.  However, some user space frameworks
> > > only use the "mem" and (sometimes) "standby" sleep state labels, so
> > > the users of those systems need to modify user space in order to be
> > > able to use system suspend at all and that is not always possible.
> > 
> > I'd say we should fix the frameworks, not add option to change kernel
> > interfaces.
> > 
> > Because, as you mentioned, if we add this, we are probably going to
> > get stuck with it forever :-(.
> 
> Unfortunately, fixing the frameworks is rather less than realistic in any
> reasonable time frame, since  Android. :-)

Actually, you still have the sources from android, and this issue
sounds almost simple enough for binary patch.

Android misuses /proc/sys/vm/drop_caches, too, IIRC. Are we going to
change interface to match their expectations? They have binder and
wakelocks. Are we going to apply those patches just because Android
wants that?

Android people usually patch their kernels, anyway, so why not add
this one, too?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
