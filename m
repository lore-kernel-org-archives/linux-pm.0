From: Remy Bruno <remy-fw@remy.trinnov.com>
Subject: Re: Isochronous streaming with VT6315 OHCI
Date: Thu, 17 Jul 2014 18:52:08 +0200
Message-ID: <20140717165208.GA13765@trinnov.com>
References: <20140123154321.GA1557@trinnov.com>
 <20140123233205.628240b5@stein>
 <20140127100932.GB1557@trinnov.com>
 <20140615011758.2817384f@kant>
 <20140715185351.GA28484@trinnov.com>
 <53C66BFC.4010500@ladisch.de>
 <20140716135959.GA11877@trinnov.com>
 <20140716182849.GA17892@trinnov.com>
 <53C7CCCA.4030602@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:40369 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751348AbaGQSrF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jul 2014 14:47:05 -0400
Received: from mail406.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 2B3C9FF872A
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2014 18:52:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53C7CCCA.4030602@hurleysoftware.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Remy Bruno <remy-fw@remy.trinnov.com>, linux1394-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Hi,

Here is a summary/update of the problem and solutions I found.

This occurs with the following:
- linux 3.11.10
- firewire OHCI VIA VT6315
- motherboard DH61DL
- CPU Intel(R) Core(TM) i3-3220T CPU @ 2.80GHz (2 hyperthreaded cores,
  thus 4 virtual cores)


* The problem *

The firewire OHCI skips some cycles (say about one each 5-10ms) when
streaming to 2 DICEs 16 channels at 96kHz each. No cycle skips occur
with only one stream.  I checked that it is not due to some kind of
software underrun. The OHCI simply fails to transmit one cycle
(sometimes two in a row) for some unknown reason (no xferstatus, skip
address taken by the OHCI, streaming continues afterwards).

* The solution *

I found out that the issue disappears completely (no cycle skips within=
 more
than 12 hours) as soon as one core (out of the 4 virtual ones) is
forbidden to go to C3 or higher idle state. No matter which core it is,=
 as
long as only C1/C1E idle states are allowed on one of the cores (there
is no C2 state on this CPU), I don't get any cycle skips at all.

This can be done for example by having a process doing a busy loop on
one core: "while (1);". This can also be done by disabling cpuidle in
the kernel (acpi and intel). This can also be done by writing "1" to th=
e
relevant /sys/devices/system/cpu/cpuX/cpuidle/stateY/disable files.

The reason for this is completely obscure to me. Just for trying, I
added CPUIDLE_FLAG_TLB_FLUSHED to the C1E state, but it didn't cause
skips when this state was allowed (so the problem is not due to the TLB
flush that occurs when switching to C3+ states). So, for some reason,
the OHCI (DMA?) sometimes fails to read or write from/to memory when al=
l
cores are in C3+ state at the same time. Note that it is far from
systematic: all cores being in C3+ state does not imply that a skip wil=
l
occur.


=46YI, I'm still having cycle skips with a PCIe TI XIO2200A firewire OH=
CI card.
The fix above reduces the amount of skips but does not remove them with
this firewire card.


Best regards,

R=C3=A9my

PS: Please note for further discussion that I'm not registered to
mailing-list linux-pm@vger.kernel.org



Le jeudi 17 juillet =C3=A0 09:16, Peter Hurley a =C3=A9crit:
> [ +cc intel_idle maintainers ]
>=20
> On 07/16/2014 02:28 PM, Remy Bruno wrote:
> > A follow-up and solution!
> >
> > By digging more, I found out that a sleep of 100us in a loop, inste=
ad of
> > a busy loop, is enough to make both streamings work without drops. =
So I
> > looked closer after what the cpu is doing while being idle and foun=
d the
> > intel_idle driver. My CPU is using states C1-IVB to C7-IVB.
> > By removing the states C3-IVB to C7-IVB from the driver's list, the
> > drops disappear!
> >
> > So the explanation that comes to me is that: if all CPU cores are a=
t the
> > same time in one of the states C3-IVB to C7-IVB, then I can get dro=
ps.
> > If I force one or all cores to be in a normal running state or in t=
he
> > states C1/C1E, then the ohci drops disappear.
> >
> > I'm not familiar at all with these CPU Cn states, but I will maybe =
look
> > deeper into this. At least, I now have a clean solution.
> >
> > I noticed that the incriminated states are those with
> > CPUIDLE_FLAG_TLB_FLUSHED, maybe it is related to my problem, I will=
 try
> > more things tomorrow.
> >
> > I would be interested if anyone can comment on this. Also if this i=
s not
> > a problem to remove states C3-C7 in my kernel (and of course if you
> > think this can be interesting to propose a kernel patch when the pr=
ecise
> > reason will be identified)
> >
> > Regards,
> >
> > R=C3=A9my
> >
> > Le mercredi 16 juillet =C3=A0 15:59, Remy Bruno a =C3=A9crit:
> >> First, I noticed that the last quirk settings for this VIA VT6315 =
makes
> >> the whole firewire stack hang completely very quickly, the same wa=
y it
> >> did before my re-writing of the AVS/ISO user stack (ie when using =
data
> >> payloads of more than 1k), so most probably disparition of interru=
pts.
> >> So I'm not sure if the last quirks changes were such a good idea..=
=2E For
> >> now, I reverted to "QUIRK_CYCLE_TIMER | QUIRK_NO_MSI" settings, as=
 it
