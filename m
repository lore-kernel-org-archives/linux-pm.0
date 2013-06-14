From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v3 1/3] cpufreq: ondemand: Change the calculation of target frequency
Date: Fri, 14 Jun 2013 14:46:38 +0200
Message-ID: <1469773.K3KVgsTfzW@vostro.rjw.lan>
References: <q46r5iepl3sunqe5eemv66hk.1370694869222@email.android.com> <1645236.hTWQPUhyIx@vostro.rjw.lan> <20130613223740.GE32112@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130613223740.GE32112@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Borislav Petkov <bp@suse.de>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 14, 2013 12:37:41 AM Borislav Petkov wrote:
> On Fri, Jun 14, 2013 at 12:15:36AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, June 13, 2013 11:40:08 PM Borislav Petkov wrote:
>=20
> [ =E2=80=A6 ]
>=20
> > > Not bad. However, exec_test and fork_test are kinda unexpected wi=
th such
> > > a high improvement percentage. Happen to have an explanation?
> > >=20
> > > FWIW, if we don't find any serious perf/power regressions with
> > > this patch, I'd say it is worth applying even solely for the code
> > > simplification it brings.
> >=20
> > May I take this as an ACK? ;-)
> >=20
> > Well, that's my opinion too, actually.
>=20
> I know - you told me and I like that aspect :-). And from the test
> results so far, the code simplification is maybe the most persuasive
> one. The slight improvements in perf/power are then the cherry on top=
=2E
>=20
> Although, I'm not sure we're exhaustive with the benchmarks and we
> should maybe run a couple more. Although, judging by the results,
> generally no serious outliers should be expected (except exec_test an=
d
> fork_test funsies above), which are actually positive outliers.
>=20
> Judging by the code change, the only worry we should have, AFAIU, is
> any raise in power consumption due to spending longer periods in the
> intermediary P-states now and not going straight to the lowest P-stat=
e.
> But this compensates with improvement in runtime of the workloads.
>=20
> Hmm, I dunno - I'm just thinking out loud here...

OK, so here's a deal.  After 3.10-rc1 goes out, I'll put this into linu=
x-next
for 3.12, so that people have a few more weeks to complain.  If they do=
n't,
it'll go into 3.12.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
