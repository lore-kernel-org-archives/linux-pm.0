From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/13] PM: earlysuspend: Add console switch
	when user	requested sleep state changes.
Date: Thu, 5 Feb 2009 10:03:16 +0100
Message-ID: <20090205090316.GD2077@elf.ucw.cz>
References: <1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<1233802226-23386-9-git-send-email-arve@android.com>
	<1233802226-23386-10-git-send-email-arve@android.com>
	<1233802226-23386-11-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-11-git-send-email-arve@android.com>
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

changelog would be welcome.

> Signed-off-by: Arve Hj??nnev??g <arve@android.com>
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index aedea7e..f1a3d5c 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -166,6 +166,23 @@ config EARLYSUSPEND
>  	  Call early suspend handlers when the user requested sleep state
>  	  changes.
>  
> +choice
> +	prompt "User-space screen access"
> +	default CONSOLE_EARLYSUSPEND
> +	depends on HAS_EARLYSUSPEND
> +
> +	config NO_USER_SPACE_SCREEN_ACCESS_CONTROL
> +		bool "None"

Eh?

> +	config CONSOLE_EARLYSUSPEND
> +		bool "Console switch on early-suspend"
> +		depends on HAS_EARLYSUSPEND && VT
> +		---help---
> +		  Register early suspend handler to perform a console switch to
> +		  when user-space should stop drawing to the screen and a switch
> +		  back when it should resume.

I could not parse english here.

> index d3467b3..8bf293d 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_FREEZER)		+= process.o
>  obj-$(CONFIG_WAKELOCK)		+= wakelock.o
>  obj-$(CONFIG_USER_WAKELOCK)	+= userwakelock.o
>  obj-$(CONFIG_EARLYSUSPEND)	+= earlysuspend.o
> +obj-$(CONFIG_CONSOLE_EARLYSUSPEND)	+= consoleearlysuspend.o

Some _'s would be welcome in filename.

Actually, I'd hope that system where you control everything (such as
android) would not need to switch consoles. Console switch was
invented as a workaround for X owning the hardware....

...and how is it different from current console switching we do on PC?

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
