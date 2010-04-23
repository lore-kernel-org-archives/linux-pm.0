From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Thu, 22 Apr 2010 19:25:22 -0700
Message-ID: <20100423022522.GB32490__24616.3319018253$1271989613$gmane$org@count0.beaverton.ibm.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1271984938-13920-3-git-send-email-arve@android.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 22, 2010 at 06:08:51PM -0700, Arve Hj=F8nnev=E5g wrote:
> Add a misc device, "suspend_blocker", that allows user-space processes
> to block auto suspend. The device has ioctls to create a suspend_blocker,
> and to block and unblock suspend. To delete the suspend_blocker, close
> the device.
> =

> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ---
>  Documentation/power/suspend-blockers.txt |   17 ++++
>  include/linux/suspend_block_dev.h        |   25 ++++++
>  kernel/power/Kconfig                     |    9 ++
>  kernel/power/Makefile                    |    1 +
>  kernel/power/user_suspend_blocker.c      |  128 ++++++++++++++++++++++++=
++++++
>  5 files changed, 180 insertions(+), 0 deletions(-)
>  create mode 100644 include/linux/suspend_block_dev.h
>  create mode 100644 kernel/power/user_suspend_blocker.c
> =

> diff --git a/Documentation/power/suspend-blockers.txt b/Documentation/pow=
er/suspend-blockers.txt
> index 1c48514..877bd8c 100644
> --- a/Documentation/power/suspend-blockers.txt
> +++ b/Documentation/power/suspend-blockers.txt
> @@ -95,3 +95,20 @@ if (list_empty(&state->pending_work))
>  else
>  	suspend_block(&state->suspend_blocker);
>  =

> +User-space API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To create a suspend_blocker from user-space, open the suspend_blocker de=
vice:
> +    fd =3D open("/dev/suspend_blocker", O_RDWR | O_CLOEXEC);
> +then call:
> +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_INIT(strlen(name)), name);

Why not initialize the user suspend blocker struct by default and then
allow each BLOCK to specify the name? Also, my guess is it's not
really a name so much as a description of why we're blocking suspend,
right?

Should the kernel reject empty strings or strings composed only of
"non-printing" characters?

> +
> +To activate a suspend_blocker call:
> +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_BLOCK);
> +
> +To unblock call:
> +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_UNBLOCK);

lsof will show which tasks hold the device open but not which ones
are blocking suspend. If merely keeping the device open corresponded to
blocking suspend then this would be obvious and no ioctls would be
necessary -- just write() the name/description.

Do you block/unblock often enough that frequent open/close of the device are
a problem? Or has this idea been considered and discarded for other reasons?

> +
> +To destroy the suspend_blocker, close the device:
> +    close(fd);
> +

<snip>

> diff --git a/kernel/power/user_suspend_blocker.c b/kernel/power/user_susp=
end_blocker.c
> new file mode 100644
> index 0000000..a9be6f4
> --- /dev/null
> +++ b/kernel/power/user_suspend_blocker.c
> @@ -0,0 +1,128 @@
> +/* kernel/power/user_suspend_block.c
> + *
> + * Copyright (C) 2009-2010 Google, Inc.
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
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/suspend_blocker.h>
> +#include <linux/suspend_block_dev.h>
> +
> +enum {
> +	DEBUG_FAILURE	=3D BIT(0),
> +};
> +static int debug_mask =3D DEBUG_FAILURE;
> +module_param_named(debug_mask, debug_mask, int, S_IRUGO | S_IWUSR | S_IW=
GRP);
> +
> +static DEFINE_MUTEX(ioctl_lock);

nit: Usually locks protect data -- not functions.

Couldn't this be part of the user_suspend_blocker struct? That would allow
the description/name to change as described above.

> +
> +struct user_suspend_blocker {
> +	struct suspend_blocker	blocker;
> +	char			name[0];
> +};

<snip>

Cheers,
	-Matt Helsley
