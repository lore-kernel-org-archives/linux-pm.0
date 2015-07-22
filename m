From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] regulator: rk808: make better use of the gpiod API
Date: Wed, 22 Jul 2015 09:13:51 +0900
Message-ID: <55AEE03F.8060100@samsung.com>
References: <20150721132945.7ffc443b@canb.auug.org.au>
 <1437461993-14860-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAJKOXPfY4zYtWKa6U4mzBjtS87HZepOV_hHodU2QJaJrLcr9qQ@mail.gmail.com>
 <20150721143524.GD9981@pengutronix.de> <20150721144100.GU11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-reply-to: <20150721144100.GU11162@sirena.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, =?windows-1252?Q?Uwe_Kleine-K=F6ni?= =?windows-1252?Q?g?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Zhong <zyw@rock-chips.com>, kernel@pengutronix.de, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21.07.2015 23:41, Mark Brown wrote:
> On Tue, Jul 21, 2015 at 04:35:24PM +0200, Uwe Kleine-K=F6nig wrote:
>> On Tue, Jul 21, 2015 at 10:09:32PM +0900, Krzysztof Kozlowski wrote:
>=20
>>> The function looks empty so it can be removed entirely.
>=20
>> I assumed that not having a remove function makes the device not
>> detachable. Not sure about that.
>=20
> No, of course not - the remove function is completely optional.
>=20
>> Looking at the code I found that not having a remove function can yi=
eld
>> surprises, though. If your driver has a probe but no remove function=
 the
>> platform bus glue calls
>=20
>> 	dev_pm_domain_attach(_dev, true);
>=20
>> at probe time, but not
>=20
>> 	dev_pm_domain_detach(_dev, true);
>=20
>> at remove. I admit I don't know about that dev_pm_domain stuff, but =
it
>> looks wrong to only have one but not the other. Greg?
>=20
> That looks like a bug, yes.

Cc: linux-pm, Kevin, Rafael, Ulf

I agree, device should be detached from domain regardless of presence o=
f
remove callback.

Documentation (like Documentation/driver-model/driver.txt) does not
mention that remove callback is necessary for unbinding devices. There
is no sense in storing empty removal callbacks.

Best regards,
Krzysztof
