From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq
	PowerOPintegration, Intro 0/3]
Date: Wed, 25 Oct 2006 23:08:24 -0400
Message-ID: <20061026030824.GC18549@dominikbrodowski.de>
References: <EA12F909C0431D458B9D18A176BEE4A50800FCF4@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A50800FCF4@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sun, Oct 08, 2006 at 09:28:15AM -0500, Woodruff, Richard wrote:
> > D) Verification
> > =

> > So, how to do this verification? Basically, there are two approaches:
> > =

> > 1) ask every other subsystem whether the new value is OK with it.
> > 	This is what cpufreq currently suggests to do. It is evident
> > 	that this gets overly complicated with lots of dependencies
> > 	and dependencies within the dependencies -- both in terms
> > 	of concept and in terms of time the verification code takes
> > 	to execute.
> > 	Advantages:
> > 	- easy to expand, also in runtime (e.g. USB system is
> > 		modprobed and telling you of a new minimum voltage
> > 		requirement on certain circumstances)
> > 	- does not limit choices for each knob
> > 	Disadvantages:
> > 	- might get very complex
> > =

> > 2) look up all valid states in a table
> > 	This is basically what PowerOP and the "operating points"
> > 	concept suggests: if you want to change one value, you check
> > 	what operating points a) contain the new value and b) is
> > 	most suitable to you.
> > 	Advantages:
> > 	- fast
> > 	- pre-defined set of operating points which the system
> > 	  designer is comfortable with
> > 	Disadvantages:
> > 	- needs to be limited to "core" of the system as else
> > 	  the tables may get overly large
> > 	- limits the choices
> =

> That is a pretty good summary.
> =

> Depending on your operating point definition you don't always have to
> limit yourself here.  An operating point parameter need not directly be
> associated with the physical value of the domain it represents.  Meaning
> you don't need to put 1.05 volts in for the parameter, you can define it
> as some other value which needs translating/defining by the core.

First, thanks for your insightful comments. Second, well, we can of course
use some discrete values instead of "real" values -- however, if we get the
chance, I think it's nicer to put the "real" values there. Unless we need
floating point ;)

Thanks,
	Dominik
