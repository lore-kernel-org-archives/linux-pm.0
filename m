From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: calling runtime PM from system PM methods
Date: Sun, 12 Jun 2011 20:27:09 +0200
Message-ID: <201106122027.09845.rjw__33391.0546069548$1307903347$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106121153510.18475-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106121153510.18475-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, June 12, 2011, Alan Stern wrote:
> On Sun, 12 Jun 2011, Rafael J. Wysocki wrote:
> 
> > > Basically, I think what Rafael was saying before referred to the 
> > > general case, where you don't know anything about the subsystem and 
> > > can't afford to make assumptions.  But in the real world you'll be 
> > > writing a driver for a particular subsystem and you'll know how that 
> > > subsystem works.  If the subsystem permits runtime PM calls to be 
> > > nested within the system PM routines, feel free to go ahead and use 
> > > them.
> > 
> > But then we get the problem that user space may echo "on" to the
> > device's "control" file in sysfs and the whole clever plan basically goes
> > south.
> 
> That would indeed be a problem if we used pm_runtime_suspend() in the
> system suspend code.  But it doesn't prevent us from calling
> pm_runtime_resume() during system suspend.

I agree.  Moreover, calling pm_runtime_resume() from a .prepare() callback
is actually fine, because it makes .runtime_resume() run before .suspend()
and .suspend_noirq().  But if .runtime_resume() is run between .suspend()
and .suspend_noirq(), that may lead to some trouble, again, depending on
the subsystem (or PM domain) involved.

Also, if a subsystem calls pm_runtime_resume() in one of its system suspend
callbacks (e.g. .prepare()), that's pretty much OK, because the subsystem
is basically responsible for making things work at this point.  However, if
a driver does that, it's kind of like saying "here I'm smarter than the
subsystem and I know better".

Unfortunately, platform drivers deal with a dumb subsystem, so they have
the right to think so, but that's not the case in general.

Thanks,
Rafael
