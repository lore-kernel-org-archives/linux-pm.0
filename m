From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [REGRESSION] fan always on with 3.10-rc2
Date: Thu, 13 Jun 2013 15:59:53 +0200
Message-ID: <20130613135952.GA16339@somewhere>
References: <15568618.SsOOjPSAq8@merkaba>
 <1825381.bJOGDrYABG@merkaba>
 <1461538.eEAU3Zp7hk@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35729 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab3FMN76 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2013 09:59:58 -0400
Content-Disposition: inline
In-Reply-To: <1461538.eEAU3Zp7hk@merkaba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Michael Karcher <Michael.Karcher@fu-berlin.de>

On Sun, Jun 09, 2013 at 08:34:10PM +0200, Martin Steigerwald wrote:
> Am Samstag, 8. Juni 2013, 22:34:44 schrieb Martin Steigerwald:
> > Am Freitag, 24. Mai 2013, 13:03:18 schrieb Martin Steigerwald:
> > > Hi!
> > >=20
> > > With 3.10-rc2 I see fan always or almost always on, even during e=
xtended
> > > periods of basically idling around. I did not notice this with 3.=
9. This is
> > > on an ThinkPad T520 with Intel Sandybridge i5-2520M dual core wit=
h
> > > hyperthreading at regularily 2,5 GhZ and Intel graphics (no nvidi=
a).
> > >=20
> > > I am using full hz:
> > >=20
> > > martin@merkaba:~/Linux/Kernel/Mainline/Bugs/fan always on with 3.=
10.2-rc2> xzgrep NO_HZ config-3.10.0-rc2-tp520.xz
> > > CONFIG_NO_HZ_COMMON=3Dy
> > > # CONFIG_NO_HZ_IDLE is not set
> > > CONFIG_NO_HZ_FULL=3Dy
> > > CONFIG_NO_HZ_FULL_ALL=3Dy
> > > CONFIG_NO_HZ=3Dy
> > > CONFIG_RCU_FAST_NO_HZ=3Dy
> > >=20
> > > And P-State driver (which I used in 3.9 already as well).
> > >=20
> > > Kernel config attached as xz. Use xzless or xzcat to display.
> > >=20
> > >=20
> > > What puzzles is output of powertop, especially:
> >=20
> > Still present in 3.10-rc4.
> >=20
> > I disabled P-State driver but then rpm seems to be even worse.
> >=20
> > Around 2800 rpm all the time, was about 2650 with Intel P State dri=
ver.
> >=20
> > Next I will try without CONFIG_NO_HZ_FULL and CONFIG_NO_HZ_FULL_ALL=
=2E
>=20
> Okay, without these both the behavior is better. Fan still does not s=
eem
> to get into non running state, which it was able to with earlier kern=
els
> (or userspaces?), but its down to a quiet 1950 rpm with Intel P-State=
 driver
> enabled again. CC=B4d to people from thread "power management regress=
ion
> in linux 3.10? (related to CONFIG_NO_HZ_FULL)" which I think is relat=
ed.
>=20
> Powertop values make a lot more sense as well:
>=20
> PowerTOP v2.0     Overview   Idle stats   Frequency stats   Device st=
ats   Tunables                                    =20
>=20
>=20
>           Package   |             Core    |            CPU 0       CP=
U 1
>                     |                     | C0 active   1,4%        0=
,9%
>                     |                     | POLL        0,0%    0,0 m=
s  0,0%    0,0 ms
>                     |                     | C1E-SNB     7,7%    3,0 m=
s  2,9%    5,3 ms
> C2 (pc2)    1,1%    |                     |
> C3 (pc3)    7,2%    | C3 (cc3)    8,4%    | C3-SNB      8,2%    3,1 m=
s  3,0%   15,2 ms
> C6 (pc6)    4,9%    | C6 (cc6)    9,3%    | C6-SNB      7,0%    3,5 m=
s  6,2%   13,0 ms
> C7 (pc7)    9,9%    | C7 (cc7)   64,3%    | C7-SNB     73,4%    6,8 m=
s 84,0%   21,6 ms
>=20
>                     |             Core    |            CPU 2       CP=
U 3
>                     |                     | C0 active   1,1%        0=
,9%
>                     |                     | POLL        0,0%    0,0 m=
s  0,0%    0,0 ms
>                     |                     | C1E-SNB    11,0%    6,9 m=
s  1,4%    4,8 ms
>                     |                     |
>                     | C3 (cc3)    9,3%    | C3-SNB      7,7%    5,8 m=
s  1,9%    6,0 ms
>                     | C6 (cc6)   10,0%    | C6-SNB      8,5%    7,4 m=
s  4,1%    4,9 ms
>                     | C7 (cc7)   64,9%    | C7-SNB     71,4%    8,2 m=
s 91,1%    7,1 ms
>=20
>=20
>=20
> PowerTOP v2.0     Overview   Idle stats   Frequency stats   Device st=
ats   Tunables                                    =20
>=20
>=20
>             Package |             Core    |            CPU 0       CP=
U 1
>                     |                     | Actual    2,0 GHz     2,4=
 GHz
