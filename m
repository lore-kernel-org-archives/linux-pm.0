From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 03/14] PM: Introduce an Energy Model management
 framework
Date: Fri, 10 Aug 2018 13:30:35 +0100
Message-ID: <20180810123032.ixay2e3hlrayifdy@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <2467271.WAtZ4Z8dKT@aspire.rjw.lan>
 <20180810091216.nieosjtu7l33z4ap@queper01-lin>
 <8482157.ZqyaK8WryI@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8482157.ZqyaK8WryI@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 10 Aug 2018 at 13:13:22 (+0200), Rafael J. Wysocki wrote:
> Something able to say how the numbers used by EM and IPA are related. :-)
> 
> Do you think that IPA and EM will always need to use the same set of data for
> the CPU?

Hmm, I would say yes. Both EAS and IPA basically need some sort of
<frequency, power> table, so hopefully the EM framework can provide them
with that :-).

If the EM framework doesn't accommodate the needs of its two users, then
something needs fixing ... Did you have something specific in mind ?

Thanks,
Quentin
