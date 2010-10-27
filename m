From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] tools: add x86_energy_perf_policy to
	program	MSR_IA32_ENERGY_PERF_BIAS
Date: Wed, 27 Oct 2010 09:43:11 -0200
Message-ID: <20101027114310.GO3826__42272.4980199293$1288192907$gmane$org@ghostprotocols.net>
References: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
	<alpine.LFD.2.00.1009281143070.14962@localhost.localdomain>
	<alpine.LFD.2.00.1010230035360.29399@localhost.localdomain>
	<20101026202307.c028e26c.akpm@linux-foundation.org>
	<20101027060139.GB5603@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20101027060139.GB5603@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Em Wed, Oct 27, 2010 at 08:01:39AM +0200, Ingo Molnar escreveu:
> 
> * Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Sat, 23 Oct 2010 00:40:18 -0400 (EDT) Len Brown <lenb@kernel.org> wrote:
> > tools/power/x86, eh?  It seems a better place than under
> > Documentation/, where such things have thus far landed!

> > I looked briefly, wondering about the kbuild situation.  It doesn't
> > appear to be wired up, so one has to manually enter that directory
> > and type `make'?

> > I guess that's OK as an interim thing but longer-term I suppose we
> > should have some more complete build and deployment system.  So
> > (thinking out loud) a `make' would invoke a `make tools', and that
> > `make tools' would build the tools which are specific to the target
> > arch[*], and any generic ones.  And a `make tools_install' would
> > install those tools in, I guess, /lib/modules/$(uname -r)/bin.
 
> In terms of build and documentation environment, tools/perf/ has one
> cloned/inherited from Git, which is rather good and functional.
 
> Sharing it with the kernel's build system depends on the kbuild
> developers being interested in it.

Yes, that is how it is today, I glued it to the main makefile in at
least one case:

[acme@doppio linux]$ make help | grep perf
  perf-tar-src-pkg    - Build perf-2.6.36-rc7.tar source tarball
  perf-targz-src-pkg  - Build perf-2.6.36-rc7.tar.gz source tarball
  perf-tarbz2-src-pkg - Build perf-2.6.36-rc7.tar.bz2 source tarball
[acme@doppio linux]$

I'd love to glue it some more, even using Kconfig and 'make toolsconfig'
for configuring the tools:

	. Want the TUI?
        . Want to link with DWARF? Needed for features x, y and z

Getting it done this way will provide examples that hopefully would lead
to more kernel coding practices and infrastructure being adopted by
(hell is freezing) userland programmers.

This is specially important now that there are more kernel programmers
writing userland code, lets hope that at least them continue to use
those practices and infrastructures ;-)

- Arnaldo
