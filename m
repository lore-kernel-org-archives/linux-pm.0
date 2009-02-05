From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 07/13] PM: wakelock: Add
	/sys/power/request_state
Date: Thu, 5 Feb 2009 09:52:50 +0100
Message-ID: <20090205085250.GA2077@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-8-git-send-email-arve@android.com>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> This is a non-blocking interface that specifies which suspend state to
> enter when no wakelocks are locked. A special state, "on", stops the
> process by locking the "main" wakelock.
> 
> If early-suspend support is enabled, early suspend handlers will be called
> when a state other than "on" is written. When writing "on", the corresonding
> resume handlers are called.

> @@ -388,6 +389,9 @@ static void suspend_finish(void)
>  
>  
>  static const char * const pm_states[PM_SUSPEND_MAX] = {
> +#ifdef CONFIG_WAKELOCK
> +	[PM_SUSPEND_ON]		= "on",
> +#endif
>  	[PM_SUSPEND_STANDBY]	= "standby",
>  	[PM_SUSPEND_MEM]	= "mem",
>  };

By doing this you change /sys/power/state interface. I do not think
you want to do that.
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
