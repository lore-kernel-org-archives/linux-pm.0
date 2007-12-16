From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] apm-emulation: implement notify/ack for
	/sys/power/state events
Date: Mon, 17 Dec 2007 07:03:00 +1100
Message-ID: <1197835380.21886.0.camel@pasglop>
References: <1197827906.6769.7.camel@johannes.berg>
	<200712162015.59963.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712162015.59963.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, Jamey Hicks <jamey@crl.dec.com>
List-Id: linux-pm@vger.kernel.org


On Sun, 2007-12-16 at 20:15 +0100, Rafael J. Wysocki wrote:
> > +              *
> > +              * Unfortunately we cannot do a timeout because then we'd
> > +              * suspend again right away if the process that had apm_bios
> > +              * open and that we timed out waiting for "acknowledges" the
> > +              * event after we have resumed. If suspend doesn't work because
> > +              * of a rogue process, just kill that process.
> > +              *
> > +              * FIXME: is the suspends_pending == 1 test racy?

I think we can do the timeout thing easily... Just mark the fd's that
haven't ack'ed with a flag that makes us ignore the next ack...

Ben.

> Make suspends_pending atomic?  Then, you'd not need the locking around it.
> 
> > +              */
> > +             err = wait_event_interruptible(apm_suspend_waitqueue,
> > +                                            suspends_pending == 1);
> > +
> > +             mutex_lock(&state_lock);
> > +             suspends_pending--;
> > +             mutex_unlock(&state_lock);
> > +
> > +             if (!err)
> > +                     return NOTIFY_OK;
> > +
> > +             /* interrupted by signal */
> > +             return NOTIFY_BAD;
> > +
> > +     case PM_POST_SUSPEND:
> > +             /* TODO: maybe grab error code, needs core changes */
> > +             apm_after_resume(0);
> > +             return NOTIFY_OK;
> > +
> > +     default:
> > +             return NOTIFY_DONE;
> > +     }
> > +}
> > +
> > +struct notifier_block apm_notif_block = {
> > +     .notifier_call = apm_suspend_notifier,
> > +};
> > +
> >  static int __init apm_init(void)
> >  {
> >       int ret;
> > @@ -588,7 +671,7 @@ static int __init apm_init(void)
> >       if (IS_ERR(kapmd_tsk)) {
> >               ret = PTR_ERR(kapmd_tsk);
> >               kapmd_tsk = NULL;
> > -             return ret;
> > +             goto out;
> >       }
> >       wake_up_process(kapmd_tsk);
> >  
> > @@ -597,16 +680,27 @@ static int __init apm_init(void)
> >  #endif
> >  
> >       ret = misc_register(&apm_device);
> > -     if (ret != 0) {
> > -             remove_proc_entry("apm", NULL);
> > -             kthread_stop(kapmd_tsk);
> > -     }
> > +     if (ret)
> > +             goto out_stop;
> > +
> > +     ret = register_pm_notifier(&apm_notif_block);
> > +     if (ret)
> > +             goto out_unregister;
> >  
> > +     return 0;
> > +
> > + out_unregister:
> > +     misc_deregister(&apm_device);
> > + out_stop:
> > +     remove_proc_entry("apm", NULL);
> > +     kthread_stop(kapmd_tsk);
> > + out:
> >       return ret;
> >  }
> >  
> >  static void __exit apm_exit(void)
> >  {
> > +     unregister_pm_notifier(&apm_notif_block);
> >       misc_deregister(&apm_device);
> >       remove_proc_entry("apm", NULL);
> >  
> > --- everything.orig/kernel/power/main.c       2007-12-16
> 15:23:18.689514811 +0100
> > +++ everything/kernel/power/main.c    2007-12-16 15:31:06.179512207
> +0100
> > @@ -25,6 +25,7 @@
> >  #include "power.h"
> >  
> >  BLOCKING_NOTIFIER_HEAD(pm_chain_head);
> > +EXPORT_SYMBOL_GPL(pm_chain_head);
> >  
> >  DEFINE_MUTEX(pm_mutex);
> 
