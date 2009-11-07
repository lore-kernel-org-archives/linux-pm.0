From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] PM: Thaws refrigerated and to be exited
	kernel	threads
Date: Sat, 7 Nov 2009 17:54:21 +0100
Message-ID: <20091107165421.GA1630__20654.3898945258$1257612945$gmane$org@ucw.cz>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE31F934@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE31F934@dbde02.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Kicks out a frozen thread from the refrigerator when an active thread has
> invoked kthread_stop on the frozen thread.
> 
> Signed-off-by: Romit Dasgupta <romit@ti.com>
> ---
> 
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index bd1d42b..c28dbe8 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/syscalls.h>
>  #include <linux/freezer.h>
> +#include <linux/kthread.h>
>  
>  /*
>   * freezing is complete, mark current process as frozen
> @@ -49,7 +50,7 @@ void refrigerator(void)
>  
>  	for (;;) {
>  		set_current_state(TASK_UNINTERRUPTIBLE);
> -		if (!frozen(current))
> +		if (!frozen(current) || (!current->mm && kthread_should_stop()))
>  			break;
>  		schedule();

Well, what if the thread does some processing before stopping? That
would break refrigerator assumptions...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
