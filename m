From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC] cpufreq-cpu0: allow OPP table supplied by platform
Date: Thu, 13 Mar 2014 10:43:09 -0700
Message-ID: <232645eb-183a-4a7c-997b-db3ab149d72b@TX2EHSMHS013.ehs.local>
References: <20140313184859.7d6f6512@xhacker>
 <CAKohpokLv0m+Cky7nCUOgP-djTMrA6jyka_EZ07+_exCAexXXg@mail.gmail.com>
 <CAKohpoke1i8xmKProgF+ki7Q=Q+YxbPnewdtbyPqu7857DLLWA@mail.gmail.com>
 <20140313194424.122ec572@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140313194424.122ec572@xhacker>
Sender: cpufreq-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2014-03-13 at 07:44PM +0800, Jisheng Zhang wrote:
> Fixing lakml :)
>=20
> sorry
>=20
> On Thu, 13 Mar 2014 03:56:46 -0700
> Viresh Kumar <viresh.kumar@linaro.org> wrote:
>=20
> > Fixing Rafael's id.
> >=20
> > On 13 March 2014 16:25, Viresh Kumar <viresh.kumar@linaro.org> wrot=
e:
> > > On 13 March 2014 16:18, Jisheng Zhang <jszhang@marvell.com> wrote=
:
> > >> Hi all,
> > >>
> > >> cpufreq-cpu0 is suitable for Marvell Berlin SoC. But there's one=
 issue
> > >> to address. The opp is different between chips even on the same =
step
> > >> SoC, BG2Q for example. we can calculate the OPP table from the v=
alue of
> > >> one OTP register. We have two solutions:
> > >>
> > >> 1. bootloader reads OTP register and calculate the OPP table the=
n change
> > >> dtb danamically
> > >>
> > >> 2. supply one driver in mach-berlin to initialize the OPP table;=
 and
> > >> modify cpufreq-cpu0 to allow platform supply OPP table, fall bac=
k to
> > >> of_init_opp_table() if there's no OPP table.
> > >>
> > >> Which solution is better?
> > >
> > > I think we can go ahead with second option here. We can just chec=
k if opp
> > > tables are already initialized or not. In case they are, don't pr=
obe from
> > > dt..
> > >
> > > But lets see with others have to say here..

This might become useful for Zynq as well. We essentially allow to boot
with all kind of different frequencies and depending on how the PLL, an=
d clock
registers get setup by the bootloader, certain frequencies may or may
not become possible. Having a way to dynamically build an OPP table
would probably be a nicer way than having to tell everybody to adjust
the DT according to how the bootloader sets up the clocks.

	S=C3=B6ren


