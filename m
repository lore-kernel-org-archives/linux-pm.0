From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state	interface
Date: Thu, 5 Feb 2009 10:17:31 +0100
Message-ID: <20090205091731.GJ2077@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-6-git-send-email-arve@android.com>
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

On Wed 2009-02-04 18:50:18, Arve Hj??nnev??g wrote:
> Signed-off-by: Arve Hj??nnev??g <arve@android.com>
> ---
>  kernel/power/Kconfig |    9 +++++++++
>  kernel/power/main.c  |    4 ++++
>  2 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 6e3da6e..dd76467 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -135,6 +135,15 @@ config WAKELOCK_STAT
>  	---help---
>  	  Report wake lock stats in /proc/wakelocks
>  
> +config DISABLE_SYS_POWER_STATE
> +	bool "Disable /sys/power/state interface"
> +	depends on WAKELOCK
> +	default n
> +	---help---
> +	  The /sys/power/state interface does not respect wakelocks. If you
> +	  want to run user-space code that does not support wakelocks, do not
> +	  enable this option since it removes the interface.

I do not think this is required for anything or useful. If you don't
want to force system to suspend, do not write to /sys/power/state. It
is root-only interface, so....

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
