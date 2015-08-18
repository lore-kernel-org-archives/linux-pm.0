From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v2 0/6] ARM: berlin: add cpufreq support
Date: Tue, 18 Aug 2015 16:39:11 +0200
Message-ID: <20150818143911.GB12017@kwain>
References: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
 <CAOh2x=ke9NWa-GjL=c+RgEWWfsNeKvE2O9CRHmW2dG5mj8ATCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOh2x=ke9NWa-GjL=c+RgEWWfsNeKvE2O9CRHmW2dG5mj8ATCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, zmxu@marvell.com, jszhang@marvell.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Aug 18, 2015 at 06:26:42PM +0530, Viresh Kumar wrote:
> On Tue, Aug 18, 2015 at 5:16 PM, Antoine Tenart
> <antoine.tenart@free-electrons.com> wrote:
> >
> > This series adds the cpufreq support to the Berlin SoCs, using
> > cpufreq-dt.
> >
> > First, the cpuclk clock is added to the BG2Q clock driver. This clo=
ck
> > has a divider fixed to 1, so we use a fixed factor clock here.
> >
> > Then register a platform device for cpufreq-dt.
> >
> > I also added the OPP table definition in the BG2Q, BG2 and BG2CD de=
vice
> > trees. When using a BG2Q, some bootloaders may update this table wh=
en
> > booting (mine doesn't).
>=20
> You can switch to OPP-v2 bindings if you want. Just have a look, they=
 are
> much more powerful.. Should be in linux-next/master.

Nice!

However, it seems the OPP-v2 table takes precedence over the old one.
When a default OPP-v2 table is supplied in the device tree, if the
bootloader supplies an OPP table the old way it won't be taken into
account.

So if I understood correctly, this won't work here for the BG2Q.

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
