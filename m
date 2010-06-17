From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [Regression,
	post-2.6.34] Hibernation broken on machines with radeon/KMS and r300
Date: Thu, 17 Jun 2010 15:40:21 -0400
Message-ID: <AANLkTimRQLDDyIB0LIE018gR24s593rkMyTvDuF1ntJT__26294.4812690423$1276804747$gmane$org@mail.gmail.com>
References: <201006141653.03879.rjw@sisk.pl> <201006171821.37060.rjw@sisk.pl>
	<AANLkTimxt3An0nSARe71YuMWMgSD07PjU8dNvyJIJu3U@mail.gmail.com>
	<201006172114.19033.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006172114.19033.rjw@sisk.pl>
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
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 17, 2010 at 3:14 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, June 17, 2010, Alex Deucher wrote:
>> 2010/6/17 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Wednesday, June 16, 2010, Alex Deucher wrote:
>> >> On Wed, Jun 16, 2010 at 4:16 PM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
>> >> > On Wednesday, June 16, 2010, Ondrej Zary wrote:
>> >> >> On Wednesday 16 June 2010, Rafael J. Wysocki wrote:
>> >> >> > On Tuesday, June 15, 2010, Rafael J. Wysocki wrote:
>> >> >> > > On Monday, June 14, 2010, Alex Deucher wrote:
>> >> >> > > > On Mon, Jun 14, 2010 at 3:03 PM, Rafael J. Wysocki <rjw@sisk=
.pl> wrote:
>> >> >> > > > > On Monday, June 14, 2010, Alex Deucher wrote:
>> >> >> > > > >> On Mon, Jun 14, 2010 at 10:53 AM, Rafael J. Wysocki <rjw@=
sisk.pl>
>> >> >> wrote:
>> >> >> > > > >> > Alex, Dave,
>> >> >> > > > >> >
>> >> >> > > > >> > I'm afraid hibernation is broken on all machines using =
radeon/KMS
>> >> >> > > > >> > with r300 after commit ce8f53709bf440100cb9d31b13032915=
51cf517f
>> >> >> > > > >> > (drm/radeon/kms/pm: rework power management). =A0At lea=
st, I'm able
>> >> >> > > > >> > to reproduce the symptom, which is that the machine han=
gs hard
>> >> >> > > > >> > around the point where an image is created (probably du=
ring the
>> >> >> > > > >> > device thaw phase), on two different boxes with r300 (t=
he output
>> >> >> > > > >> > of lspci from one of them is attached for reference, th=
e other one
>> >> >> > > > >> > is HP nx6325).
>> >> >> > > > >> >
>> >> >> > > > >> > Suspend to RAM appears to work fine at least on one of =
the
>> >> >> > > > >> > affected boxes.
>> >> >> > > > >> >
>> >> >> > > > >> > Unfortunately, the commit above changes a lot of code a=
nd it's not
>> >> >> > > > >> > too easy to figure out what's wrong with it and I didn'=
t have the
>> >> >> > > > >> > time to look more into details of this failure. =A0Howe=
ver, it looks
>> >> >> > > > >> > like you use .suspend() and .resume() callbacks as .fre=
eze() and
>> >> >> > > > >> > .thaw() which may not be 100% correct (in fact it looks=
 like the
>> >> >> > > > >> > "legacy" PCI suspend/resume is used, which is not recom=
mended any
>> >> >> > > > >> > more).
>> >> >> > > > >>
>> >> >> > > > >> Does it work any better after Dave's last drm pull reques=
t?
>> >> >> > > > >
>> >> >> > > > > Nope. =A0The symptom is slightly different, though, becaus=
e now it
>> >> >> > > > > hangs after turning off the screen.
>> >> >> > > > >
>> >> >> > > > >> With the latest changes, pm should not be a factor unless=
 it's
>> >> >> > > > >> explicitly enabled via sysfs.
>> >> >> > > > >
>> >> >> > > > > Well, I guess the first pm patch changed more than just pm=
, then.
>> >> >> > > >
>> >> >> > > > Does this patch help?
>> >> >> > > > http://lists.freedesktop.org/archives/dri-devel/2010-June/00=
1314.html
>> >> >> > >
>> >> >> > > No, it doesn't. =A0I try to hibernate, everything works to the=
 point where
>> >> >> > > the screen goes off and the box hangs (solid). =A0Normally, it=
 would turn