> Idle        54,4%   | Idle        97,4%   | Idle        98,9%       9=
8,2%
> 2,90 GHz     0,6%   | 2,90 GHz     0,1%   | 2,90 GHz     0,1%        =
0,1%
> 2,81 GHz     2,6%   | 3,10 GHz     0,2%   | 3,10 GHz     0,1%        =
0,1%
> 3,10 GHz     1,2%   | 2,10 GHz     0,1%   | 2,10 GHz     0,0%        =
0,0%
> 3,21 GHz     7,3%   | 3,21 GHz     0,9%   | 3,21 GHz     0,1%        =
0,9%
> 2,10 GHz     2,3%   | 2,81 GHz     0,2%   | 2,81 GHz     0,1%        =
0,1%
> 3,00 GHz     3,5%   | 3,00 GHz     0,0%   | 3,00 GHz     0,0%        =
0,0%
> 2,40 GHz     3,5%   | 2,40 GHz     0,1%   | 2,40 GHz     0,1%        =
0,1%
> 1,91 GHz     1,0%   | 1,91 GHz     0,1%   | 1,91 GHz     0,0%        =
0,0%
> 2,21 GHz     0,6%   | 2,21 GHz     0,1%   | 2,21 GHz     0,1%        =
0,1%
>=20
>                     |             Core    |            CPU 2       CP=
U 3
>                     |                     | Actual    2,4 GHz     2,5=
 GHz
>                     | Idle        56,3%   | Idle        98,4%       5=
7,7%
>                     | 2,90 GHz     0,5%   | 2,90 GHz     0,1%        =
0,9%
>                     | 2,81 GHz     2,5%   | 2,81 GHz     0,1%        =
6,4%
>                     | 3,10 GHz     1,1%   | 3,10 GHz     0,2%        =
2,2%
>                     | 3,21 GHz     6,7%   | 3,00 GHz     0,0%        =
2,4%
>                     | 3,00 GHz     3,5%   | 3,21 GHz     0,5%        =
3,4%
>                     | 2,71 GHz     2,4%   | 2,50 GHz     0,1%        =
3,3%
>                     | 2,50 GHz     1,1%   | 2,31 GHz     0,1%        =
0,4%
>                     | 2,31 GHz     0,2%   | 2,71 GHz     0,1%        =
1,0%
>                     | 2,60 GHz     1,0%   | 2,60 GHz     0,1%        =
2,7%
>=20
>=20
> If I haven=B4t stated it. This is on a ThinkPad T520 with dual core
> Sandybridge i5-2620M at 2.5 GHz (overclockable to 3.2 GhZ), now with
> Kernel 3.10-rc5. I didn=B4t test this one with the full hz stuff enab=
led, only
> rc2 and rc4.
>=20
> > According to powertop CPU 0 is never idle

Note that CONFIG_NO_HZ_FULL is very power unfriendly because it forces =
CPU 0
to keep its periodic tick to handle timekeeping, even when idle. Paul M=
cKenney is
working on a solution to solve this.

Thanks.
