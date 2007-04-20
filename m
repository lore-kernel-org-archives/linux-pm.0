From: Dave Jones <davej@redhat.com>
Subject: Re: [2/2] 2.6.21-rc7: known regressions
Date: Fri, 20 Apr 2007 12:03:08 -0400
Message-ID: <20070420160308.GB20118@redhat.com>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070416003723.GM3691@stusta.de> <4628482B.6040804@goop.org>
	<20070420050344.GG20566@redhat.com> <46284C84.6060301@goop.org>
	<20070420051908.GH20566@redhat.com> <462850B3.70901@goop.org>
	<20070420145126.GC25051@redhat.com> <4628DC0A.60707@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4628DC0A.60707@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: gregkh@suse.de, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 20, 2007 at 08:28:10AM -0700, Jeremy Fitzhardinge wrote:
 > Dave Jones wrote:
 > > -BUG: at arch/i386/kernel/sched-clock.c:170 init_sched_clock()
 > > - [<c01091b5>] show_trace_log_lvl+0x1a/0x30
 > > - [<c010980c>] show_trace+0x12/0x14
 > > - [<c01098cb>] dump_stack+0x16/0x18
 > > - [<c0468dbd>] init_sched_clock+0x58/0x9b
 > > - [<c0461502>] init+0x14b/0x241
 > > - [<c0108d97>] kernel_thread_helper+0x7/0x10
 > > - =======================
 > >
 > > heh, one for Ingo :)
 > Andi, I think.  I've got his firstfloor.org patches applied to this kernel.

Ah, I saw you patched in CFS too, and thought it may be related.

 > > So most of the differences seem to be BIOS/firmware rather than hardware. 
 > > The PCI bus layout is identical for eg.
 > 
 > Do you have Intel wireless?  I realized one chance I'd made was to swap
 > the Atheros wireless with Intel, since it just seems to work better
 > overall.  I'd never had any major suspend/resume problems that I could
 > attribute to madwifi though (lots of minor wifi-related ones though).

yeah, the intel wireless.  Same as teh one in your pci.gz attachment..
03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Network Connection (rev 02)
	Subsystem: Intel Corporation Unknown device 1010
	Flags: bus master, fast devsel, latency 0, IRQ 21

	Dave

-- 
http://www.codemonkey.org.uk