>> >> >> > > the screen back on and continue with saving the image.
>> >> >> > >
>> >> >> > > But, since that happens with the patch above applied, I think =
it doesn't
>> >> >> > > really pass the suspend phase (IOW, it probably hangs somewher=
e in the
>> >> >> > > radeon's suspend routine).
>> >> >> >
>> >> >> > I've just verified that in fact hibernation works on HP nx6325 w=
ith
>> >> >> > 2.6.35-rc3, but it takes about 55 sec. to suspend the graphics a=
dapter in
>> >> >> > the "freeze" phase. =A0Surprisingly enough, during suspend to RA=
M it works
>> >> >> > normally (as well as in the "poweroff" phase of hibernation).
>> >> >>
>> >> >> It takes 2 minutes on RV530:
>> >> >> https://bugzilla.redhat.com/show_bug.cgi?id=3D586522
>> >> >
>> >> > Well, my second affected box appears to hang somewhere in the radeo=
n's suspend
>> >> > routine.
>> >>
>> >> Does the attached patch help?
>> >
>> > It helps, but from what I can see in the code, it still has a few prob=
lems.
>> >
>> > First, the mutex around cancel_delayed_work() in radeon_pm_suspend()
>> > doesn't really serve any purpose, because rdev->pm.pm_method cannot ch=
ange
>> > at this point and cancel_delayed_work() only tries to delete the work'=
s timer.
>> > Moreover, it doesn't prevent the work handler from running, in which c=
ase the
>> > handler can do some wrong things and will rearm itself to do some more=
 wrong
>> > things going forward. =A0So, I think it's better to wait for the handl=
er to run in case it's
>> > already been queued up and it should also be prevented from rearming i=
tself in
>> > that case.
>> >
>> > Second, in radeon_set_pm_method() the cancel_delayed_work() is not suf=
ficient
>> > to prevent the work handler from running and queing up itself for the =
next run
>> > (the failure scenario is that cancel_delayed_work_sync() returns 0, so=
 the
>> > handler is run, it waits on the mutex and then rearms itself after the=
 mutex
>> > has been released), so it looks like cancel_delayed_work_sync()
>> > should be used to make sure it's not going to run again, but calling
>> > that cancel_delayed_work_sync() from under the mutex is not a good ide=
a.
>> >
>> > Finally, there's a potential deadlock in radeon_pm_fini(), where
>> > cancel_delayed_work_sync() is called under rdev->pm.mutex, but the
>> > work handler tries to acquire the same mutex (if it wins the race).
>> >
>> > So, I think something like the appended patch is needed.
>> >
>>
>> Looks reasonable. =A0Does it fix the suspend issue?
>
> Do you mean the $subject one? =A0Yes, it does.

Great.  Thanks for fixing that up.

Reviewed-by: Alex Deucher <alexdeucher@gmail.com>

>
> Rafael
>
>
>> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>> > ---
>> > =A0drivers/gpu/drm/radeon/radeon.h =A0 =A0| =A0 =A03 +-
>> > =A0drivers/gpu/drm/radeon/radeon_pm.c | =A0 41 +++++++++++++++++++++++=
+++++++-------
>> > =A02 files changed, 36 insertions(+), 8 deletions(-)
>> >
>> > Index: linux-2.6/drivers/gpu/drm/radeon/radeon_pm.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/gpu/drm/radeon/radeon_pm.c
>> > +++ linux-2.6/drivers/gpu/drm/radeon/radeon_pm.c
>> > @@ -397,13 +397,20 @@ static ssize_t radeon_set_pm_method(stru
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.dynpm_planned_action =3D DYNPM=
_ACTION_DEFAULT;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
>> > =A0 =A0 =A0 =A0} else if (strncmp("profile", buf, strlen("profile")) =
=3D=3D 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool flush_wq =3D false;
>> > +
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&rdev->pm.mutex);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev->pm.pm_method =3D PM_METHOD_PROFILE;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rdev->pm.pm_method =3D=3D PM_METHOD_=
DYNPM) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&rde=
v->pm.dynpm_idle_work);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_wq =3D true;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* disable dynpm */
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.dynpm_state =3D DYNPM_STATE_DI=
SABLED;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.dynpm_planned_action =3D DYNPM=
_ACTION_NONE;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&rdev->pm.dynpm_idle=
_work);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev->pm.pm_method =3D PM_METHOD_PROFILE;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flush_wq)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_workqueue(rdev->wq=
);
>> > =A0 =A0 =A0 =A0} else {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DRM_ERROR("invalid power method!\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
>> > @@ -418,9 +425,18 @@ static DEVICE_ATTR(power_method, S_IRUGO
>> >
>> > =A0void radeon_pm_suspend(struct radeon_device *rdev)
>> > =A0{
>> > + =A0 =A0 =A0 bool flush_wq =3D false;
>> > +
>> > =A0 =A0 =A0 =A0mutex_lock(&rdev->pm.mutex);
>> > - =A0 =A0 =A0 cancel_delayed_work(&rdev->pm.dynpm_idle_work);
>> > + =A0 =A0 =A0 if (rdev->pm.pm_method =3D=3D PM_METHOD_DYNPM) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&rdev->pm.dynpm_idle=
_work);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rdev->pm.dynpm_state =3D=3D DYNPM_ST=
ATE_ACTIVE)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev->pm.dynpm_state =3D=
 DYNPM_STATE_SUSPENDED;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_wq =3D true;
>> > + =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
>> > + =A0 =A0 =A0 if (flush_wq)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_workqueue(rdev->wq);
>> > =A0}
>> >
>> > =A0void radeon_pm_resume(struct radeon_device *rdev)
>> > @@ -432,6 +448,12 @@ void radeon_pm_resume(struct radeon_devi
>> > =A0 =A0 =A0 =A0rdev->pm.current_sclk =3D rdev->clock.default_sclk;
>> > =A0 =A0 =A0 =A0rdev->pm.current_mclk =3D rdev->clock.default_mclk;
>> > =A0 =A0 =A0 =A0rdev->pm.current_vddc =3D rdev->pm.power_state[rdev->pm=
.default_power_state_index].clock_info[0].voltage.voltage;
>> > + =A0 =A0 =A0 if (rdev->pm.pm_method =3D=3D PM_METHOD_DYNPM
>> > + =A0 =A0 =A0 =A0 =A0 && rdev->pm.dynpm_state =3D=3D DYNPM_STATE_SUSPE=
NDED) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev->pm.dynpm_state =3D DYNPM_STATE_ACT=
IVE;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_delayed_work(rdev->wq, &rdev->pm.d=
ynpm_idle_work,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 msecs_to_jiffies(RADEON_IDLE_LOOP_MS));
>> > + =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
>> > =A0 =A0 =A0 =A0radeon_pm_compute_clocks(rdev);
>> > =A0}
>> > @@ -486,6 +508,8 @@ int radeon_pm_init(struct radeon_device
>> > =A0void radeon_pm_fini(struct radeon_device *rdev)
>> > =A0{
>> > =A0 =A0 =A0 =A0if (rdev->pm.num_power_states > 1) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool flush_wq =3D false;
>> > +
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&rdev->pm.mutex);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rdev->pm.pm_method =3D=3D PM_METHOD=
_PROFILE) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.profile =3D PM=
_PROFILE_DEFAULT;
>> > @@ -493,13 +517,16 @@ void radeon_pm_fini(struct radeon_device
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0radeon_pm_set_clocks(rd=
ev);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (rdev->pm.pm_method =3D=3D PM=
_METHOD_DYNPM) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* cancel work */
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync=
(&rdev->pm.dynpm_idle_work);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&rde=
v->pm.dynpm_idle_work);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_wq =3D true;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* reset default clocks=
 */
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.dynpm_state =
=3D DYNPM_STATE_DISABLED;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdev->pm.dynpm_planned_=
action =3D DYNPM_ACTION_DEFAULT;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0radeon_pm_set_clocks(rd=
ev);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flush_wq)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_workqueue(rdev->wq=
);
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_remove_file(rdev->dev, &dev_attr=
_power_profile);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_remove_file(rdev->dev, &dev_attr=
_power_method);
>> > @@ -720,12 +747,12 @@ static void radeon_dynpm_idle_work_handl
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0radeon_pm_get_dynpm_sta=
te(rdev);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0radeon_pm_set_clocks(rd=
ev);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_delayed_work(rdev->wq, &rdev->pm.d=
ynpm_idle_work,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 msecs_to_jiffies(RADEON_IDLE_LOOP_MS));
>> > =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0mutex_unlock(&rdev->pm.mutex);
>> > =A0 =A0 =A0 =A0ttm_bo_unlock_delayed_workqueue(&rdev->mman.bdev, resch=
ed);
>> > -
>> > - =A0 =A0 =A0 queue_delayed_work(rdev->wq, &rdev->pm.dynpm_idle_work,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 msecs_to_jiffies(RADEON_IDLE_LOOP_MS));
>> > =A0}
>> >
>> > =A0/*
>> > Index: linux-2.6/drivers/gpu/drm/radeon/radeon.h
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/gpu/drm/radeon/radeon.h
>> > +++ linux-2.6/drivers/gpu/drm/radeon/radeon.h
>> > @@ -619,7 +619,8 @@ enum radeon_dynpm_state {
>> > =A0 =A0 =A0 =A0DYNPM_STATE_DISABLED,
>> > =A0 =A0 =A0 =A0DYNPM_STATE_MINIMUM,
>> > =A0 =A0 =A0 =A0DYNPM_STATE_PAUSED,
>> > - =A0 =A0 =A0 DYNPM_STATE_ACTIVE
>> > + =A0 =A0 =A0 DYNPM_STATE_ACTIVE,
>> > + =A0 =A0 =A0 DYNPM_STATE_SUSPENDED,
>> > =A0};
>> > =A0enum radeon_dynpm_action {
>> > =A0 =A0 =A0 =A0DYNPM_ACTION_NONE,
>> >
>>
>>
>
>
