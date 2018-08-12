From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 03/14] PM: Introduce an Energy Model management framework
Date: Sun, 12 Aug 2018 11:49:40 +0200
Message-ID: <CAJZ5v0iODf2nUhMuyp6MXpLVdF3etDmyXz9OVRuQJ5B5Z=t2OA@mail.gmail.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <2467271.WAtZ4Z8dKT@aspire.rjw.lan> <20180810091216.nieosjtu7l33z4ap@queper01-lin>
 <8482157.ZqyaK8WryI@aspire.rjw.lan> <20180810123032.ixay2e3hlrayifdy@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810123032.ixay2e3hlrayifdy@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adharmap@quicinc.com, skannan@quicinc.com, Pava
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 10, 2018 at 2:30 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Friday 10 Aug 2018 at 13:13:22 (+0200), Rafael J. Wysocki wrote:
> > Something able to say how the numbers used by EM and IPA are related. :-)
> >
> > Do you think that IPA and EM will always need to use the same set of data for
> > the CPU?
>
> Hmm, I would say yes. Both EAS and IPA basically need some sort of
> <frequency, power> table, so hopefully the EM framework can provide them
> with that :-).
>
> If the EM framework doesn't accommodate the needs of its two users, then
> something needs fixing ... Did you have something specific in mind ?

Not really. :-)
