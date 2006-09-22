From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Fri, 22 Sep 2006 17:48:55 +0300
Message-ID: <1158936535.26687.20.camel@Dogbert.NOE.nokia.com>
References: <200609192137.k8JLb4NX029061@olwen.urbana.css.mot.com>
	 <20060922141127.GM3478@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932554AbWIVOtv@vger.kernel.org>
In-Reply-To: <20060922141127.GM3478@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Pavel Machek <pavel@ucw.cz>
Cc: "Scott E. Preece" <preece@motorola.com>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2006-09-22 at 16:11 +0200, ext Pavel Machek wrote:
> Hi!
> 
> > Hmm. If you assume the CPUs in an SMP system can be in different
> > operating points, this would (as Pavel pointed out) result in an
> > explosion of operating points.
> 
> Problem is not only CPUs, devices are mostly independent in PC
> case... it would be nice to solve that problem with same approach.
> 
> 								Pavel

This whole discussion is, imho, very misleading.

The number of CPU in a box or the number of cores in a chip is not a
significant element, per se.

What is really important is how interdependent they are.
In the case of a board with 2, 4 or 8 CPU, the decisione if their states
are tied together or not is not based on the packaging, but rather on
the (possibly suboptimal) HW design: shared clock or power sources
impose constraints and correlations.

Correlations lead to the multiplication of subsystem states, while
constraints curb the number, because if CPU1 and CPU2 share the same
voltage source, then of all the possible states, only those where this
constraint is satisfied are possible.

Remember what an OP is:
a set of values that exaustively and uniquely define the state of a
system.

So if your box has 256 CPUs, I bet that they are not all on the same
board and probably you also have several independently programmable
power sources.
If every power source feeds say 8 CPUs, then the box contains 16
independent subsystems.

Of course one probably would like to orchestrate all of them, but that's
a 2nd level problem, that could be addressed by a power/workload
manager.

However, even starting with localised dynamic power management would
yeld a significant improvement.

About other device within a PC: SW design cannot really change whatever
constraints the HW design is imposing: if 2 devices are sharing a
programmable v/f source, the source is generating a system which
comprises both devices and it has to be addressed as such.

The innterdipendency could be masked at some high abstract level, but
then going down, close to HW, it has to be explicitly dealt with.

-- 
Cheers,
           Igor

Igor Stoppa (Nokia M - OSSO / Tampere)
