From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH RESEND] tools: add power/x86/turbostat - v2
Date: Wed, 17 Nov 2010 01:44:52 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011170126280.24426__4012.03290462053$1289976392$gmane$org@x980>
References: <alpine.LFD.2.00.1010230116590.29399@localhost.localdomain>
	<alpine.LFD.2.00.1010240004180.23060@localhost.localdomain>
	<alpine.LFD.2.00.1010262312090.3209@localhost.localdomain>
	<alpine.LFD.2.00.1011151056380.2939@x980>
	<20101116102916.GA4305@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20101116102916.GA4305@alberich.amd.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc: linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Nov 2010, Andreas Herrmann wrote:

> On Mon, Nov 15, 2010 at 11:01:05AM -0500, Len Brown wrote:
> > From: Len Brown <len.brown@intel.com>
> > 
> > turbostat displays actual processor frequency on modern
> > Intel processors.  Note that this capability depends on free-running
> > APERF and MPERF MSRs, which were cleared by the acpi_cpufreq
> > driver up through Linux-2.6.29.
> 
> Why isn't cpufreq-aperf sufficient for showing the actual frequency?
> The tool can handle both AMD and Intel CPUs.

Looking over its source code, I don't see any reason that cpufreq-aperf
wouldn't be sufficient for showing actual frequency, were that your goal.
I hadn't heard of this tool until your note.  I complied it, but I guess
I'm too lazy to figure out why it didnt' run.
It seems somewhat elaborate as compared to the task at hand...

> There is a CPUID flag which can be checked for APERF/MPERF existence,
> no need to enforce a general vendor check like this:
> 
>   $ ./turbostat
>   CPUID: AuthenticAMD != GenuineIntel

turbostat isn't very interesting on systems that don't
have a reliable TSC or C-state residency MSRs.  AFAIK,
AMD has neither.  If you have information to the contrary
and can test it on AMD hardware, I'd be happy to enable AMD,
as I have neither.

> > On Intel Core i3/i5/i7 (Nehalem) and newer processors,
> > turbostat displays residency in idle power saving states.
> 
> Can't this be added to cpuidle-info (see branch cpupowerutils in
> git://git.kernel.org/pub/scm/utils/kernel/cpufreq/cpufrequtils.git)?

I suppose it could if somebody were in need of a hobby.
However, if you want a big tool in this space,
you'd probably be better off running powertop2,
which will incorporate what turbostat does, and more.

> BTW, gcc v4.4 throws several warnings when compiling your
> code:

thanks, I'll fix these.

cheers,
Len Brown, Intel Open Source Technology Center
