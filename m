From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: [PATCH 0/8] Cpufreq, cpu hotplug, suspend/resume related fixes
Date: Sat, 13 Jul 2013 15:50:09 +0200
Message-ID: <51E15B11.4070907@gmx.de>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com> <51E11C82.8000805@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51E11C82.8000805@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, viresh.kumar@linaro.org, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/13/2013 11:23 AM, Toralf F=C3=B6rster wrote:
> On 07/12/2013 12:15 AM, Srivatsa S. Bhat wrote:
>> And I'd of course appreciate to hear from Dirk, Tianyu and Toralf to=
 know
>> whether their systems work fine after:
>> a. applying only the first commit (this is what gets backported to s=
table)
>=20
> applied on top of straight 3.10 .0 : Breaks my system completely -

overlooked, that the 8 patches are 3.11/3.12 material - but nevertheles=
s :

Applied 1/8 on top of v3.10-9289-g9903883 brought same bad picture as
described for 3.10.0

And applying patches 1-8 on top of that commit id just gives the same
pciture - systems hangs during s2ram completly


> trying s2ram just blanks the console, lets the power led blinking,
> neither sys-rq nor anything else worked now, no output to console nor=
 to
> syslog
>=20
>> b. applying all the commits
> patch 2#8 doesn't apply at 3.10.0 (neither after patch 1#8 nor direct=
ly)

I attached the .config I'm using for my tests
(/me wonders if it is worth to notice, that it is a 32bit system booted
from an external USB drive ?)

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
