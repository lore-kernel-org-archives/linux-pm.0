From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Wed, 4 Oct 2006 23:30:14 -0400
Message-ID: <20061005033014.GC18228@dominikbrodowski.de>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
	<20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	<20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <4505DDA6.8080603@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: Preece Scott-PREECE <scott.preece@motorola.com>, pm list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

Just to set the record straight:

On Tue, Sep 12, 2006 at 02:05:26AM +0400, Eugeny S. Mints wrote:
> Cpuferq defines cpufreq_frequency_table structure in arch independent hea=
der =

> while it's arch dependent data structure.

cpufreq_frequency_table is an _optional_ library architectures _may_ use if
they consider it useful to them. It's useful for most of them, but it is not
required at the core level. For a reason.

> A lot of code is built around this =

> invalid basic brick and therefore is invalid: cpufreq tables, interface w=
ith cpu =

> freq drivers, etc.

cpufreq tables? what do you mean with that?

And the interface with cpufreq drivers does not rely on
cpufreq_frequency_table. That's one of the fun things in cpufreq. You don't
need to define a pre-defined table for the >10^5 states at least one cpufreq
driver offers.

> Notion of transition latency as it defined by cpufreq is =

> wrong because it's not a function of cpu type but function of current and=
 next =

> operating point.

That may be, but it may serve as the "maximum latency" at the moment; if
needed, it could be expanded, e.g. using or on top of the interfaces
described in http://lwn.net/Articles/197299/ .

> no runtime control on operating points set. it's always the =

> same set of operating points for all system cpus in smp case and no way t=
o =

> define different sets or track any dependencies in case say multi core cp=
us. =


You can define different min, current, and max frequencies (for this is all
the cpufreq core cares about) for multiple cores. How the freq_table
interactions work then, I cannot say without checking the source -- but as
it is only an _optional_ library an arch can use, that doesn't count.

> insufficient kernel<->user space interface to handle embedded requirement=
s and =

> no way to extend it within current design.

Nobody tried to do so yet, to my knowledge.

> PowerOP/cufreq integration patch set contains very details explanation of=
 the =

> cpufreq design issues and POwerOP solutions. Comment there is you feel it=
's wrong.

I'll gladly do so soon, and I'll also comment further on the PowerOP patche=
s -- but
not today, sorry.


Thanks,
	Dominik
