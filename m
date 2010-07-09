From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.35-rc4-git3: Reported regressions from 2.6.34
Date: Fri, 9 Jul 2010 23:35:50 +0200
Message-ID: <201007092335.50486.rjw__16604.4665420943$1278711559$gmane$org@sisk.pl>
References: <-IGZ64uxA6G.A.P0H.bLmNMB@chimera>
	<AANLkTiknnzWyVpqnPCpyiEVHLgkewd0zaGzLInABRe2G@mail.gmail.com>
	<20100709020440.GJ6405@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100709020440.GJ6405@nowhere>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shawn Starr <shawn.starr@rogers.com>, DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Patrick McHardy <kaber@trash.net>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "David S. Miller" <davem@davemloft.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Dave Airlie <airlied@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Friday, July 09, 2010, Frederic Weisbecker wrote:
> On Thu, Jul 08, 2010 at 06:34:25PM -0700, Linus Torvalds wrote:
> > On Thu, Jul 8, 2010 at 4:33 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=16284
> > > Subject         : Hitting WARN_ON in hw_breakpoint code
> > > Submitter       : Paul Mackerras <paulus@samba.org>
> > > Date            : 2010-06-23 12:57 (16 days old)
> > > Message-ID      : <20100623125740.GA3368@brick.ozlabs.ibm.com>
> > > References      : http://marc.info/?l=linux-kernel&m=127729789113432&w=2
> > 
> > This has "I have a fix, will post it very soon." in the thread from
> > Frederic, but I'm not seeing anything else. Frederic?
> 
> 
> 
> Right. In fact it wasn't a regression. The per task breakpoint reservation
> design was broken from the beginning and this warning has revealed the
> problem. This only touched perf, and it did since perf support breakpoints.
> Fortunately ptrace wasn't concerned by this problem, even not by side effects
> of this.
> 
> The fix is invasive as it's a rewrite of a (little) part of the breakpoint
> reservation. And since the symptom is only a warning and also breakpoints
> never released from the constraint table (just a counter, no memory leak),
> the fix is headed for 2.6.36.
> 
> It is ready in tip:/perf/core:
> 
> http://git.kernel.org/?p=linux/kernel/git/tip/linux-2.6-tip.git;a=commitdiff;h=45a73372efe4a63f44aa2e1125d4a777c2fdc8d8
> 
> I think this ticket can be safely closed.

OK, closing.

Rafael
