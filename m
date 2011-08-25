From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2] Add regulator driver for the bq2407x
	family of charger ICs.
Date: Thu, 25 Aug 2011 10:51:53 +0200
Message-ID: <201108251051.53852.heiko@sntech.de>
References: <201108202224.52250.heiko@sntech.de>
	<201108242048.27461.heiko@sntech.de>
	<CAJ0PZbQRGCHAQ1HxDmbf6uN8iz3CCcqjOVRtc63Cjn17EXak1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ0PZbQRGCHAQ1HxDmbf6uN8iz3CCcqjOVRtc63Cjn17EXak1A@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi MyungJoo

Am Donnerstag, 25. August 2011, 08:55:29 schrieb MyungJoo Ham:
> On Thu, Aug 25, 2011 at 3:48 AM, Heiko St=FCbner <heiko@sntech.de> wrote:
> > This driver controls a TI bq2407x charger attached via GPIOs.
> > The provided current regulator can enable/disable charging and
> > select between 100 mA, 500 mA and a machine specific current limit.
> > =

> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> =

> This looks like a bq24022 driver + max-current-mode ("USB standby"
> seems not implemented in the driver). Wouldn't it be possible to patch
> bq24022 driver so that the bq24022 driver becomes compatible with this
> bq2407x?
> =

> 2407x's EN1 =3D 24022's iset2
> 2407x's nce =3D 24022's nce
> =

> I think you may simply let the driver ignore EN2 (and max-current
> mode) if the supplied EN2 in pdata is NULL, then, the driver will be
> compatible for both.

Thanks for adding a new perspective on this. The way you put it, it seems =

quite easy to do it this way and integrate it into the bq24022 driver.

So I will give it shot this evening and will see were it leads me.

Thanks
Heiko
