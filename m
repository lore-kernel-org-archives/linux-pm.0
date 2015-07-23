From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCHv2 0/3] regmap: Use different lockdep class for each
 regmap init call
Date: Thu, 23 Jul 2015 17:12:50 +0100
Message-ID: <20150723161250.GA19124@e106497-lin.cambridge.arm.com>
References: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
 <CANMq1KD8rOHjtWA1Eiw9GATdTeq1Ch4bga4ZAty26auvWyX7Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANMq1KD8rOHjtWA1Eiw9GATdTeq1Ch4bga4ZAty26auvWyX7Og@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lee Jones <lee.jones@linar>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 23, 2015 at 09:45:53AM +0100, Nicolas Boichat wrote:
> Hi Mark,
>=20
> On Wed, Jul 8, 2015 at 2:30 PM, Nicolas Boichat <drinkcat@chromium.or=
g> wrote:
> > Second version. Small fixup in the regmap patch itself [3/3] (the
> > declaration of __devm_regmap_init_ac97 was missing lock_key/name
> > parameters).
> >
> > Also, there are 2 drivers that are using function pointers named
> > "regmap_init", which causes problems as it is now a macro: put thes=
e
> > in parentheses to prevent the preprocessor from substituting them.
> >
> > Patches 1+2 should be pushed first to avoid breaking git bissect.
> >
> > Compile tested with allyesconfig on x86_64 and arm.
> >
> > Nicolas Boichat (3):
> >   mfd: vexpress: Add parentheses around bridge->ops->regmap_init ca=
ll
> >   thermal: sti: Add parentheses around bridge->ops->regmap_init cal=
l
> >   regmap: Use different lockdep class for each regmap init call
>=20
> What's the status of this series (and the additional documentation
> fix: https://lkml.org/lkml/2015/7/8/385)?
>=20
> Do we need acks from the mfd/vexpress and thermal maintainers?
> (mfd/vexpress maintainers are Liviu Dudau, Sudeep Holla, and Lorenzo
> Pieralisi, I'm less clear about thermal, maybe Eduardo Valentin?)

Hi Nicolas,

Me and Lorenzo are currently tied with other tasks this week, hope to b=
e
able to review your patches next week.

Best regards,
Liviu

>=20
> Thanks!
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
