From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Extending OPP bindings
Date: Fri, 31 Jan 2014 18:09:30 +0000
Message-ID: <20140131180929.GH2616@e102568-lin.cambridge.arm.com>
References: <52EA570A.8040501@arm.com>
 <52EAF1CA.3040702@ti.com>
 <20140131124620.GC2616@e102568-lin.cambridge.arm.com>
 <CAL_Jsq+Kq9C39xr9tY8gSX+6QFkNDqwmTyC+dBhLNcxKMweCpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41901 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462AbaAaSJh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2014 13:09:37 -0500
In-Reply-To: <CAL_Jsq+Kq9C39xr9tY8gSX+6QFkNDqwmTyC+dBhLNcxKMweCpw@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Shawn Guo <shawn.guo@linaro.org>, "mturquette@linaro.org" <mturquette@linaro.org>, Mark Brown <mark.brown@linaro.org>, Eduardo Valentin <eduardo.valentin@ti.com>

Hi Rob,

thanks for having a look.

On Fri, Jan 31, 2014 at 05:17:51PM +0000, Rob Herring wrote:
> On Fri, Jan 31, 2014 at 6:46 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > Hi Nishanth,
> >
> > On Fri, Jan 31, 2014 at 12:43:54AM +0000, Nishanth Menon wrote:
> >> Hi Sudeep,
> >>
> >> On 01/30/2014 07:43 AM, Sudeep Holla wrote:
> >>
> >> >
> >> > I am looking into a couple shortcomings in the current OPP bindings and
> >> > how to address them. Feel free to add to the list if you think of any more
> >> > issues that needs to be addressed or if and how any problem mentioned below
> >> > can be handled with the existing bindings.
> >> >
> >> > 1. indexing: currently there are no indices in the operating-points.
> >> indexing is based on frequency which is why the accessors use
> >> frequency to pull out the OPP data.
> >>
> >> indexing is a horrible idea - on platforms where OPP may be disabled
> >> or enabled for various reasons(see arch/arm/mach-imx/mach-imx6q.c,
> >> arch/arm/mach-omap2/board-omap3beagle.c etc) - the indexing you see in
> >> dts is just a myth that may not exist once the nodes are loaded and
> >> operated upon depending on SoC variations (example efuse describing
> >> which OPPs can be used and which not).
> >
> > I do not understand why. As long as a mapping from DT to data structures
> > in the kernel is done at boot, I can see how by indexing device nodes
> > can refer to specific OPPs. If they are disabled, amen, as long as we
> > can point at specific operating points that should be ok.
> >
> > Indexing does not mean that the index in the DT is the same as the one
> > allocated by the OS. Indexing is there to point at specific OPPs from
> > different DT nodes, a good example are clock bindings and that's exactly
> > how they work.
> 
> That is not a good comparison. With clocks, you are describing which
> physical signal coming out of a hardware block much like interrupts.
> Granted the h/w is not typically documented that way for clocks
> although the numbering could correspond to register bit locations as
> interrupt numbers do. With OPP indexes, they are a totally made up
> software construct.

Well ok, it might be, what I know is that current OPPs do not allow
other nodes to reference their properties properly, I am not sure that adding
an index make things worse, actually they are already broken as they are.

> Perhaps OPPs should be nodes so new fields can be added easily and
> then you have a phandle for each OPP.

Yeah, but the end result is the same, it has more to do with how to
express dependencies with DT than the question on whether to use a phandle
or an index. If we have to add phandles so be it, it is still just a way
to reference properties for me.

> > Can you provide me with an example where the indexing would go wrong
> > please ?
> 
> Putting s/w indexes into DT. Using cell-index for uarts to define
> their tty number was one example.

The idea was not related to using that index in the kernel at all, but
since you are all against using this mechanism, I think that's for a good
reason so we will not do that. How to do it, it has to be seen though.

> > Certainly relying on implicit ordering is not great either, actually I
> > would say that it is broken.
> >
> >> That said, the original OPP[1][2] series discussion started by trying
> >> to kill indexing precisely for the same reason.. once you have it - it
> >> becomes just crazy to deal with.
> >
> > I could not find any "index killing" :) discussion in there, but I will
> > keep reading.
> >
> >> >     It's assumed that the list is either in ascending or descending
> >> >     order of frequency but not explicit in the binding document.
> >> >     There are arch/arm/boot/dts/* files with opps in both styles.
> >> it should not matter -> opp library should do an insertion sort and
> >> organize it in ascending order once all the data is inserted. (line
> >> 449ish in opp.c)
> >
> > That's OS details and they must not be mandated by the bindings.
> > We cannot rely on word of mouth for things to work, I do not like
> > implicit rules, so the bindings should speficy the ordering or better
> > a way to reference OPPs.
> >
> >> if you see issues with the insertion sort not functioning, it is a bug
> >> and should be easy to track down and fix.
> >
> > Problem is not the insertion sort, problem is that DT bindings do not
> > define a way to refer to a specific OPP, unless we do that implicitly
> > and again, I rest my case, that is broken.
> >
> >> >     Few other bindings like thermal defines bindings like
> >> >     cooling-{min,max}-state assuming some order which is broken IMO.
> >> Now that you bring it up, I missed it :(.. yeah, I might have
> >> preferred it to be min frequency and max_frequency - I agree it is
> >> probably broken. I'd let Eduardo comment more about it.
> >>
> >> >
> >> >     One such use-case that came up recently[0] is the c-state latencies
> >> >     which could be different for each OPP. It would be good if the
> >> >     latencies are specified with the indices to OPP table to avoid
> >> >     inconsistency between the bindings.
> >>
> >> You can define C states based on frequencies as well - which really
> >> makes sense - since that sounds really like our constraint (say
> >> valid-at-frequency "xyz"
> >
> > I do not think that's generic enough, I do not like the idea of looking
> > up frequencies (eg a C-state target_residency does not depend on the
> > frequency only - ie voltage and other factors play a role, it really
> > depends on an operating point- looking it up by frequency is misleading IMO).
> 
> It seems we are trying to fit a square peg into a round hole here.

Do you mean that this is something not worth describing ? That it has to
be described differently ? Or that current DT semantics is not suitable for
describing it ?

We have to find a solution and we are keen on reworking it, otherwise we just
pretend there are no dependencies on the OPPs from other DT nodes, but I
am afraid that's already the case now.

Thank you,
Lorenzo

