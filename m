From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v3 1/2] PM / Core: suspend_again callback
	for	suspend_ops.
Date: Thu, 12 May 2011 06:19:28 +0000
Message-ID: <20110512061928.GB2460__9489.39972226999$1305181317$gmane$org@localhost.ucw.cz>
References: <1305091105-27173-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1305091105-27173-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> A system or a device may need to control suspend/wakeup events. It may
> want to wakeup the system after a predefined amount of time or at a
> predefined event decided while entering suspend for polling or delayed
> work. Then, it may want to enter suspend again if its predefined wakeup
> condition is the only wakeup reason and there is no outstanding events;
> thus, it does not wakeup the userspace unnecessary or unnecessary
> devices and keeps suspended as long as possible (saving the power).
> 
> Enabling a system to wakeup after a specified time can be easily
> achieved by using RTC. However, to enter suspend again immediately
> without invoking userland and unrelated devices, we need additional
> features in the suspend framework.

Looks ok to me.

>  /**
>   *	suspend_enter - enter the desired system sleep state.
>   *	@state:		state to enter
> + *	@pm_wkup_pending:	indicates that the power transition in progress
> + *				should be aborted.
>   *

Wowels are cheap, I'd add them here.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