> >> works less badly this way...
> >>
> >> Some more information about the issue I reported:
> >> - this double streaming 16 channels 96kHz works fine with an old k=
ernel
> >>    (ie old firewire stack)
> >> - I noticed more or less the same behaviour with a TI XIO2200A OHC=
I.
> >>    "more or less" because the 100% CPU load trick does not fix the
> >>    problem so magically (event though it reduces the number of dro=
ps)
> >> - for debuging purpose, I changed the skip-to-self behaviour to a
> >>    skip-to-next behaviour (ie I changed the skip address of each c=
ontext
> >>    descriptor block from the block itself to the next block) so th=
at I
> >>    expected to get a xferstatus for the non-transmitted packet. I =
could
> >>    get the memory dump corresponding to this skip:
> >>
> >> 34775280  02000008 00000000 347752D3 00000000   .........Rw4....
> >> 34775290  000244A0 04080000 00000000 00000000   .D..............
> >> 347752A0  00000008 347752C0 00000000 00000000   .....Rw4........
> >> 347752B0  180C0400 3478B400 347752D3 841103B7   ......x4.Rw4....
> >> 347752C0  20001002 D1A20490 00000000 00000000   ... ............
> >>
> >> 347752D0  02000008 00000000 34775314 00000000   .........Sw4....
> >> 347752E0  000244A0 00080000 00000000 00000000   .D..............
> >> 347752F0  180C0008 34775300 34775314 841103B8   .....Sw4.Sw4....  =
 <- cycle 0x03B8
> >> 34775300  30001002 FFFF0490 00000000 00000000   ...0............
> >>
> >> 34775310  02000008 00000000 34775364 00000000   ........dSw4....
> >> 34775320  000244A0 04080000 00000000 00000000   .D..............
> >> 34775330  00000008 34775350 00000000 00000000   ....PSw4........
> >> 34775340  180C0400 3478B800 34775364 00000000   ......x4dSw4....  =
 <- Nothing written by OHCI!!
> >> 34775350  30001002 D1B60490 00000000 00000000   ...0............
> >>
> >> 34775360  02000008 00000000 347753B4 00000000   .........Sw4....
> >> 34775370  000244A0 04080000 00000000 00000000   .D..............
> >> 34775380  00000008 347753A0 00000000 00000000   .....Sw4........
> >> 34775390  180C0400 3478BC00 347753B4 841103BA   ......x4.Sw4....  =
 <- cycle 0x03BA
> >> 347753A0  40001002 D1CA0490 00000000 00000000   ...@............
> >>
> >> The skipped packet begins here at address 34775310 and we can see =
that
> >> the status was written by the OHCI for packets before and after
> >> (corresponding to cycles 0x03B8 and 0x03BA), but the OHCI didn't w=
rite
> >> anything for cycle 0x03B9.
> >>
> >>
> >> Le mercredi 16 juillet =C3=A0 14:11, Clemens Ladisch a =C3=A9crit:
> >>>> - the drops occur more or less in the middle of an IRQ period (t=
ypically
> >>>>    on the 10th or 13th cycle of a period when I use IRQ periods =
of 20),
> >>>>    so this does not seem to be a kind of kernel-going-past-the
> >>>>    -last-packet problem.
> >>>
> >>> How many periods are you using?
> >>
> >> I'm using 4 periods of 20 cycles
> >>
> >>> What happens with a period length of, say, 200 frames?
> >>
> >> The same thing, drops occur quickly
> >>
> >>>> - cherry on the cake: the drops stop completely if one of the CP=
U cores
> >>>>    (I'm using an Intel i3-3220T with 2 hyperthreaded cores) is 1=
00%
> >>>>    loaded!
> >>>
> >>> Strange.  I have seen large differences in asynchronous throughpu=
t (due
> >>> to smaller interrupt wakeup latencies), but isochronous transfers=
 should
> >>> not be affected by CPU latencies as long as the queue does not un=
derrun.
> >>
> >> Yes, I checked this is not an underrun. See above: the OHCI contin=
ued to
> >> stream, it just skipped a cycle
> >>
> >>> The only difference I see is that a CPU going to sleep will flush=
 its
> >>> caches, but this should reduce the latencies when the controller =
is
> >>> reading that data from RAM, so the effect should be the exact opp=
osite.
> >>
> >> Interresting.
> >> But I'm not an expert (at all) about CPU caches and all the like..=
=2E I
> >> was even not able to find the code that the CPU executes in the ke=
rnel
> >> when sleeping (even though I grepped the kernel with "idle" and "h=
lt"),
> >> aka the "swapper" process if I'm right.
> >>
> >> I will continue investigations...
> >>
> >> Regards,
> >> R=C3=A9my
> >>
> >> --
> >> R=C3=A9my BRUNO
> >> Trinnov Audio
> >> remy.bruno@trinnov.com / http://www.trinnov.com
> >> 5 rue Edmond Michelet, 93360 Neuilly-Plaisance,  France
> >> Tel: +33 (0)1 47 06 61 37
> >> Mob: +33 (0)6 83 04 01 31
> >>
> >> ------------------------------------------------------------------=
------------
> >> Want fast and easy access to all the code in your enterprise? Inde=
x and
> >> search up to 200,000 lines of code with a free copy of Black Duck
> >> Code Sight - the same software that powers the world's largest cod=
e
> >> search on Ohloh, the Black Duck Open Hub! Try it now.
> >> http://p.sf.net/sfu/bds
> >> _______________________________________________
> >> mailing list linux1394-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux1394-devel
> >
>=20

--=20
R=C3=A9my BRUNO
Trinnov Audio
remy.bruno@trinnov.com / http://www.trinnov.com
5 rue Edmond Michelet, 93360 Neuilly-Plaisance,  France
Tel: +33 (0)1 47 06 61 37
Mob: +33 (0)6 83 04 01 31
