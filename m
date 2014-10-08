From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 1/1] Cpufreq: Keep cpufreq sysfs nodes across S2RAM/S2DISK
 when using intel_pstate driver.
Date: Wed, 08 Oct 2014 14:48:42 +0800
Message-ID: <5434DE4A.60604@intel.com>
References: <1411023787-11458-1-git-send-email-tianyu.lan@intel.com> <CAKohpokht4=7XCftPYa5PqpPMN-O-5b_RjJ3BgHnxjYV4VzyTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:45220 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbaJHGxC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Oct 2014 02:53:02 -0400
In-Reply-To: <CAKohpokht4=7XCftPYa5PqpPMN-O-5b_RjJ3BgHnxjYV4VzyTg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>

Sorry later response and just back from vacation.

On 2014=E5=B9=B409=E6=9C=8829=E6=97=A5 16:20, Viresh Kumar wrote:
> But this change is buggy.. Because you are updating 'cpufreq_suspende=
d'
> before actually stopping the governor, any calls to __cpufreq_governo=
r()
> will be converted to NO-operations because of this in __cpufreq_gover=
nor():
>=20
> /* Don't start any governor operations if we are entering suspend */
> if (cpufreq_suspended)
>     return 0;
>=20
> And so the governor's will never stop :(
>=20
> So you need to keep the above line where it was :)
>=20

Yes, you are right. Thanks for fixing it.
--=20
Best regards
Tianyu Lan
