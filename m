From: <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Date: Tue, 15 Jan 2019 09:19:15 +0000
Message-ID: <6cce226c-882a-9356-7be6-769d30ef0380@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
 <20190109165706.GG10405@sirena.org.uk>
 <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
 <20190111123913.GA2804@sirena.org.uk>
 <40a2dbb6-56aa-173a-4be0-d7072ed32b53@microchip.com>
 <20190114225311.GJ11073@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114225311.GJ11073@sirena.org.uk>
Content-Language: en-US
Content-ID: <3C69424740B90D49ABB8C2FFEDEA518A@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux@armlinux.org.uk, lgirdwood@gmail.com, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 15.01.2019 00:53, Mark Brown wrote:
> On Fri, Jan 11, 2019 at 02:08:19PM +0000, Claudiu.Beznea@microchip.com wr=
ote:
>> On 11.01.2019 14:39, Mark Brown wrote:
>=20
>>> Like I say I'm working offline so I can't check the links but it sounds
>>> like you're saying that the existing suspend mode configuration feature=
s
>>> are enough for your systems?=20
>=20
>> Yes, if we rely on the fact that core's regulator device tree bindings f=
or
>> suspend-to-mem/suspend-to-standby were filled correctly.
>=20
>> The function I added here was to double check that core's regulator will=
 be
>> off in suspend/standby based on what was parsed from DT.
>=20
> Ah, so it's being used as a consistency check?=20

Yes, that was the idea.

Thank you,
Claudiu Beznea

> OK, that does make sense
> to me. =20
>=20
