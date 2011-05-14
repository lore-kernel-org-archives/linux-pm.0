From: mark gross <markgross@thegnar.org>
Subject: Re: pm loss development
Date: Sat, 14 May 2011 16:33:59 -0700
Message-ID: <20110514233359.GA19916__41376.5350393534$1305416112$gmane$org@gvim.org>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
	<20110514162423.GA8292@gvim.org>
	<BANLkTikaH24rnMxKUOJq8TtgXvzoD3=zYQ@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BANLkTikaH24rnMxKUOJq8TtgXvzoD3=zYQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, davinci-linux-open-source@linux.davincidsp.com, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Sat, May 14, 2011 at 10:30:31PM +0200, Raffaele Recalcati wrote:
> On Sat, May 14, 2011 at 6:24 PM, mark gross <markgross@thegnar.org> wrote:
> > On Thu, May 12, 2011 at 07:11:01PM +0200, Raffaele Recalcati wrote:
> >> What happen normally in runtime pm implementation is that every devices
> >> are switched off and are enabled only when needed.
> >> In our case instead we have a completely functional embedded system an=
d,
> >> when an asyncrhonous event appear, we have only some tens milliseconds
> >> before the actual power failure takes place.
> >
> > Very interesting! =A0I've been worried about a similar failure on batte=
ry
> > driven devices that can experience significant voltage droops when
> > battery gets old, or low, and we turn on the flashlight led, vibrator
> > and make the screen bright while a high volume ring tone gets played.
> >
> > I think 10ms is a bit unrealistic. =A0I think its more like 300uSec bef=
ore
> > you hit brown out.
> =

> In our circuit it is the real timing, but I can understand your situation.
> Are you sure about 300usec?

not 100%,  I'll ask the HW guys what the RC bulk circuit half life is
for the device.  This along with the estimate of the burst power load
will define the time constraint for responding to the event.

Note: an LCD will easily pull 600mW to a full watt, and a loud audio
system can pull a watt, and a 3G modem can have some scary big transient
spikes in current.  The LED flash light can pull a watt, and I think the
vibrator is up around 500mW.  And um, well, my CPU has a power dynamic
range of ~200mW to ~2watts in C0. So, on a bad day a load spike on the
battery could be over 4 watts with all these going off at the same time.

Some of these events are pretty bursty (vibrator, ring tone at high
volume, 3G modem spike, P-states, camera flash)  If you are unlucky you
get a brown out as the vbat drops < 3.3 (or whatever)

> =

> >> This patchset add a support in order to switch off not vital part of t=
he system,
> >> in order to allow the board to survive longer.
> >> This allow the possibility to save important data.
> >>
> >> The implementation has been written by Davide Ciminaghi.
> >> My work instead was about analyzing different previuos implementation,
> >> a first completely custom one, a second using runtime pm, arriving
> >> finally to that one.
> >>
> >> I have tested PM loss in our DaVinci dm365 basi board and I write here=
 below a
