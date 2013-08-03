From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 08/10] cpufreq: Fix broken usage of governor->owner's refcount
Date: Sun, 04 Aug 2013 00:06:40 +0200
Message-ID: <2637835.0QndCQ8FcY@vostro.rjw.lan>
References: <cover.1375530162.git.viresh.kumar@linaro.org> <4846602.3FgvAM66Ta@vostro.rjw.lan> <CAKohpokdWMjeZ=GKt4SaJDaA4Dn-WODpE_Mn+VEBpxB=VNAuyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokdWMjeZ=GKt4SaJDaA4Dn-WODpE_Mn+VEBpxB=VNAuyw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, l.majewski@samsung.com
List-Id: linux-pm@vger.kernel.org

On Saturday, August 03, 2013 06:57:11 PM Viresh Kumar wrote:
> On 3 August 2013 17:38, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday, August 03, 2013 05:19:26 PM Viresh Kumar wrote:
> >> Governor's owner refcount usage was broken. We should increment refcount only
> >> when CPUFREQ_GOV_POLICY_INIT event has come and should decrement only if
> >> CPUFREQ_GOV_POLICY_EXIT has come.
> >>
> >> Lets fix it.
> >
> > OK, and what happens if we don't fix it?
> 
> What about this changelog:
> 
> Subject: [PATCH 08/10] cpufreq: Fix broken usage of governor->owner's
>  refcount
> 
> Governor's owner refcount usage was broken. We should increment refcount only
> when CPUFREQ_GOV_POLICY_INIT event has come and should decrement only if
> CPUFREQ_GOV_POLICY_EXIT has come.
> 
> Currently there can be situations where governor is in use but we have allowed
> it to be unloaded. And that may cause in undefined behavior.

"it to be unloaded which may result in undefined behavior."

> 
> Lets fix it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Apart from the above looks good.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
