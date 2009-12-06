From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 09:39:41 +0100
Message-ID: <20091206083941.GA2881__15695.3868842267$1260088874$gmane$org@elte.hu>
References: <200912052216.19540.rjw@sisk.pl> <200912060055.36130.rjw@sisk.pl>
	<20091205164541.5e0f209a@infradead.org>
	<200912060226.06217.rjw@sisk.pl>
	<20091205175852.2500cdad@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091205175852.2500cdad@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> On Sun, 6 Dec 2009 02:26:06 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Sunday 06 December 2009, Arjan van de Ven wrote:
> > > On Sun, 6 Dec 2009 00:55:36 +0100
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > 
> > > > Disk spinup/spindown takes time, but also some ACPI devices resume
> > > > slowly, serio devices do that too and there are surprisingly many
> > > > drivers that wait (using msleep() during suspend and resume).
> > > > Apart from this, every PCI device going from D0 to D3 during
> > > > suspend and from D3 to D0 during resume requires us to sleep for
> > > > 10 ms (the sleeping is done by the PCI core, so the drivers don't
> > > > even realize its there).
> > > 
> > > maybe a good step is to make a scripts/bootgraph.pl equivalent for
> > > suspend/resume (or make a debug mode that outputs in a compatible
> > > format so that the script can be used as is.. I don't mind either
> > > way, and consider this my offer to help with such a script as long
> > > as there's sufficient logging in dmesg ;-)
> > 
> > OK, so what kind of logging is needed?
> 
> basically the equivalent of the two initcall_debug paths in
> 
> init/main.c:do_one_initcall()
> 
> which prints a start time and an end time (and a pid) for each init 
> function; if we have the same for suspend calls (and resume)... we can 
> make the tool graph it.
>
> Would be nice to get markers for start and end of the whole suspend 
> sequence as well as for the resume sequence; those make it easier to 
> know when the end is (so that the axis can be drawn etc)
> 
> shouldn't be too hard to implement...

I think an even better option would be to extend 'perf timechart' to be 
suspend/resume aware: add a few tracepoint events and teach 'perf 
timechart' to draw them. (We should be able to do perf timechart record 
across suspend/resume cycles just fine.)

( Doing that would also improve the tracing facilities within 
  suspend/resume quite significantly. It wouldnt just be a 
  single-purpose thing for graphing, but perf trace and perf stat would 
  work equally well. )

Thanks,

	Ingo
