From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] Cpufreq: Change sysfs interface cpuinfo_cur_freq access
 privilege
Date: Mon, 25 Nov 2013 13:33:39 +0800
Message-ID: <5292E133.1040800@intel.com>
References: <1385348018-30525-1-git-send-email-tianyu.lan@intel.com> <CAKohponvz8CjDpMbx=BXpBv5q8d4x94No90sJWjVsTRS_Uj1jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponvz8CjDpMbx=BXpBv5q8d4x94No90sJWjVsTRS_Uj1jw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, hg197@gmx.de, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2013=E5=B9=B411=E6=9C=8825=E6=97=A5 12:30, Viresh Kumar wrote:
> On 25 November 2013 08:23, Lan Tianyu <tianyu.lan@intel.com> wrote:
>> Currently, cpuinfo_cur_freq is only accessible for root user while
>> other cpufreq sysfs interfaces(E,G scaling_cur_freq) are available
>> to ordinary user. This seems make no sense. This patch is to change
>> it.
>=20
> There is nothing wrong with the code and so this is more of a design
> change..
>=20
> Probably Rafael can help us here as cpufreq_cur_freq will read stuff
> directly from hardware instead of using cached value in software.

I think so, too. I also tried to checking the reason of the privilege b=
y
git log but the code was there before linux kernel being migrated to gi=
t
repository.

>=20
> --
> viresh
>=20


--=20
Best regards
Tianyu Lan
