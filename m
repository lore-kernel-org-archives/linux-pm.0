From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 2/5] pda-power: switch to new dev_pm_ops
Date: Fri, 7 Aug 2009 15:35:19 +0200
Message-ID: <74d0deb30908070635s2fa76e5t954742239b8592a4__18504.7671701343$1249652191$gmane$org@mail.gmail.com>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
	<1249496971-9019-2-git-send-email-daniel@caiaq.de>
	<200908052149.55567.elendil@planet.nl>
	<20090805222920.GF19257@buzzloop.caiaq.de>
	<74d0deb30908060452k1fc0e982jf14be2e895e9a805@mail.gmail.com>
	<20090806125631.GI19257@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090806125631.GI19257@buzzloop.caiaq.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Mack <daniel@caiaq.de>
Cc: spyro@f2s.com, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, cbou@mail.ru, mreimer@vpop.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 6, 2009 at 2:56 PM, Daniel Mack<daniel@caiaq.de> wrote:
> On Thu, Aug 06, 2009 at 01:52:41PM +0200, pHilipp Zabel wrote:
>> On Thu, Aug 6, 2009 at 12:29 AM, Daniel Mack<daniel@caiaq.de> wrote:
>> > On Wed, Aug 05, 2009 at 09:49:52PM +0200, Frans Pop wrote:
>> >> Daniel Mack wrote:
>> >> > +static struct dev_pm_ops pda_power_pm_ops =3D {
>> >> > + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D pda_power_suspend,
>> >> > + =A0 =A0 =A0 .freeze =A0 =A0 =A0 =A0 =3D pda_power_freeze,
>> >>
>> >> Hmmm. Where's pda_power_freeze defined? Forgot to (compile)test the
>> >> patches?
>> >
>> > Yes, sorry. I can't test hibernation, so I didn't pay enough attention.
>> > I'll resend them anyway with Rafael's new macro used.
>>
>> After Rafael's comments on gpio_keys, I believe also here
>> .freeze/.thaw should be empty. enable/disable_irq_wake should be
>> called from .poweroff/.restore.
>
> Yes. See the version below.
>
> Thanks,
> Daniel
>
>
> From 6b534fb029f4623a8ddd60a4ea636bd626d6382a Mon Sep 17 00:00:00 2001
> From: Daniel Mack <daniel@caiaq.de>
> Date: Wed, 5 Aug 2009 15:31:23 +0200
> Subject: [PATCH 1/3] pda-power: switch to new dev_pm_ops
>
> The callbacks for the implemented functions are .poweroff and .restore,
> as they only care for {dis,en}able_irq(). Renamed the functions to
> reflect that.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Ian Molton <spyro@f2s.com>
> Cc: Anton Vorontsov <cbou@mail.ru>
> Cc: Matt Reimer <mreimer@vpop.net>
> ---
> =A0drivers/power/pda_power.c | =A0 25 ++++++++++++++++---------
> =A01 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/power/pda_power.c b/drivers/power/pda_power.c
> index a232de6..c46a6dc 100644
> --- a/drivers/power/pda_power.c
> +++ b/drivers/power/pda_power.c
> @@ -402,9 +402,9 @@ static int pda_power_remove(struct platform_device *p=
dev)
> =A0static int ac_wakeup_enabled;
> =A0static int usb_wakeup_enabled;
>
> -static int pda_power_suspend(struct platform_device *pdev, pm_message_t =
state)
> +static int pda_power_poweroff(struct device *dev)
> =A0{
> - =A0 =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
> + =A0 =A0 =A0 if (device_may_wakeup(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ac_irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ac_wakeup_enabled =3D !ena=
ble_irq_wake(ac_irq->start);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (usb_irq)
> @@ -414,9 +414,9 @@ static int pda_power_suspend(struct platform_device *=
pdev, pm_message_t state)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int pda_power_resume(struct platform_device *pdev)
> +static int pda_power_restore(struct device *dev)
> =A0{
> - =A0 =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
> + =A0 =A0 =A0 if (device_may_wakeup(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (usb_irq && usb_wakeup_enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable_irq_wake(usb_irq->=
start);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ac_irq && ac_wakeup_enabled)
> @@ -425,21 +425,28 @@ static int pda_power_resume(struct platform_device =
*pdev)
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +
> +static struct dev_pm_ops pda_power_pm_ops =3D {
> + =A0 =A0 =A0 .poweroff =A0 =A0 =A0 =3D pda_power_poweroff,
> + =A0 =A0 =A0 .restore =A0 =A0 =A0 =A0=3D pda_power_restore,
> +};

No no, now you're missing .suspend/.resume. As I understand it, the
suspend and hibernation codepaths are now completely separate.

Also, I'm not sure using .restore here is quite correct.
enable_irq_wake is called in .poweroff, after .freeze + creation of
the memory image. So if this memory image is restored during the next
boot, there is no trace of irq wakup ever being enabled and thus no
need to call disable_irq_wake.

I think just .suspend/.poweroff and .resume need to be used for this driver.

> +
> +#define PDA_POWER_PM_OPS (&pda_power_pm_ops)
> +
> =A0#else
> -#define pda_power_suspend NULL
> -#define pda_power_resume NULL
> +#define PDA_POWER_PM_OPS NULL
> =A0#endif /* CONFIG_PM */
>
> =A0MODULE_ALIAS("platform:pda-power");
>
> =A0static struct platform_driver pda_power_pdrv =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "pda-power",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "pda-power",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D PDA_POWER_PM_OPS,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.probe =3D pda_power_probe,
> =A0 =A0 =A0 =A0.remove =3D pda_power_remove,
> - =A0 =A0 =A0 .suspend =3D pda_power_suspend,
> - =A0 =A0 =A0 .resume =3D pda_power_resume,
> =A0};
>
> =A0static int __init pda_power_init(void)
> --
> 1.6.3.3
>
>

regards
Philipp
