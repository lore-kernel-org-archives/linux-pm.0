From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 4/9] pinctrl: samsung: Use generic of_device_get_match_data
 helper
Date: Tue, 27 Dec 2016 11:28:19 +0100
Message-ID: <24311776.ZSthnveUhx@amdc3058>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CA+Ln22FfYkxJAOtpfr1UUai6vZej09NSZa6cz2cuO2aHN8Trmw@mail.gmail.com>
 <20161226094142.hajrgye5632mgoup@kozik-lap>
 <CGME20161227102821epcas1p334154772e0a1f636795994ca5bcc5eac@epcas1p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20161226094142.hajrgye5632mgoup@kozik-lap>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org


Hi,

On Monday, December 26, 2016 11:41:42 AM Krzysztof Kozlowski wrote:
> On Mon, Dec 26, 2016 at 02:44:26PM +0900, Tomasz Figa wrote:
> > 2016-12-25 21:56 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> > > On Fri, Dec 23, 2016 at 01:24:44PM +0100, Marek Szyprowski wrote:
> > >> Replace custom code with generic helper.
> > >>
> > >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > >> ---
> > >>  drivers/pinctrl/samsung/pinctrl-samsung.c | 9 ++++-----
> > >>  1 file changed, 4 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> > >> index 4d9262051ff1..a6c2ea74e0f3 100644
> > >> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> > >> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> > >> @@ -27,6 +27,7 @@
> > >>  #include <linux/err.h>
> > >>  #include <linux/gpio.h>
> > >>  #include <linux/irqdomain.h>
> > >> +#include <linux/of_device.h>
> > >>  #include <linux/spinlock.h>
> > >>  #include <linux/syscore_ops.h>
> > >>
> > >> @@ -967,15 +968,13 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
> > >>       return 0;
> > >>  }
> > >>
> > >> -static const struct of_device_id samsung_pinctrl_dt_match[];
> > >> -
> > >>  /* retrieve the soc specific data */
> > >>  static const struct samsung_pin_ctrl *
> > >>  samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
> > >>                            struct platform_device *pdev)
> > >>  {
> > >>       int id;
> > >> -     const struct of_device_id *match;
> > >> +     const struct samsung_pin_ctrl *match_data;
> > >>       struct device_node *node = pdev->dev.of_node;
> > >>       struct device_node *np;
> > >>       const struct samsung_pin_bank_data *bdata;
> > >> @@ -990,8 +989,8 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
> > >>               dev_err(&pdev->dev, "failed to get alias id\n");
> > >>               return ERR_PTR(-ENOENT);
> > >>       }
> > >> -     match = of_match_node(samsung_pinctrl_dt_match, node);
> > >> -     ctrl = (struct samsung_pin_ctrl *)match->data + id;
> > >> +     match_data = of_device_get_match_data(&pdev->dev);
> > >> +     ctrl = match_data + id;
> > >
> > > Either you need a check for match_data != NULL or just remove match_data
> > > and:
> > >         ctrl = of_device_get_match_data();
> > >         ctrl += id;
> > >
> > > Actually match_data can be removed even with the check for non-NULL...
> > 
> > I don't think this function can ever return NULL if the match array
> > contains a non-NULL value for each compatible string and the driver
> > can be probed only by DT.
> 
> Practically it cannot (or it should not) but defensive coding is a good
> practice...

Defensive coding is not a good practice, please don't recommend it.

It usually just obfuscates code and hides underlying issue.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
