From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.31-rc6-git5: Reported regressions from 2.6.30
Date: Thu, 20 Aug 2009 23:28:24 +0200
Message-ID: <200908202328.24252.rjw__23986.2481634647$1250803708$gmane$org@sisk.pl>
References: <jCYznkTxcLB.A.EPH.eNIjKB@chimera> <1250801571.7176.10.camel@Maple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1250801571.7176.10.camel@Maple>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: John Dykstra <john.dykstra1@gmail.com>
Cc: Adrian Bunk <bunk@kernel.org>, DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 20 August 2009, John Dykstra wrote:
> On Wed, 2009-08-19 at 22:20 +0200, Rafael J. Wysocki wrote:
> > Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=14002
> > Subject         : WARNING: at net/ipv4/af_inet.c:154
> > inet_sock_destruct+0x164/0x1c0()
> > Submitter       : Ralf Hildebrandt <ralf.hildebrandt@charite.de>
> > Date            : 2009-08-18 12:37 (2 days old)
> 
> That looks similar to the WARNING discussed in [1].
> 
> There was no resolution to that thread.  However, [2] points out
> possible other occurrences of the problem in 2.6.27, 28 and 29.
> 
> --  John
> 
> [1]  http://www.spinics.net/lists/netdev/msg103267.html
> [2]  http://www.spinics.net/lists/netdev/msg104120.html

Thanks for the information.

So I'll drop this from the list, since it most probably is not a recent thing.

Best,
Rafael
