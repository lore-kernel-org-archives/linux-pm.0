From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Cpufreq: Change sysfs interface cpuinfo_cur_freq access privilege
Date: Mon, 25 Nov 2013 12:26:46 +0100
Message-ID: <5074010.ha99UACE9S@vostro.rjw.lan>
References: <1385348018-30525-1-git-send-email-tianyu.lan@intel.com> <CAKohponvz8CjDpMbx=BXpBv5q8d4x94No90sJWjVsTRS_Uj1jw@mail.gmail.com> <5292E133.1040800@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5292E133.1040800@intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, hg197@gmx.de, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, November 25, 2013 01:33:39 PM Lan Tianyu wrote:
> On 2013=E5=B9=B411=E6=9C=8825=E6=97=A5 12:30, Viresh Kumar wrote:
> > On 25 November 2013 08:23, Lan Tianyu <tianyu.lan@intel.com> wrote:
> >> Currently, cpuinfo_cur_freq is only accessible for root user while
> >> other cpufreq sysfs interfaces(E,G scaling_cur_freq) are available
> >> to ordinary user. This seems make no sense. This patch is to chang=
e
> >> it.
> >=20
> > There is nothing wrong with the code and so this is more of a desig=
n
> > change..
> >=20
> > Probably Rafael can help us here as cpufreq_cur_freq will read stuf=
f
> > directly from hardware instead of using cached value in software.
>=20
> I think so, too. I also tried to checking the reason of the privilege=
 by
> git log but the code was there before linux kernel being migrated to =
git
> repository.

And it has always behaved in the same way?  Then I wouldn't change it.

Thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
