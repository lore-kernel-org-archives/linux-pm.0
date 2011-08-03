From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: add statistics sysfs file for suspend to
	ram
Date: Wed, 3 Aug 2011 19:37:57 +0200
Message-ID: <20110803173757.GB2126@ucw.cz>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E573B@shsmsx502.ccr.corp.intel.com>
	<20110804051745.GB12336@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110804051745.GB12336@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: "Liu, ShuoX" <shuox.liu@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org



> > +   last_index = suspend_stats.last_failed + REC_FAILED_DEV_NUM - 1;
> > +   last_index %= REC_FAILED_DEV_NUM;
> > +   s += sprintf(s, "%s: %d\n%s: %d\n%s: %d\n%s: %d\n"
> > +           "%s: %d\n%s: %d\n%s: %d\n%s: %d\n",
> > +           "success", suspend_stats.success,
> > +           "fail", suspend_stats.fail,
> > +           "failed_freeze", suspend_stats.failed_freeze,
> > +           "failed_prepare", suspend_stats.failed_prepare,
> > +           "failed_suspend", suspend_stats.failed_suspend,
> > +           "failed_suspend_noirq",
> > +               suspend_stats.failed_suspend_noirq,
> > +           "failed_resume", suspend_stats.failed_resume,
> > +           "failed_resume_noirq",
> > +               suspend_stats.failed_resume_noirq);
> > +   s += sprintf(s, "failed_devs:\n  last_failed:\t%s\n",
> > +           suspend_stats.failed_devs[last_index]);
> > +   for (i = 1; i < REC_FAILED_DEV_NUM; i++) {
> > +       index = last_index + REC_FAILED_DEV_NUM - i;
> > +       index %= REC_FAILED_DEV_NUM;
> > +       s += sprintf(s, "\t\t%s\n",
> > +           suspend_stats.failed_devs[index]);
> > +   }
> 
> And, to top it all of, this is NOT allowed in sysfs at all.
> 
> Remember, sysfs is one text field per file.  Not something huge like
> this.
> 
> Perhaps you should use debugfs instead?

Or perhaps dmesg. NAK.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
