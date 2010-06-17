From: Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH] DRM / radeon / KMS: Fix hibernation
	regression related to radeon PM (was: Re: [Regression,
	post-2.6.34] Hibernation broken on machines with radeon/KMS and r300)
Date: Thu, 17 Jun 2010 19:09:56 -0400
Message-ID: <AANLkTinBTc7DEJd9PywNuD5HeIZhqHY4ePK3w78OwVJ4__2955.55109992183$1276884144$gmane$org@mail.gmail.com>
References: <201006141653.03879.rjw@sisk.pl> <201006172114.19033.rjw@sisk.pl>
	<AANLkTimRQLDDyIB0LIE018gR24s593rkMyTvDuF1ntJT@mail.gmail.com>
	<201006180102.27658.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006180102.27658.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 17, 2010 at 7:02 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> There is a regression from 2.6.34 related to the recent radeon power
> management changes, caused by attempting to cancel a delayed work
> item that's never been scheduled. =A0However, the code as is has some
> other issues potentially leading to visible problems.
>
> First, the mutex around cancel_delayed_work() in radeon_pm_suspend()
> doesn't really serve any purpose, because cancel_delayed_work() only
> tries to delete the work's timer. =A0Moreover, it doesn't prevent the
> work handler from running, so the handler can do some wrong things if
> it wins the race and in that case it will rearm itself to do some
> more wrong things going forward. =A0So, I think it's better to wait for
> the handler to return in case it's already been queued up for
> execution. =A0Also, it should be prevented from rearming itself in that
> case.
>
> Second, in radeon_set_pm_method() the cancel_delayed_work() is not
> sufficient to prevent the work handler from running and queing up
> itself for the next run (the failure scenario is that
> cancel_delayed_work() returns 0, so the handler is run, it waits on
> the mutex and then rearms itself after the mutex has been released),
> so again the work handler should be prevented from rearming itself in
> that case..
>
> Finally, there's a potential deadlock in radeon_pm_fini(), because
> cancel_delayed_work_sync() is called under rdev->pm.mutex, but the
> work handler tries to acquire the same mutex (if it wins the race).
>
> Fix the issues described above.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reviewed-by: Alex Deucher <alexdeucher@gmail.com>
> ---
> =A0drivers/gpu/drm/radeon/radeon.h =A0 =A0| =A0 =A03 +-
> =A0drivers/gpu/drm/radeon/radeon_pm.c | =A0 41 ++++++++++++++++++++++++++=
++++-------
> =A02 files changed, 36 insertions(+), 8 deletions(-)
>
> Index: linux-2.6/drivers/gpu/drm/radeon/radeon_pm.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/gpu/drm/radeon/radeon_pm.c
> +++ linux-2.6/drivers/gpu/drm/radeon/radeon_pm.c
> @@ -397,13 +397,20 @@ static ssize_t radeon_set_pm_method(stru
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.dynpm_planned_action =3D DYNPM_AC=
TION_DEFAULT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
> =A0 =A0 =A0 =A0} else if (strncmp("profile", buf, strlen("profile")) =3D=
=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool flush_wq =3D false;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&rdev->pm.mutex);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev->pm.pm_method =3D PM_METHOD_PROFILE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rdev->pm.pm_method =3D=3D PM_METHOD_DYN=
PM) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&rdev->=
pm.dynpm_idle_work);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_wq =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* disable dynpm */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.dynpm_state =3D DYNPM_STATE_DISAB=
LED;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.dynpm_planned_action =3D DYNPM_AC=
TION_NONE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&rdev->pm.dynpm_idle_wo=
rk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev->pm.pm_method =3D PM_METHOD_PROFILE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flush_wq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_workqueue(rdev->wq);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DRM_ERROR("invalid power method!\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
> @@ -418,9 +425,18 @@ static DEVICE_ATTR(power_method, S_IRUGO
>
> =A0void radeon_pm_suspend(struct radeon_device *rdev)
> =A0{
> + =A0 =A0 =A0 bool flush_wq =3D false;
> +
> =A0 =A0 =A0 =A0mutex_lock(&rdev->pm.mutex);
> - =A0 =A0 =A0 cancel_delayed_work(&rdev->pm.dynpm_idle_work);
> + =A0 =A0 =A0 if (rdev->pm.pm_method =3D=3D PM_METHOD_DYNPM) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&rdev->pm.dynpm_idle_wo=
rk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rdev->pm.dynpm_state =3D=3D DYNPM_STATE=
_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev->pm.dynpm_state =3D DY=
NPM_STATE_SUSPENDED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_wq =3D true;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
> + =A0 =A0 =A0 if (flush_wq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_workqueue(rdev->wq);
> =A0}
>
> =A0void radeon_pm_resume(struct radeon_device *rdev)
> @@ -432,6 +448,12 @@ void radeon_pm_resume(struct radeon_devi
> =A0 =A0 =A0 =A0rdev->pm.current_sclk =3D rdev->clock.default_sclk;
> =A0 =A0 =A0 =A0rdev->pm.current_mclk =3D rdev->clock.default_mclk;
> =A0 =A0 =A0 =A0rdev->pm.current_vddc =3D rdev->pm.power_state[rdev->pm.de=
fault_power_state_index].clock_info[0].voltage.voltage;
> + =A0 =A0 =A0 if (rdev->pm.pm_method =3D=3D PM_METHOD_DYNPM
> + =A0 =A0 =A0 =A0 =A0 && rdev->pm.dynpm_state =3D=3D DYNPM_STATE_SUSPENDE=
D) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev->pm.dynpm_state =3D DYNPM_STATE_ACTIVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_delayed_work(rdev->wq, &rdev->pm.dynp=
m_idle_work,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 msecs_to_jiffies(RADEON_IDLE_LOOP_MS));
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
> =A0 =A0 =A0 =A0radeon_pm_compute_clocks(rdev);
> =A0}
> @@ -486,6 +508,8 @@ int radeon_pm_init(struct radeon_device
> =A0void radeon_pm_fini(struct radeon_device *rdev)
> =A0{
> =A0 =A0 =A0 =A0if (rdev->pm.num_power_states > 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool flush_wq =3D false;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&rdev->pm.mutex);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rdev->pm.pm_method =3D=3D PM_METHOD_PR=
OFILE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.profile =3D PM_PR=
OFILE_DEFAULT;
> @@ -493,13 +517,16 @@ void radeon_pm_fini(struct radeon_device
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0radeon_pm_set_clocks(rdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (rdev->pm.pm_method =3D=3D PM_ME=
THOD_DYNPM) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* cancel work */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&r=
dev->pm.dynpm_idle_work);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&rdev->=
pm.dynpm_idle_work);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_wq =3D true;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* reset default clocks */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.dynpm_state =3D D=
YNPM_STATE_DISABLED;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.dynpm_planned_act=
ion =3D DYNPM_ACTION_DEFAULT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0radeon_pm_set_clocks(rdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flush_wq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_workqueue(rdev->wq);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_remove_file(rdev->dev, &dev_attr_po=
wer_profile);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_remove_file(rdev->dev, &dev_attr_po=
wer_method);
> @@ -720,12 +747,12 @@ static void radeon_dynpm_idle_work_handl
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0radeon_pm_get_dynpm_state(=
rdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0radeon_pm_set_clocks(rdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_delayed_work(rdev->wq, &rdev->pm.dynp=
m_idle_work,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 msecs_to_jiffies(RADEON_IDLE_LOOP_MS));
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
> =A0 =A0 =A0 =A0ttm_bo_unlock_delayed_workqueue(&rdev->mman.bdev, resched);
> -
> - =A0 =A0 =A0 queue_delayed_work(rdev->wq, &rdev->pm.dynpm_idle_work,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 msecs_to_jiffies(RADEON_IDLE_LOOP_MS));
> =A0}
>
> =A0/*
> Index: linux-2.6/drivers/gpu/drm/radeon/radeon.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/gpu/drm/radeon/radeon.h
> +++ linux-2.6/drivers/gpu/drm/radeon/radeon.h
> @@ -619,7 +619,8 @@ enum radeon_dynpm_state {
> =A0 =A0 =A0 =A0DYNPM_STATE_DISABLED,
> =A0 =A0 =A0 =A0DYNPM_STATE_MINIMUM,
> =A0 =A0 =A0 =A0DYNPM_STATE_PAUSED,
> - =A0 =A0 =A0 DYNPM_STATE_ACTIVE
> + =A0 =A0 =A0 DYNPM_STATE_ACTIVE,
> + =A0 =A0 =A0 DYNPM_STATE_SUSPENDED,
> =A0};
> =A0enum radeon_dynpm_action {
> =A0 =A0 =A0 =A0DYNPM_ACTION_NONE,
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

Probably want to shorten the commit title a bit.

Matt
