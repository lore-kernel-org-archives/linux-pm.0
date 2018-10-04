From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM) (a subset)
Date: Thu, 4 Oct 2018 19:07:27 +0200
Message-ID: <CAJZ5v0j+W2CHiqkniXNJgZ3DU9pOpd_83Wj9Egwf+pVkRCjZLg@mail.gmail.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
 <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
 <10136406.EY9A7BdqYq@aspire.rjw.lan> <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
 <20181004155755.GD5233@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004155755.GD5233@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 4, 2018 at 5:58 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Oct 04, 2018 at 11:32:41AM +0200, Rafael J. Wysocki wrote:
> > On Thu, Oct 4, 2018 at 11:04 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Thursday, October 4, 2018 10:58:53 AM CEST Ulf Hansson wrote:
> > > > On 4 October 2018 at 10:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > On Wed, Oct 3, 2018 at 4:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >>
> > > > >> I have digested the review comments so far, including a recent offlist chat
> > > > >> with with Lorenzo Pieralisi around the debatable PSCI changes. More or less I
> > > > >> have a plan for how to move forward.
> > > > >>
> > > > >> However, to avoid re-posting non-changed patches over and over again, I decided
> > > > >> to withhold the more debatable part from this v9, hence this is not the complete
> > > > >> series to make things play. In v9, I have just included the trivial changes,
> > > > >> which are either already acked/reviewed or hopefully can be rather soon/easily.
> > > > >>
> > > > >> My hope is to get this queued for v4.20, to move things forward. I know it's
> > > > >> late, but there are more or less nothing new here since v8.
> > > > >
> > > > > I have no problems with the first three patches in this series, so I
> > > > > can apply them right away.  Do you want me to do that?
> > > >
> > > > Yes, please.
> > > >
> > > > >
> > > > > As for the rest, the cpuidle driver patch looks OK to me, but the
> > > > > PSCI-related ones need ACKs.
> > > >
> > > > For some yes, but I think you can go ahead with a few more.
> > > >
> > > > Patch 4, 5 is already acked/reviewed.
> > > >
> > > > Patch 6 should be fine (if you are okay with it else wait for an ack
> > > > from Daniel)
> > >
> > > OK, thanks.
> > >
> > > Do the 4-6 depend on the 1-3?
> >
> > I don't see any dependency there, so I'll queue up the 1-3 in
> > pm-domains and the 4-6 in pm-cpuidle.
>
> I do not see why we should merge patches 4-6 for v4.20; they add legacy
> (DT bindings and related parsing code) with no user in the kernel; we
> may still want to tweak them, in particular PSCI DT bindings.

My impression was that 4-6 have been agreed on due to the ACKs they
carry.  I'll drop them if that's not the case.

> Likewise, it makes no sense to merge patches 7-8 without the rest of
> the PSCI patches.

OK

I'll let the ARM camp sort out the PSCI material then.

Thanks,
Rafael
