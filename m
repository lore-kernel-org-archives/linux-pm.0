From: Jon Loeliger <jdl@freescale.com>
Subject: Re: cpufreq user<->kernel interface removal [was
	Re:	community PM requirements/issues and PowerOP]
Date: Tue, 12 Sep 2006 12:03:01 -0500
Message-ID: <1158080580.27129.205.camel@cashmere.sps.mot.com>
References: <20060911210026.GG11901@elf.ucw.cz>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01B1D623@de01exm64.ds.mot.com>
	<20060911213930.GJ11901@elf.ucw.cz> <4505E62F.1000203@gmail.com>
	<20060911230529.GC13474@elf.ucw.cz>
	<20060911235025.GA14234@linux.intel.com>
	<20060912033537.GC27397@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060912033537.GC27397@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: lkml@elf.ucw.cz.kroah.org, Preece Scott-PREECE <scott.preece@motorola.com>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2006-09-11 at 22:35, Greg KH wrote:
> On Mon, Sep 11, 2006 at 04:50:25PM -0700, Mark Gross wrote:
> > The PowerOP patch has nothing to do with the removal of cpufreq.  You
> > may be confusing this work with the david signleton patch.
> =

> I am totally confused about who is working on what, and what provides
> what.

Me too.

> Can someone make  quick cheat-sheet that shows the different
> developers/companies and projects here?  The fact that it's impossible
> to keep this straight in the first place does not bode well...

And while we are summarizing, can we review the strategy
for the large-scale improvements we are contemplating here?
And then maybe even offer a list of ordered steps?

Like, do we all agree/disagree that we should do any/all
of these?

    - Generalize the cpufreq codebase
    - Generalize the cpufreq code with generalized concept
      of Operating Point
    - Unify handling of reduced operating states with
      actual sleep/off states
    - Unify the PowerOP code with the Op Point code
    - Unify the PowerOP, OpPoint, cpufreq and ACPI code
    - Dispense with PM unification entirely and let specific
      implementations emerge for now
    - Rewrite the lowest level of operating point handling
    - Implement a user<->kernel interface for Power Management
    - Allow only kernel control of PM
    - Allow user-level control of PM
    - Allow both/either User and Kernel code to decide on
      PM state transitions
    - Provide distinct code bases at the lowest level for
      handling different components of an operating point
      and recognize cpufreq as one part of that, with other
      parts needing to be written first, before a generalized
      operating point handler can be written at the next layer

I think there has been some focus lost in this discussion,
and I'd like to see a clear delineation of some requirements
and direction just to make sure it is all headed in a common,
right direction.

Thanks,
jdl
