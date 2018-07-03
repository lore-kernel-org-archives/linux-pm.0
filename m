From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v4 2/3] power: supply: add cros-ec USBPD charger driver.
Date: Tue, 3 Jul 2018 11:46:39 +0200
Message-ID: <CAFqH_53wvx+v8fLvcg3HaZ6OsAW2itHGsbhU+YPpLRyF0Upz6Q@mail.gmail.com>
References: <20180502154418.2153-1-enric.balletbo@collabora.com>
 <20180502154418.2153-3-enric.balletbo@collabora.com> <20180524083420.nna6znszz2lp6jwo@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524083420.nna6znszz2lp6jwo@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, Gwendal Grignou <gwendal@chromium.org>, Sameer Nanda <snanda@chromium.org>, Linux PM list <linux-pm@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel <linux-kernel@vger.kernel.org>, Benson Leung <bleung@chromium.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, kernel@collabora.com, Fabien Parent <fparent@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Lee, Sebastian,

cc'ing Fabien

Missatge de Sebastian Reichel <sre@kernel.org> del dia dj., 24 de maig
2018 a les 10:38:
>
> Hi,
>
> On Wed, May 02, 2018 at 05:44:17PM +0200, Enric Balletbo i Serra wrote:
> > From: Sameer Nanda <snanda@chromium.org>
> >
> > This driver gets various bits of information about what is connected to
> > USB PD ports from the EC and converts that into power_supply properties.
> >
> > Signed-off-by: Sameer Nanda <snanda@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
>
> I suppose Lee's Ack was mainly for the no longer relevant MFD part
> of this patch.
>
> > ---
>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>
> I would be fine with merging this for 4.18, but it has a dependency
> on patch 1 for MFD. Lee, can you provide a immutable branch for
> patch 1?
>

I guess I already lost the open window to see these in 4.18. Doesn't matter :)

These patches now are blocking [1] to land, and also I have some
patches close to be ready to send that apply on top of these two
patchsets. I think both patchsets are fine so would be possible queue
all these patches for 4.19 and maybe create an immutable branch.

Many thanks,
 Enric

[1] https://lkml.org/lkml/2018/5/29/1328

> -- Sebastian
