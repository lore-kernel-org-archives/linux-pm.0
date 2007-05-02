From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Wed, 2 May 2007 11:02:57 +0200
Message-ID: <200705021102.57914.rjw@sisk.pl>
References: <20070425072350.GA6866@ucw.cz> <200705020002.55331.rjw@sisk.pl>
	<1178094106.13233.39.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178094106.13233.39.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 2 May 2007 10:21, Johannes Berg wrote:
> On Wed, 2007-05-02 at 00:02 +0200, Rafael J. Wysocki wrote:
> 
> > Well, having a look on the ACPI spec I'm thinking that what we're trying to do
> > with this patch is actually wrong.
> 
> No idea :)
> 
> > Instead, we should rip off all of the invocations of pm_ops->whatever() from
> > the hibernation code paths (with the below exceptions) and *if* the platform
> > method is to be used, call pm_ops to make the system go down, in the following
> > way:
> > 1) call pm_ops->prepare(PM_SUSPEND_DISK)
> > 2) suspend devices (ie. call device_suspend() etc.)
> > 3) call pm_ops->enter(PM_SUSPEND_DISK)
> > and if that *fails* (ie. pm_ops->enter() returns):
> > 4) call pm_ops->finish(PM_SUSPEND_DISK)
> > 5) halt the system
> 
> Can we still split that off to another method so we don't use pm_ops? No
> matter how we invoke hibernation_ops or in what order, imho we shouldn't
> use pm_ops.

OK, I think we can go ahead with the patch if nobody objects.  It's been tested
to some extent and seems to work.  More testing will be appreciated.

Later on we can do what I said above using hibernation_ops instead of pm_ops,
if turns out to really make sense.

Greetings,
Rafael
