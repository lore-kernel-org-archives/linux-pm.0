From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: RFC: additional event for pm_notifier
Date: Fri, 26 Mar 2010 20:25:55 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1003262024310.2476@localhost>
References: <alpine.LFD.2.00.1003171945130.2469@localhost>
	<201003172234.44039.rjw@sisk.pl>
	<alpine.LFD.2.00.1003181227110.2139@localhost>
	<201003182119.24070.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003182119.24070.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org



On Thu, 18 Mar 2010, Rafael J. Wysocki wrote:

> On Thursday 18 March 2010, Sebastian Ott wrote:
> > 
> > On Wed, 17 Mar 2010, Rafael J. Wysocki wrote:
> > 
> > > On Wednesday 17 March 2010, Sebastian Ott wrote:
> > > > hi,
> > > > 
> > > > on s390 certain hw features which we normally enable in our init
> > > > calls, get reset while restoring the hibernation image.
> > > > so we need a trigger to reenable them before the device callbacks
> > > > are called.
> > > > 
> > > > is it possible to add an additional event for the existing
> > > > pm_notifier (something like the attached patch)?
> > > > 
> > > > regards
> > > > sebastian
> > > > 
> > > > 
> > > > Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> > > > ---
> > > >  include/linux/notifier.h |    1 +
> > > >  kernel/power/hibernate.c |    2 ++
> > > >  2 files changed, 3 insertions(+)
> > > > 
> > > > Index: linux-2.6/include/linux/notifier.h
> > > > ===================================================================
> > > > --- linux-2.6.orig/include/linux/notifier.h
> > > > +++ linux-2.6/include/linux/notifier.h
> > > > @@ -250,6 +250,8 @@ static inline int notifier_to_errno(int 
> > > >  #define PM_POST_SUSPEND		0x0004 /* Suspend finished */
> > > >  #define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
> > > >  #define PM_POST_RESTORE		0x0006 /* Restore failed */
> > > > +#define PM_RESTORE_FINISHED	0x0007 /* Image restored, called prior to
> > > > +					  device callbacks */
> > > >  
> > > >  /* Console keyboard events.
> > > >   * Note: KBD_KEYCODE is always sent before KBD_UNBOUND_KEYCODE, KBD_UNICODE and
> > > > Index: linux-2.6/kernel/power/hibernate.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/kernel/power/hibernate.c
> > > > +++ linux-2.6/kernel/power/hibernate.c
> > > > @@ -290,6 +290,8 @@ static int create_image(int platform_mod
> > > >  	if (!in_suspend)
> > > >  		platform_leave(platform_mode);
> > > >  
> > > > +	pm_notifier_call_chain(PM_RESTORE_FINISHED);
> > > 
> > > Hmm.  Why can't you put that in platform_leave()?
> > 
> > i'm confused, are you suggesting to put the actual statement in
> > platform_leave? this would change that all these platform_* functions
> > are nop's if platform_mode isn't set (i need the trigger independent
> > of the hibernation_mode)
> > 
> > or are you suggesting to implement platform_hibernation_ops for s390?
> 
> This one.
> 
> > - this seems a bit too much since i only need one trigger,
> 
> So you don't need to implement the other ones. :-)
> 
> You'll need to remove the check in hibernation_set_ops(), but that's fine.
> 
> [Well, it's outdated anyway, but only ACPI has been using it so far.]
> 
> > and again this depends on the hibernation_mode
> 
> That's fine as well.  If you define the ops, "platform" will be the default and
> if someone wants to shoot himself in the foot by changing that, it's his
> problem.

hi,

i've got that working, but after some more thinking
i really didn't like that approach - in short, if we do that,
hibernation on s390 will allways be bound to the plattform mode
(with certain devices we will crash in our restore callbacks
if we haven't previously enabled the hw-feature, which those
devices use)

and to the your-gun-your-foot argument - if someone tests
hibernation on s390 using the reboot mode he sure cannot
expect the potential panic, depending on the involved devices

do you absolutely oppose against the idea of a new notifier event?

regards
sebastian
