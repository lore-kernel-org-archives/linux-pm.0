From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 8/9] Input: Block suspend while event queue
 is not empty.
Date: Fri, 23 Apr 2010 13:56:25 -0700
Message-ID: <20100423135625.1e12d005.randy.dunlap__2290.74481544576$1272056373$gmane$org@oracle.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<1271984938-13920-7-git-send-email-arve@android.com>
	<1271984938-13920-8-git-send-email-arve@android.com>
	<1271984938-13920-9-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1271984938-13920-9-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: linux-input@vger.kernel.org, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, Matthew@smtp1.linux-foundation.org, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-pm@lists.linux-foundation.org, Tero Saarni <tero.saarni@gmail.com>, Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Apr 2010 18:08:57 -0700 Arve Hj=F8nnev=E5g wrote:

> Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker that will b=
lock
> suspend while the event queue is not empty. This allows userspace code to
> process input events while the device appears to be asleep.


All new ioctls need to be added to Documentation/ioctl/ioctl-number.txt, pl=
ease.

> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ---
>  drivers/input/evdev.c |   22 ++++++++++++++++++++++
>  include/linux/input.h |    3 +++
>  2 files changed, 25 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 2ee6c7a..66e0d16 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -585,6 +594,19 @@ static long evdev_do_ioctl(struct file *file, unsign=
ed int cmd,
>  		else
>  			return evdev_ungrab(evdev, client);
>  =

> +	case EVIOCGSUSPENDBLOCK:
> +		return put_user(client->use_suspend_blocker, ip);
> +
> +	case EVIOCSSUSPENDBLOCK:
> +		spin_lock_irq(&client->buffer_lock);
> +		if (!client->use_suspend_blocker && p)
> +			suspend_blocker_init(&client->suspend_blocker, "evdev");
> +		else if (client->use_suspend_blocker && !p)
> +			suspend_blocker_destroy(&client->suspend_blocker);
> +		client->use_suspend_blocker =3D !!p;
> +		spin_unlock_irq(&client->buffer_lock);
> +		return 0;
> +
>  	default:
>  =

>  		if (_IOC_TYPE(cmd) !=3D 'E')
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 7ed2251..b2d93b4 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -82,6 +82,9 @@ struct input_absinfo {
>  =

>  #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
>  =

> +#define EVIOCGSUSPENDBLOCK	_IOR('E', 0x91, int)			/* get suspend block e=
nable */
> +#define EVIOCSSUSPENDBLOCK	_IOW('E', 0x91, int)			/* set suspend block e=
nable */
> +
>  /*
>   * Event types
>   */
> -- =



thanks,
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
