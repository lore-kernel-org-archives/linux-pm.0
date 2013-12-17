From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
Date: Tue, 17 Dec 2013 10:53:47 +0100
Message-ID: <20131217105347.75954ad3@ipc1.ka-ro>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
	<1387228450-641-2-git-send-email-b20788@freescale.com>
	<20131217025616.GC6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20131217025616.GC6691@S2101-09.ap.freescale.net>
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Anson Huang <b20788@freescale.com>, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

Shawn Guo wrote:
> On Mon, Dec 16, 2013 at 04:14:10PM -0500, Anson Huang wrote:
> > on i.MX6Q, cpu freq change need to follow below flows:
> >=20
> > 1. each setpoint has different VDDARM, VDDSOC/PU voltage, get the s=
etpoint
> > table from dts;
> > 2. when cpu freq is scaling up, need to increase VDDSOC/PU voltage =
before
> > VDDARM, if VDDPU is off, no need to change it;
> > 3. when cpu freq is scaling down, need to decrease VDDARM voltage b=
efore
> > VDDSOC/PU, if VDDPU is off, no need to change it;
> >=20
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> > ---
[...]
> > +	if (soc_opp_index >=3D soc_opp_count) {
>=20
> Can soc_opp_index be possibly greater than soc_opp_count?  Otherwise,
> the condition check below is good enough?
>=20
> 	if (soc_opp_index =3D=3D soc_opp_count)
>
it doen't harm to be on the safe side and use >=3D anyway!


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
