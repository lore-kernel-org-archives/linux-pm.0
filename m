From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH 02/13] PM: Add early suspend api.
Date: Thu, 5 Feb 2009 15:26:24 -0800
Message-ID: <20090205232624.GB19577@linux.intel.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-3-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 04, 2009 at 06:50:15PM -0800, Arve Hj=F8nnev=E5g wrote:
> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ---
>  Documentation/power/early-suspend.txt |   26 +++++++++++++++
>  include/linux/earlysuspend.h          |   55 +++++++++++++++++++++++++++=
++++++
>  2 files changed, 81 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/power/early-suspend.txt
>  create mode 100755 include/linux/earlysuspend.h
> =

> diff --git a/Documentation/power/early-suspend.txt b/Documentation/power/=
early-suspend.txt
> new file mode 100644
> index 0000000..8286d3a
> --- /dev/null
> +++ b/Documentation/power/early-suspend.txt
> @@ -0,0 +1,26 @@
> +Early-suspend
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The early-suspend api allows drivers to get notified when user-space wri=
tes to =

> +/sys/power/request_state to indicate that the user visible sleep state s=
hould =

> +change. A level controls what order the handlers are called in. Suspend =

> +handlers are called in low to high level order, resume handlers are call=
ed in =

> +the opposite order. =

> +
> +Four levels are defined:
> +EARLY_SUSPEND_LEVEL_BLANK_SCREEN:
> +  On suspend the screen should be turned off but the framebuffer must st=
ill be
> +  accessible. On resume the screen can be turned back on.
> +
> +EARLY_SUSPEND_LEVEL_STOP_DRAWING:
> +  On suspend this level notifies user-space that it should stop accessin=
g the =

> +  framebuffer and it waits for it to complete. On resume it notifies use=
r-space =

> +  that it should resume screen access.
> +  Two methods are provided, console switch or a sysfs interface.
> +
> +EARLY_SUSPEND_LEVEL_DISABLE_FB:
> +  Turn off the framebuffer on suspend and back on on resume.
> +
> +EARLY_SUSPEND_LEVEL_STOP_INPUT:
> +  On suspend turn off input devices that are not capable of wakeup or wh=
ere
> +  wakeup is disabled. On resume turn the same devices back on.

these levels names are domain and device profile centric.  How can we
make these be applicable to more than the HTC dream? =


Why 4 levels?  4 seems like too many, but why stop at 4 why not 8?


> diff --git a/include/linux/earlysuspend.h b/include/linux/earlysuspend.h
> new file mode 100755
> index 0000000..1587a3f
> --- /dev/null
> +++ b/include/linux/earlysuspend.h
> @@ -0,0 +1,55 @@
> +/* include/linux/earlysuspend.h
> + *
> + * Copyright (C) 2007-2008 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef _LINUX_EARLYSUSPEND_H
> +#define _LINUX_EARLYSUSPEND_H
> +
> +#include <linux/list.h>
> +
> +/* The early_suspend structure defines suspend and resume hooks to be ca=
lled
> + * when the user visible sleep state of the system changes, and a level =
to
> + * control the order. They can be used to turn off the screen and input
> + * devices that are not used for wakeup.
> + * Suspend handlers are called in low to high level order, resume handle=
rs are
> + * called in the opposite order. If, when calling register_early_suspend,
> + * the suspend handlers have already been called without a matching call=
 to the
> + * resume handlers, the suspend handler will be called directly from
> + * register_early_suspend. This direct call can violate the normal level=
 order.
> + */
> +enum {
> +	EARLY_SUSPEND_LEVEL_BLANK_SCREEN =3D 50,
> +	EARLY_SUSPEND_LEVEL_STOP_INPUT =3D 75,
> +	EARLY_SUSPEND_LEVEL_STOP_DRAWING =3D 100,
> +	EARLY_SUSPEND_LEVEL_DISABLE_FB =3D 150,
> +};

Application domain independent levels may be more useful to the larger
community.


> +struct early_suspend {
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	struct list_head link;
> +	int level;
> +	void (*suspend)(struct early_suspend *h);
> +	void (*resume)(struct early_suspend *h);
> +#endif
> +};
> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +void register_early_suspend(struct early_suspend *handler);
> +void unregister_early_suspend(struct early_suspend *handler);
> +#else
> +#define register_early_suspend(handler) do { } while (0)
> +#define unregister_early_suspend(handler) do { } while (0)
> +#endif
> +

do we really need to no-op this code this way?


--mgross

> +#endif
> +
> -- =

> 1.6.1
> =

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
