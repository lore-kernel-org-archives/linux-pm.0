From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM) (a subset)
Date: Thu, 04 Oct 2018 11:01:10 +0200
Message-ID: <10136406.EY9A7BdqYq@aspire.rjw.lan>
References: <20181003143824.13059-1-ulf.hansson@linaro.org> <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com> <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, October 4, 2018 10:58:53 AM CEST Ulf Hansson wrote:
> On 4 October 2018 at 10:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, Oct 3, 2018 at 4:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>
> >> I have digested the review comments so far, including a recent offlist chat
> >> with with Lorenzo Pieralisi around the debatable PSCI changes. More or less I
> >> have a plan for how to move forward.
> >>
> >> However, to avoid re-posting non-changed patches over and over again, I decided
> >> to withhold the more debatable part from this v9, hence this is not the complete
> >> series to make things play. In v9, I have just included the trivial changes,
> >> which are either already acked/reviewed or hopefully can be rather soon/easily.
> >>
> >> My hope is to get this queued for v4.20, to move things forward. I know it's
> >> late, but there are more or less nothing new here since v8.
> >
> > I have no problems with the first three patches in this series, so I
> > can apply them right away.  Do you want me to do that?
> 
> Yes, please.
> 
> >
> > As for the rest, the cpuidle driver patch looks OK to me, but the
> > PSCI-related ones need ACKs.
> 
> For some yes, but I think you can go ahead with a few more.
> 
> Patch 4, 5 is already acked/reviewed.
> 
> Patch 6 should be fine (if you are okay with it else wait for an ack
> from Daniel)

OK, thanks.

Do the 4-6 depend on the 1-3?

> Patch 7 and 8 should be fine. They were suggested by Mark.

I'd rather have ACKs on these two as well.

> Patch 9 and 10 needs acks.
> 
> Patch 11 has been acked, but depends on the other PSCI changes.

OK
