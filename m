From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 1/2] thermal/int340x_thermal: Add additional UUIDs
Date: Wed, 23 Jan 2019 11:44:02 +1100
Message-ID: <CACPK8Xdb0fEjU3kf_ZETtYE+D42QF-fNQacaHjVsLeE4MU0qFw@mail.gmail.com>
References: <20181010083007.239938-1-matthewgarrett@google.com>
 <20181010083007.239938-2-matthewgarrett@google.com> <1543849707.2841.9.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543849707.2841.9.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <matthewgarrett@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>, Nisha Aram <nisha.aram@intel.com>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

On Tue, 4 Dec 2018 at 02:12, Zhang Rui <rui.zhang@intel.com> wrote:
> On =E4=B8=89, 2018-10-10 at 01:30 -0700, Matthew Garrett wrote:
> > Platforms support more DPTF policies than the driver currently
> > exposes.
> > Add them. This effectively reverts
> > 31908f45a583e8f21db37f402b6e8d5739945afd which removed several UUIDs
> > without explaining why.
> >
> I'm going to apply this patch series, just with two minor changes,
> 1. 31908f45a583e8f21db37f402b6e8d5739945afd does not follow the git
> commit description style 'commit <12+ chars of sha1> ("<title line>")'
> 2. the UUIDs were removed previously because these policies were not
> used.

Which tree did this series get applied to?

Cheers,

Joel

>
> thanks,
> rui
>
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Nisha Aram <nisha.aram@intel.com>
> > ---
> >  drivers/thermal/int340x_thermal/int3400_thermal.c | 14
> > ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c
> > b/drivers/thermal/int340x_thermal/int3400_thermal.c
> > index e26b01c05e82..51c9097eaf7a 100644
> > --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> > +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> > @@ -22,6 +22,13 @@ enum int3400_thermal_uuid {
> >       INT3400_THERMAL_PASSIVE_1,
> >       INT3400_THERMAL_ACTIVE,
> >       INT3400_THERMAL_CRITICAL,
> > +     INT3400_THERMAL_ADAPTIVE_PERFORMANCE,
> > +     INT3400_THERMAL_EMERGENCY_CALL_MODE,
> > +     INT3400_THERMAL_PASSIVE_2,
> > +     INT3400_THERMAL_POWER_BOSS,
> > +     INT3400_THERMAL_VIRTUAL_SENSOR,
> > +     INT3400_THERMAL_COOLING_MODE,
> > +     INT3400_THERMAL_HARDWARE_DUTY_CYCLING,
> >       INT3400_THERMAL_MAXIMUM_UUID,
> >  };
> >
> > @@ -29,6 +36,13 @@ static char
> > *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] =3D {
> >       "42A441D6-AE6A-462b-A84B-4A8CE79027D3",
> >       "3A95C389-E4B8-4629-A526-C52C88626BAE",
> >       "97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
> > +     "63BE270F-1C11-48FD-A6F7-3AF253FF3E2D",
> > +     "5349962F-71E6-431D-9AE8-0A635B710AEE",
> > +     "9E04115A-AE87-4D1C-9500-0F3E340BFE75",
> > +     "F5A35014-C209-46A4-993A-EB56DE7530A1",
> > +     "6ED722A7-9240-48A5-B479-31EEF723D7CF",
> > +     "16CAF1B7-DD38-40ED-B1C1-1B8A1913D531",
> > +     "BE84BABF-C4D4-403D-B495-3128FD44dAC1",
> >  };
> >
> >  struct int3400_thermal_priv {