> >> piece of code showing a possible usage.
> >>
> >> -------------------
> >>
> >> static int powerfail_status;
> >>
> >> static irqreturn_t basi_powerfail_stop(int irq, void *dev_id);
> >>
> >> static irqreturn_t basi_powerfail_quick_check_start(int irq, void *dev=
_id)
> >> {
> >> =A0 =A0 =A0 =A0 basi_mask_irq_gpio0(IRQ_DM365_GPIO0_2);
> >> =A0 =A0 =A0 =A0 basi_unmask_irq_gpio0(IRQ_DM365_GPIO0_0);
> >>
> >> =A0 =A0 =A0 =A0 /* PowerFail situation - START: power is going away */
> >> =A0 =A0 =A0 =A0 return IRQ_WAKE_THREAD;
> >> }
> >>
> >> static irqreturn_t basi_powerfail_start(int irq, void *dev_id)
> >> {
> >> =A0 =A0 =A0 =A0 if (powerfail_status)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> >> =A0 =A0 =A0 =A0 powerfail_status =3D 1;
> >> =A0 =A0 =A0 =A0 pm_loss_power_changed(SYS_PWR_FAILING);
> >> =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> >> }
> >>
> >>
> >> static irqreturn_t basi_powerfail_quick_check_stop(int irq, void *dev_=
id)
> >> {
> >> =A0 =A0 =A0 =A0 basi_mask_irq_gpio0(IRQ_DM365_GPIO0_0);
> >> =A0 =A0 =A0 =A0 basi_unmask_irq_gpio0(IRQ_DM365_GPIO0_2);
> >>
> >> =A0 =A0 =A0 =A0 /* PowerFail situation - STOP: power is coming back */
> >> =A0 =A0 =A0 =A0 return IRQ_WAKE_THREAD;
> >> }
> >>
> >> static irqreturn_t basi_powerfail_stop(int irq, void *dev_id)
> >> {
> >> =A0 =A0 =A0 =A0 if (!powerfail_status)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> >> =A0 =A0 =A0 =A0 powerfail_status =3D 0;
> >> =A0 =A0 =A0 =A0 pm_loss_power_changed(SYS_PWR_GOOD);
> >> =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> >> }
> >>
> >> enum basi_pwrfail_prio {
> >> =A0 =A0 =A0 =A0 BASI_PWR_FAIL_PRIO_0,
> >> =A0 =A0 =A0 =A0 BASI_PWR_FAIL_MIN_PRIO =3D BASI_PWR_FAIL_PRIO_0,
> >> =A0 =A0 =A0 =A0 BASI_PWR_FAIL_PRIO_1,
> >> =A0 =A0 =A0 =A0 BASI_PWR_FAIL_PRIO_2,
> >> =A0 =A0 =A0 =A0 BASI_PWR_FAIL_PRIO_3,
> >> =A0 =A0 =A0 =A0 BASI_PWR_FAIL_MAX_PRIO =3D BASI_PWR_FAIL_PRIO_3,
> >> };
> >>
> >> struct pm_loss_default_policy_item basi_pm_loss_policy_items[] =3D {
> >> =A0 =A0 =A0 =A0 {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus_name =3D "mmc",
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus_priority =3D BASI_PWR_FAIL_PRIO_1,
> >> =A0 =A0 =A0 =A0 },
> >> =A0 =A0 =A0 =A0 {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus_name =3D "platform",
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus_priority =3D BASI_PWR_FAIL_PRIO_2,
> >> =A0 =A0 =A0 =A0 },
> >> };
> >>
> >> #define BASI_POLICY_NAME "basi-default"
> >>
> >> struct pm_loss_default_policy_table basi_pm_loss_policy_table =3D {
> >> =A0 =A0 =A0 =A0 .name =3D BASI_POLICY_NAME,
> >> =A0 =A0 =A0 =A0 .items =3D basi_pm_loss_policy_items,
> >> =A0 =A0 =A0 =A0 .nitems =3D ARRAY_SIZE(basi_pm_loss_policy_items),
> >> };
> >>
> >> static void basi_powerfail_configure(void)
> >> {
> >> =A0 =A0 =A0 =A0 int stat;
> >> =A0 =A0 =A0 =A0 struct pm_loss_policy *p;
> >> =A0 =A0 =A0 =A0 stat =3D request_threaded_irq(IRQ_DM365_GPIO0_2,
> > Is this some comparator device that tugs on this gpio when the voltage
> > drops or goes to 0? =A0Is threaded irq fast enough?
> =

> yes, there is a comparator.
> I need more data about timing, I'll try to add this info in some days.

yeah, even if you don't have as fast of a response time need as I think
I have, you do need to consider what if the system is busy at the time
this interrupt comes in.  Could you be blocked and fail to save your
emmc from corruption?

> =

> > Could we consider something that includes a hot path ISR based
> > notification call back to do stuff like blink off devices that don't
> > need to save state; =A0backlights, vibrators, flashlight LEDs, audio
> > output drivers <-- I'm not sure about audio HW, and then a slower path
> > for other things that can be put into lower power states?
> >
> > the all-clear notification that power is good again should be on a
> > slower path I would assume.
> =

> First I get data, afterwards we can see if your need can be seen as an
> extension or something else.
>

This is an interesting problem though. ;)  It brings a hard real time
requirement to the normal linux kernel from the physics of battery
performance. =


--mark
