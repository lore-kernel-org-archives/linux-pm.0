From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/11] PM: Enable early suspend
	through	/sys/power/state
Date: Wed, 28 Jan 2009 20:34:09 +0100
Message-ID: <20090128193409.GC1222@ucw.cz>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231896476-22445-2-git-send-email-arve@android.com>
	<1231896476-22445-3-git-send-email-arve@android.com>
	<1231896476-22445-4-git-send-email-arve@android.com>
	<1231896476-22445-5-git-send-email-arve@android.com>
	<1231896476-22445-6-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1231896476-22445-6-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj??nnev??g <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> If EARLYSUSPEND is enabled then writes to /sys/power/state no longer
> blocks, and the kernel will try to enter the requested state every
> time no wakelocks are held. Write "on" to resume normal operation.

No, please don't break compatibility like this. You changed semantics
of 'mem'...

Just add another two states, for example "auto-mem" and
"auto-standby", and make them enter mem/standby when required.

Ok, you'll need "on", too... for canceling... 

> @@ -388,6 +388,9 @@ static void suspend_finish(void)
>  
>  
>  static const char * const pm_states[PM_SUSPEND_MAX] = {
> +#ifdef CONFIG_EARLYSUSPEND
> +	[PM_SUSPEND_ON]		= "on",
> +#endif
>  	[PM_SUSPEND_STANDBY]	= "standby",
>  	[PM_SUSPEND_MEM]	= "mem",
>  };
> @@ -505,7 +508,11 @@ static ssize_t state_store(struct kobject
>  *kobj, struct kobj_attribute *attr,

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
