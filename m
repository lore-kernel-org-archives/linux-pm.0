From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH 1/2] Freezer: Fix s2disk resume from initrd
	(rev. 2)
Date: Mon, 26 Nov 2007 10:10:32 +1100
Message-ID: <200711261010.34383.nigel@nigel.suspend2.net>
References: <200711212322.02340.rjw@sisk.pl> <200711212325.32964.rjw@sisk.pl>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711212325.32964.rjw@sisk.pl>
Content-Disposition: inline
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
Cc: Chris Friedhoff <chris@friedhoff.org>, Nigel Cunningham <nigel@suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi.

On Thursday 22 November 2007 09:25:32 Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Add appropriate freezer annotations to handle_initrd(), so that it's 
possible
> to resume from disk from an initrd.
> 
> This patch fixes Bug #9345: http://bugzilla.kernel.org/show_bug.cgi?id=9345
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Nigel Cunningham <nigel@suspend2.net>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Chris Friedhoff <chris@friedhoff.org>
> ---
>  init/do_mounts_initrd.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/init/do_mounts_initrd.c
> ===================================================================
> --- linux-2.6.orig/init/do_mounts_initrd.c
> +++ linux-2.6/init/do_mounts_initrd.c
> @@ -55,12 +55,18 @@ static void __init handle_initrd(void)
>  	sys_mount(".", "/", NULL, MS_MOVE, NULL);
>  	sys_chroot(".");
>  
> +	/*
> +	 * In case that a resume from disk is carried out by linuxrc or one of
> +	 * its children, we need to tell the freezer not to wait for us.
> +	 */
> +	current->flags |= PF_FREEZER_SKIP;
> +
>  	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
>  	if (pid > 0)
> -		while (pid != sys_wait4(-1, NULL, 0, NULL)) {
> -			try_to_freeze();
> +		while (pid != sys_wait4(-1, NULL, 0, NULL))
>  			yield();
> -		}
> +
> +	current->flags &= ~PF_FREEZER_SKIP;
>  
>  	/* move initrd to rootfs' /old */
>  	sys_fchdir(old_fd);
> 
> 

Ack. This fixes the issue for me, too.

Nigel
-- 
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.
