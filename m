From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Date: Thu, 17 Jan 2019 17:44:10 +0000
Message-ID: <20190117174410.GA8839@e107155-lin>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20190103120612.GC23511@e107155-lin>
 <CAPDyKFp-JB85TZOs+oso0iidaAsm1A=UDrg=gv+QZ4VJ9gW=fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFp-JB85TZOs+oso0iidaAsm1A=UDrg=gv+QZ4VJ9gW=fA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 16, 2019 at 10:10:08AM +0100, Ulf Hansson wrote:
> On Thu, 3 Jan 2019 at 13:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Nov 29, 2018 at 06:46:33PM +0100, Ulf Hansson wrote:
> > > Over the years this series have been iterated and discussed at various Linux
> > > conferences and LKML. In this new v10, a quite significant amount of changes
> > > have been made to address comments from v8 and v9. A summary is available
> > > below, although let's start with a brand new clarification of the motivation
> > > behind this series.
> >
> > I would like to raise few points, not blockers as such but need to be
> > discussed and resolved before proceeding further.
> > 1. CPU Idle Retention states
> >         - How will be deal with flattening (which brings back the DT bindings,
> >           i.e. do we have all we need) ? Because today there are no users of
> >           this binding yet. I know we all agreed and added after LPC2017 but
> >           I am not convinced about flattening with only valid states.
>
> Not exactly sure I understand what you are concerned about here. When
> it comes to users of the new DT binding, I am converting two new
> platforms in this series to use of it.
>

Yes that's exactly my concern. So if someone updates DT(since it's part
of the kernel still), but don't update the firmware(for complexity reasons)
the end result on those platform is broken CPUIdle which is a regression/
feature break and that's what I am objecting here.

> Note, the flattened model is still a valid option to describe the CPU
> idle states after these changes. Especially when there are no last man
> standing activities to manage by Linux and no shared resource that
> need to prevent cluster idle states, when it's active.

Since OSI vs PC is discoverable, we shouldn't tie up with DT in anyway.

>
> >         - Will domain governor ensure not to enter deeper idles states based
> >           on its sub-domain states. E.g.: when CPUs are in retention, so
> >           called container/cluster domain can enter retention or below and not
> >           power off states.
>
> I have tried to point this out as a known limitation in genpd of the
> current series, possibly I have failed to communicate that clearly.
> Anyway, I fully agree that this needs to be addressed in a future
> step.
>

Sorry, I might have missed to read. The point is if we are sacrificing
few retention states with this new feature, I am sure PC would perform
better that OSI on platforms which has retention states. Another
reason for having comparison data or we should simply assume and state
clearly OSI may perform bad on such system until the support is added.

> Note that, this isn't a specific limitation to how idle states are
> selected for CPUs and CPU clusters by genpd, but is rather a
> limitation to any hierarchical PM domain topology managed by genpd
> that has multiple idle states.
>

Agreed, but with flattened mode we compile the list of valid states so
the limitation is automatically eliminated.

> Do note, I already started hacking on this and intend to post patches
> on top of this series, as these changes isn't needed for those two
> ARM64 platforms I have deployed support for.
>

Good to know.

> >         - Is the case of not calling cpu_pm_{enter,exit} handled now ?
>
> It is still called, so no changes in regards to that as apart of this series.
>

OK, so I assume for now we are not going to support retention states with OSI
for now ?

> When it comes to actually manage the "last man activities" as part of
> selecting an idle state of the cluster, that is going to be addressed
> on top as "optimizations".
>

OK

> In principle we should not need to call cpu_pm_enter|exit() in the
> idle path at all,

Not sure if we can do that. We need to notify things like PMU, FP, GIC
which have per cpu context too and not just "cluster" context.

> but rather only cpu_cluster_pm_enter|exit() when a cluster idle state is
> selected.

We need to avoid relying on concept of "cluster" and just think of power
domains and what's hanging on those domains. Sorry for naive question, but
does genpd have concept of notifiers. I do understand that it's more
bottom up approach where each entity in genpd saves the context and requests
to enter a particular state. But with CPU devices like GIC/VFP/PMU, it
needs to be more top down approach where CPU genpd has to enter a enter
so it notifies the devices attached to it to save it's context. Not ideal
but that's current solution. Because with the new DT bindings, platforms
can express if PMU/GIC is in per cpu domain or any pd in the hierarchy and
we ideally need to honor that. But that's optimisation, just mentioning.

> That should improve latency when
> selecting an idle state for a CPU. However, to reach that point
> additional changes are needed in various drivers, such as the gic
> driver for example.
>

Agreed.

> >
> > 2. Now that we have SDM845 which may soon have platform co-ordinated idle
> >    support in mainline, I *really* would like to see some power comparison
> >    numbers(i.e. PC without cluster idle states). This has been the main theme
> >    for most of the discussion on this topic for years and now we are close
> >    to have some platform, we need to try.
>
> I have quite recently been talking to Qcom folkz about this as well,
> but no commitments are made.
>

Indeed that's the worrying. IMO, this is requested since day#1 and not
even simple interest is shown, but that's another topic.

> Although I fully agree that some comparison would be great, it still
> doesn't matter much, as we anyway need to support PSCI OSI mode in
> Linux. Lorenzo have agreed to this as well.
>

OK, I am fine if others agree. Since we are sacrificing on few (retention)
states that might disappear with OSI, I am still very much still interested
as OSI might perform bad that PC especially in such cases.

> >
> > 3. Also, after adding such complexity, we really need a platform with an
> >    option to build and upgrade firmware easily. This will help to prevent
> >    this being not maintained for long without a platform to test, also
> >    avoid adding lots of quirks to deal with broken firmware so that newer
> >    platforms deal those issues in the firmware correctly.
>
> I don't see how this series change anything from what we already have
> today with the PSCI FW. No matter of OSI or PC mode is used, there are
> complexity involved.
>

I agree, but PC is already merged, mainitained and well tested regularly
as it's default mode that must be supported and TF-A supports/maintains
that. OSI is new and is on platform which may not have much commitments
and can be thrown away and any bugs we find in future many need to worked
around in kernel. That's what I meant as worrying.

> Although, of course I agree with you, that we should continue to try
> to convince ARM vendors about moving to the public version of ATF and
> avoid proprietary FW binaries as much as possible.
>

Indeed.

--
Regards,
Sudeep
