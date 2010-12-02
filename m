From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Prevent dpm_prepare() from returning
	errors unnecessarily
Date: Thu, 2 Dec 2010 20:42:31 +0100
Message-ID: <201012022042.31954.rjw__28964.0438197695$1291319081$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1012021038040.1921-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1012021038040.1921-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 02, 2010, Alan Stern wrote:
> On Thu, 2 Dec 2010, Rafael J. Wysocki wrote:
> 
> > OK, so please let me know what you think of the appended patch (on top of the
> > previous one).
> > 
> > Thanks,
> > Rafael
> > Index: linux-2.6/include/linux/suspend.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/suspend.h
> > +++ linux-2.6/include/linux/suspend.h
> > @@ -292,7 +292,7 @@ extern int unregister_pm_notifier(struct
> >  /* drivers/base/power/wakeup.c */
> >  extern bool events_check_enabled;
> >  
> > -extern bool pm_check_wakeup_events(void);
> > +extern bool pm_wakeup_pending(void);
> >  extern bool pm_get_wakeup_count(unsigned int *count);
> >  extern bool pm_save_wakeup_count(unsigned int count);
> >  #else /* !CONFIG_PM_SLEEP */
> > @@ -309,7 +309,7 @@ static inline int unregister_pm_notifier
> >  
> >  #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
> >  
> > -static inline bool pm_check_wakeup_events(void) { return true; }
> > +static inline bool pm_wakeup_pending(void) { return true; }
> 
> Shouldn't this return false?

Yes, it should, thanks!

Rafael
