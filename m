From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [2.6.29-rc2] fb_mmap: circular
 locking dependency on hibernation
Date: Sat, 31 Jan 2009 18:44:45 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901311843450.21273__11626.0083778345$1233424035$gmane$org@anakin>
References: <200901272137.57757.arvidjaar@mail.ru>
	<Pine.LNX.4.64.0901291009220.13600@anakin>
	<200901300716.06137.arvidjaar@mail.ru> <498485E0.4080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <498485E0.4080501@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrea Righi <righi.andrea@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Andrey Borzenkov <arvidjaar@mail.ru>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 31 Jan 2009, Andrea Righi wrote:
> On 2009-01-30 05:15, Andrey Borzenkov wrote:
> > On 29 of January 2009 12:10:11 Geert Uytterhoeven wrote:
> >> On Tue, 27 Jan 2009, Andrey Borzenkov wrote:
> fbcon: avoid circular locking dependency between fb_info->lock and mm->mmap_sem
> 
> In fbcon notifier the handler for FB_EVENT_SET_CONSOLE_MAP doesn't need
> to hold fb_info->lock.
> 
> Simply unlock it before calling set_con2fb_map(), that could try to
> acquire mm->mmap_sem to avoid a circular locking dependency with
> fb_mmap() (that acquires mm->mmap_sem -> fb_info-lock).

However, set_con2fb_map() accesses the array of fb_info pointers
registered_fb[], which seems to be a bit unsafe now the BKL is no longer held.

> Reported-by: Andrey Borzenkov <arvidjaar@mail.ru>
> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
> ---
>  drivers/video/console/fbcon.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> index 1657b96..81fc2f7 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -3169,9 +3169,15 @@ static int fbcon_event_notify(struct notifier_block *self,
>  		ret = fbcon_fb_unregistered(info);
>  		break;
>  	case FB_EVENT_SET_CONSOLE_MAP:
> +		/*
> +		 * XXX: info is not used here, we can unlock it to avoid
> +		 * circular locking with &current->mm->mmap_sem in fb_mmap().
> +		 */
> +		unlock_fb_info(info);
>  		con2fb = event->data;
>  		ret = set_con2fb_map(con2fb->console - 1,
>  				     con2fb->framebuffer, 1);
> +		lock_fb_info(info);
>  		break;
>  	case FB_EVENT_GET_CONSOLE_MAP:
>  		con2fb = event->data;
> 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
