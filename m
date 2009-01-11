From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.29-rc1: Reported regressions from 2.6.28
Date: Sun, 11 Jan 2009 20:00:59 +0100
Message-ID: <200901112001.00394.rjw__20351.3499036946$1231700651$gmane$org@sisk.pl>
References: <XU-8icArWLM.A.UpG.8GfaJB@chimera>
	<3f9a31f40901110546h4c069b5dx9726a0fbf8caf5a1@mail.gmail.com>
	<20090111135237.GA20184@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090111135237.GA20184@elte.hu>
Content-Disposition: inline
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
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jaswinder Singh Rajput <jaswinderlinux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 11 January 2009, Ingo Molnar wrote:
> 
> * Jaswinder Singh Rajput <jaswinderlinux@gmail.com> wrote:
> 
> > On Sun, Jan 11, 2009 at 4:42 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > >
> > > Regressions with patches
> > > ------------------------
> > >
> > > Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=12428
> > > Subject         : Build error on latest git
> > > Submitter       : Petr Titera <P.Titera@century.cz>
> > > Date            : 2009-01-11 9:49 (1 days old)
> > > References      : http://marc.info/?l=linux-kernel&m=123166856318712&w=4
> > > Handled-By      : Petr Titera <P.Titera@century.cz>
> > > Patch           : http://marc.info/?l=linux-kernel&m=123167509024996&w=4
> > 
> > This is a wrong fix, asm/smp.h should only be included when CONFIG_SMP 
> > is defined.
> > 
> > I am still in the process of cleaning non-smp data from asm/smp.h for 
> > x86
> > 
> > Attach patch is the solution for the time being
> > 
> > Ingo, can you please put this in urgent queue.
> 
> yes, it already is - see below.

Link to this patch was added to the bug entry.  Pleaes let me know or close the
bug when it's merged.

Thanks,
Rafael
