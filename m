From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH update] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 15)
Date: Wed, 12 Aug 2009 19:37:15 +0900
Message-ID: <aec7e5c30908120337g2928b825m1a17a311a0756305__2920.69920474223$1250073584$gmane$org@mail.gmail.com>
References: <200908081625.57333.rjw@sisk.pl> <200908092313.05541.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908092313.05541.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Mon, Aug 10, 2009 at 6:13 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Introduce core framework for run-time PM of I/O devices (rev=
. 15)
>
> Introduce a core framework for run-time power management of I/O
> devices. =A0Add device run-time PM fields to 'struct dev_pm_info'
> and device run-time PM callbacks to 'struct dev_pm_ops'. =A0Introduce
> a run-time PM workqueue and define some device run-time PM helper
> functions at the core level. =A0Document all these things.
>
> Special thanks to Alan Stern for his help with the design and
> multiple detailed reviews of the pereceding versions of this patch
> and to Magnus Damm for testing feedback.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looking good! I have a few nitpicks below, but from a functional
perspective it's all good. I've tested v15 with platform device
drivers for I2C, UIO and framebuffer. Before adding my "Acked-by"  I
also want to test the V4L capture driver, but I need to wait a few
days until I can get my hands on such a hardware platform.

Thanks for folding in and fixing up the debug patch. I was able to
drop most remaining patches thanks to feedback from Alan. So the only
needed patch apart from this one (and the ones in your linux-next
branch) is the one in this micro-series: "PM: Runtime PM v15 for
Platform Devices 20090812".

> --- linux-2.6.orig/include/linux/pm.h
> +++ linux-2.6/include/linux/pm.h
[..]
> =A0struct dev_pm_info {
> =A0 =A0 =A0 =A0pm_message_t =A0 =A0 =A0 =A0 =A0 =A0power_state;
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0can_wakeup:1;
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0should_wakeup:1;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0can_wakeup:1;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0should_wakeup:1;
> =A0 =A0 =A0 =A0enum dpm_state =A0 =A0 =A0 =A0 =A0status; =A0 =A0 =A0 =A0 =
/* Owned by the PM core */
> -#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM_SLEEP
> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0entry;
> =A0#endif
> +#ifdef CONFIG_PM_RUNTIME
> + =A0 =A0 =A0 struct timer_list =A0 =A0 =A0 suspend_timer;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 timer_expires;
> + =A0 =A0 =A0 struct work_struct =A0 =A0 =A0work;
> + =A0 =A0 =A0 wait_queue_head_t =A0 =A0 =A0 wait_queue;
> + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
> + =A0 =A0 =A0 atomic_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usage_count;
> + =A0 =A0 =A0 atomic_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0child_count;

I suppose child_count has to be atomic?

> --- /dev/null
> +++ linux-2.6/drivers/base/power/runtime.c
[...]
> +int __pm_runtime_suspend(struct device *dev, bool from_wq)
> + =A0 =A0 =A0 __releases(&dev->power.lock) __acquires(&dev->power.lock)
[...]
> + =A0 =A0 =A0 if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspe=
nd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D dev->bus->pm->runtime_suspend(de=
v);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.runtime_error =3D retval;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOSYS;
> + =A0 =A0 =A0 }

Nit: { and } above do not follow the regular coding style.

> +int __pm_runtime_resume(struct device *dev, bool from_wq)
> + =A0 =A0 =A0 __releases(&dev->power.lock) __acquires(&dev->power.lock)
[...]
> + =A0 =A0 =A0 if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resum=
e) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D dev->bus->pm->runtime_resume(dev=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.runtime_error =3D retval;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOSYS;
> + =A0 =A0 =A0 }

Same minor issue here.

Apart from that all is fine. Thank you.

/ magnus
