From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] PM: Prevent dpm_prepare() from returning
	errors unnecessarily
Date: Tue, 30 Nov 2010 21:07:58 +0800
Message-ID: <AANLkTi=tgEug5EUpqV1-GLFh9rsD5obAyExe+V=CjsbO__39532.8127932318$1291122594$gmane$org@mail.gmail.com>
References: <201011281312.49949.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011281312.49949.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2010/11/28 Rafael J. Wysocki <rjw@sisk.pl>:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Currently dpm_prepare() returns error code if it finds that a device
> being suspended has a pending runtime resume request. =A0However, it
> should not do that if the checking for wakeup events is not enabled.
> On the other hand, if the checking for wakeup events is enabled, it
> can return error when a wakeup event is detected, regardless of its
> source.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> =A0drivers/base/power/main.c | =A0 11 +++++++----
> =A01 file changed, 7 insertions(+), 4 deletions(-)
>
> Index: linux-2.6/drivers/base/power/main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/base/power/main.c
> +++ linux-2.6/drivers/base/power/main.c
> @@ -26,6 +26,7 @@
> =A0#include <linux/interrupt.h>
> =A0#include <linux/sched.h>
> =A0#include <linux/async.h>
> +#include <linux/suspend.h>
>
> =A0#include "../base.h"
> =A0#include "power.h"
> @@ -1052,8 +1053,10 @@ static int dpm_prepare(pm_message_t stat
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&dpm_list_mtx);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_get_noresume(dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pm_runtime_barrier(dev) && device_may_w=
akeup(dev)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Wake-up requested during=
 system sleep transition. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pm_runtime_barrier(dev) && device_may_w=
akeup(dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_wakeup_event(dev, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pm_check_wakeup_events()) {

If pm_check_wakeup_events returns true, it means there is no wakeup event
coming, so seems should handle normal suspend prepare, but why
abort the suspend here?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_put_sync(dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D -EBUSY;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {



thanks,
-- =

Lei Ming
