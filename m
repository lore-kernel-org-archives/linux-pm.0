From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/5] input: gpio-keys: switch to new
	dev_pm_ops
Date: Thu, 6 Aug 2009 02:51:55 +0200
Message-ID: <200908060251.55157.rjw__15958.8973423981$1249519967$gmane$org@sisk.pl>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
	<74d0deb30908051315l43b00731yb79f7937707068ec@mail.gmail.com>
	<20090805223342.GG19257@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090805223342.GG19257@buzzloop.caiaq.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-input@vger.kernel.org, Phil Blundell <pb@handhelds.org>, pHilipp Zabel <philipp.zabel@gmail.com>, Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 06 August 2009, Daniel Mack wrote:
> On Wed, Aug 05, 2009 at 10:15:52PM +0200, pHilipp Zabel wrote:
> > On Wed, Aug 5, 2009 at 8:29 PM, Daniel Mack<daniel@caiaq.de> wrote:
> > > -static int gpio_keys_resume(struct platform_device *pdev)
> > > +static int gpio_keys_resume(struct device *dev)
> > >  {
> > > -       struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
> > > +       struct gpio_keys_platform_data *pdata = dev->platform_data;
> > >        int i;
> > >
> > > -       if (device_may_wakeup(&pdev->dev)) {
> > > +       if (device_may_wakeup(dev)) {
> > >                for (i = 0; i < pdata->nbuttons; i++) {
> > >                        struct gpio_keys_button *button = &pdata->buttons[i];
> > >                        if (button->wakeup) {
> > > @@ -251,19 +251,27 @@ static int gpio_keys_resume(struct platform_device *pdev)
> > >
> > >        return 0;
> > >  }
> > > +
> > > +static struct dev_pm_ops gpio_keys_pm_ops = {
> > > +       .suspend        = gpio_keys_suspend,
> > > +       .freeze         = gpio_keys_suspend,
> > > +       .resume         = gpio_keys_resume,
> > > +       .thaw           = gpio_keys_resume,
> > 
> > I'm not sure I understand hibernation correctly, but isn't
> > .freeze/.thaw about saving state and halting/resuming the device
> > operation only?

It is.

> > It seems to me that enabling system wakeup functionality should go
> > into .poweroff. (See <linux/pm.h>)

That's correct.

And .restore() plays the role of ".resume() from hibernation".

> Frankly, I'm not sure either. But luckily, the linux-pm list is copied
> so someone can elborate on this :)

HTH

Best,
Rafael
