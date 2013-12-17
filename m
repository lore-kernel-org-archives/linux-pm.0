From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
Date: Tue, 17 Dec 2013 20:14:00 +0800
Message-ID: <20131217121358.GM6691@S2101-09.ap.freescale.net>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
 <20131217025616.GC6691@S2101-09.ap.freescale.net>
 <20131217105347.75954ad3@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131217105347.75954ad3@ipc1.ka-ro>
Sender: cpufreq-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Anson Huang <b20788@freescale.com>, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 17, 2013 at 10:53:47AM +0100, Lothar Wa=DFmann wrote:
> > > +	if (soc_opp_index >=3D soc_opp_count) {
> >=20
> > Can soc_opp_index be possibly greater than soc_opp_count?  Otherwis=
e,
> > the condition check below is good enough?
> >=20
> > 	if (soc_opp_index =3D=3D soc_opp_count)
> >
> it doen't harm to be on the safe side and use >=3D anyway!

Well, it may confuse reader.  At least, it took me some time understand
how that ">" condition will happen.  And it turns out never.

Shawn

