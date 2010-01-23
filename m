From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] PM / Runtime: Add sysfs switch for
 disabling device run-time PM (rev. 2)
Date: Fri, 22 Jan 2010 22:22:11 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001222202400.23929-100000__30552.1201379181$1264217000$gmane$org@netrider.rowland.org>
References: <201001222156.25529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001222156.25529.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 22 Jan 2010, Rafael J. Wysocki wrote:

> > For example, we disable runtime PM for most USB devices by default.  
> > But a few drivers may know that their devices are able to handle it, so 
> > they want to change the default setting when they are bound.
> 
> Runtime PM is disabled for all devices by default unless the driver enables
> it.  The setting in power/control is to override the driver's choice, so that
> it can be disabled even if the driver tries to enable it.
> 
> IOW, the user space is the owner of the power.runtime_auto flag and I don't
> think we should allow drivers to modify it.

After more thought, I changed my mind about this.  The ability to 
override the driver's choice means that the user should be able to 
enable runtime PM even if the driver tries to disable it, as well as 
the other way 'round.

In other words, it's not productive to say the user is the owner of the
runtime_auto flag.  What we _really_ want is to put the user in charge
of whether or not a device is subject to runtime PM.

First of all, note that if the driver doesn't support runtime PM then
it makes no difference what value runtime_auto has.  The issue is moot.

So suppose the driver does support runtime PM.  In this case, it's
irrelevant that runtime PM starts out disabled by default when the
device structure is initialized.  The bus subsystem and driver will
reinitialize the settings in the way they think best.

But if the driver decides to disable runtime PM and pm_runtime_forbid()
isn't EXPORTed, then the driver will be forced to implement its
decision by leaving disable_depth > 0 -- which means there's nothing
the user can do.  The power/control attribute won't help.  On the other
hand, if the driver decides to disable runtime PM and it can do so by
calling pm_runtime_forbid(), then the user can override the decision.

Alan Stern
