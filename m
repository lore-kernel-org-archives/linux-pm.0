From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: calling runtime PM from system PM methods
Date: Sun, 12 Jun 2011 11:59:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106121153510.18475-100000__29588.8032451787$1307894417$gmane$org@netrider.rowland.org>
References: <201106120046.36618.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106120046.36618.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 12 Jun 2011, Rafael J. Wysocki wrote:

> > Basically, I think what Rafael was saying before referred to the 
> > general case, where you don't know anything about the subsystem and 
> > can't afford to make assumptions.  But in the real world you'll be 
> > writing a driver for a particular subsystem and you'll know how that 
> > subsystem works.  If the subsystem permits runtime PM calls to be 
> > nested within the system PM routines, feel free to go ahead and use 
> > them.
> 
> But then we get the problem that user space may echo "on" to the
> device's "control" file in sysfs and the whole clever plan basically goes
> south.

That would indeed be a problem if we used pm_runtime_suspend() in the
system suspend code.  But it doesn't prevent us from calling
pm_runtime_resume() during system suspend.

> Moreover, on some systems devices will belong to PM domains and their
> drivers may potentially be used with different PM domains on different
> platforms.  This means that drivers really should not make any assumptions
> about whether or not they can use runtime PM in their system suspend/resume
> routines.  They can't.

Yes, clearly one mustn't make assumptions about unknown subsystems or
PM domains.

Alan Stern
