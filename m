From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Change the calculation of next pstate
Date: Tue, 29 Apr 2014 23:52:19 +0200
Message-ID: <25001203.glgeYCc6ZZ@vostro.rjw.lan>
References: <535D80C8.9090906@semaphore.gr> <CAKohpomhUk7RQ3YL3=wpVKSbK_oSkyYBRUZiqnHzWqrZ2DjRRA@mail.gmail.com> <535FD4A6.3050905@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56992 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932148AbaD2Vfu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Apr 2014 17:35:50 -0400
In-Reply-To: <535FD4A6.3050905@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tuesday, April 29, 2014 07:34:46 PM Stratos Karafotis wrote:
> On 29/04/2014 07:58 =CF=80=CE=BC, Viresh Kumar wrote:
> > Cc'd Dirk,
> >=20
> > On 28 April 2014 03:42, Stratos Karafotis <stratosk@semaphore.gr> w=
rote:
> >> Currently the driver calculates the next pstate proportional to
> >> core_busy factor and reverse proportional to current pstate.
> >>
> >> Change the above method and calculate the next pstate independentl=
y
> >> of current pstate.
> >=20
> > We must mention why the change is required.
> >=20
>=20
> Hi Viresh,
>=20
> Actually, I can't say that it's required. :)
> I just believe that calculation of next p-state should be independent
> from current one. In my opinion we can't scale the load across differ=
ent
> p-states, because it's not always equivalent.
>=20
> For example suppose a load of 100% because of a tight for loop in the
> current p-state. It will be also a 100% load in any other p-state.
> It will be wrong if we scale the load in the calculation formula
> according to the current p-state.
>=20
> I included the test results in the change log to point out an improve=
ment
> because of this patch.
>=20
> I will enrich more the change log as you suggested.

Please do so.

Also, we need to take your patch to our power lab and see if we can rep=
roduce
your results in other workloads.

And I'm waiting for the intel_pstate developer Dirk Brandewie to commen=
t.

Thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
