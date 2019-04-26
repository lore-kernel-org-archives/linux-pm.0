From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Notify also about status changes
Date: Fri, 26 Apr 2019 11:57:56 +0200
Message-ID: <CAJKOXPedb=TX=4ZDW4SARPBb5_K_zMFVBA3wJCYTieTuxk+9xg@mail.gmail.com>
References: <1556270808-21331-1-git-send-email-krzk@kernel.org> <20190426093243.zazld4wwv4qybwaf@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426093243.zazld4wwv4qybwaf@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 26 Apr 2019 at 11:32, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote:
>
> On Friday 26 April 2019 11:26:48 Krzysztof Kozlowski wrote:
> > User-space might be interested in receiving uevents when the charging
> > starts/stops or if conditions of battery changes (e.g.
> > over-temperature).  Notify about changes in battery also when the flags
> > change, not only SoC.
>
> This looks like a good idea.
>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/power/supply/bq27xxx_battery.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/sup=
ply/bq27xxx_battery.c
> > index 29b3a4056865..cb9306160c14 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -1612,7 +1612,8 @@ void bq27xxx_battery_update(struct bq27xxx_device=
_info *di)
> >                       di->charge_design_full =3D bq27xxx_battery_read_d=
cap(di);
> >       }
> >
> > -     if (di->cache.capacity !=3D cache.capacity)
> > +     if ((di->cache.capacity !=3D cache.capacity) || \
>                                                       ^^
>                                       You have there an extra backslash

Indeed, Thanks! Let me send v2.

Best regards,
Krzysztof
