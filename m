From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 4/5] input: gpio-keys: switch to new
	dev_pm_ops
Date: Thu, 6 Aug 2009 00:33:42 +0200
Message-ID: <20090805223342.GG19257__9802.51975493065$1249511687$gmane$org@buzzloop.caiaq.de>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
	<1249496971-9019-2-git-send-email-daniel@caiaq.de>
	<1249496971-9019-3-git-send-email-daniel@caiaq.de>
	<1249496971-9019-4-git-send-email-daniel@caiaq.de>
	<74d0deb30908051315l43b00731yb79f7937707068ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <74d0deb30908051315l43b00731yb79f7937707068ec@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Phil Blundell <pb@handhelds.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 05, 2009 at 10:15:52PM +0200, pHilipp Zabel wrote:
> On Wed, Aug 5, 2009 at 8:29 PM, Daniel Mack<daniel@caiaq.de> wrote:
> > -static int gpio_keys_resume(struct platform_device *pdev)
> > +static int gpio_keys_resume(struct device *dev)
> > =A0{
> > - =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.platf=
orm_data;
> > + =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D dev->platform_d=
ata;
> > =A0 =A0 =A0 =A0int i;
> >
> > - =A0 =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
> > + =A0 =A0 =A0 if (device_may_wakeup(dev)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < pdata->nbuttons; i++) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct gpio_keys_button =
*button =3D &pdata->buttons[i];
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (button->wakeup) {
> > @@ -251,19 +251,27 @@ static int gpio_keys_resume(struct platform_devic=
e *pdev)
> >
> > =A0 =A0 =A0 =A0return 0;
> > =A0}
> > +
> > +static struct dev_pm_ops gpio_keys_pm_ops =3D {
> > + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D gpio_keys_suspend,
> > + =A0 =A0 =A0 .freeze =A0 =A0 =A0 =A0 =3D gpio_keys_suspend,
> > + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D gpio_keys_resume,
> > + =A0 =A0 =A0 .thaw =A0 =A0 =A0 =A0 =A0 =3D gpio_keys_resume,
> =

> I'm not sure I understand hibernation correctly, but isn't
> .freeze/.thaw about saving state and halting/resuming the device
> operation only?
> It seems to me that enabling system wakeup functionality should go
> into .poweroff. (See <linux/pm.h>)

Frankly, I'm not sure either. But luckily, the linux-pm list is copied
so someone can elborate on this :)

Daniel
