From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: [PATCH 0/8] Cpufreq, cpu hotplug, suspend/resume related fixes
Date: Sat, 13 Jul 2013 11:23:14 +0200
Message-ID: <51E11C82.8000805@gmx.de>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, viresh.kumar@linaro.org, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/12/2013 12:15 AM, Srivatsa S. Bhat wrote:
> And I'd of course appreciate to hear from Dirk, Tianyu and Toralf to =
know
> whether their systems work fine after:
> a. applying only the first commit (this is what gets backported to st=
able)

applied on top of straight 3.10 .0 : Breaks my system completely -
trying s2ram just blanks the console, lets the power led blinking,
neither sys-rq nor anything else worked now, no output to console nor t=
o
syslog

> b. applying all the commits
patch 2#8 doesn't apply at 3.10.0 (neither after patch 1#8 nor directly=
)

=46WIW /me double checked all those test results

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
