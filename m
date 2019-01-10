From: <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Date: Thu, 10 Jan 2019 10:24:26 +0000
Message-ID: <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
 <20190109165706.GG10405@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109165706.GG10405@sirena.org.uk>
Content-Language: en-US
Content-ID: <2E877C7434CA9147852E296151A845F9@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux@armlinux.org.uk, lgirdwood@gmail.com, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 09.01.2019 18:57, Mark Brown wrote:
> On Tue, Jan 08, 2019 at 10:56:32AM +0000, Claudiu.Beznea@microchip.com wr=
ote:
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> Add helper to check if regulator will be disabled in suspend.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> This feels like it's the wrong way round - if this is configurable I'd
> expect something to configure the suspend mode and then for that to
> arrange to configure the regulator appropriately (along with anything
> else that needs doing) rather than to infer the configuration from the
> regulator state which feels fragile.  But based on the cover letter
> that's kind of like what the initial proposal about target states was so
> perhaps this is the way we end up going...=20

Are you talking about [1] ?

this certainly looks a lot
> less impactful that the target state stuff though.
>=20

For the moment, the patches which describes the regulators states in
suspend for SAMA5D2 Xplained board (which we are trying to address here)
are in pending [2] (they were introduced with patches for act8945a
suspend/resume stuff). Probably they will be introduced after one more
Linux version.

I can get rid of this patch, take advantage of [3] and [4] and introduce
also the regulator standby states. In this case, no matter the mapping b/w
Linux power saving modes and AT91 SoC's power saving modes, we will be
covered on misconfiguration (at least on SAMA5D2 Xplained board).

And in patch 3/3 I could get rid of regulator checks and rely on DT (bad
thing would be that in case of no input for regulator's state in
mem/standby the board could not properly suspended/resumed), if any.

What do you think about this?

Thank you,
Claudiu Beznea

[1] https://patchwork.kernel.org/patch/9458445/
[2]
https://lore.kernel.org/lkml/1544543768-2066-6-git-send-email-claudiu.bezne=
a@microchip.com/
[3]
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commi=
t/?h=3Dfor-next&id=3Df2b4076988a9c229dab373470b4b108ef0e106c8
[4]
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commi=
t/?h=3Dfor-next&id=3D5279e96ff8033500b6008be5925ae2d20f42c434
