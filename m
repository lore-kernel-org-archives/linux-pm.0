From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: 2.6.29-git13: Reported regressions from 2.6.28
Date: Wed, 22 Apr 2009 13:32:49 -0600
Message-ID: <49EF70E1.9030904__26546.1814277389$1240429197$gmane$org@nortel.com>
References: <n4io5wq70ZO.A.gzG.rFn2JB@chimera>
	<alpine.LFD.2.00.0904061443000.7443@localhost.localdomain>
	<200904070035.00784.rjw@sisk.pl> <49E79E58.9000606@nortel.com>
	<alpine.LFD.2.00.0904161432000.4042@localhost.localdomain>
	<49ECE783.5050704@nortel.com>
	<Pine.LNX.4.64.0904202352520.2924@blonde.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0904202352520.2924@blonde.anvils>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hugh Dickins <hugh@veritas.com>
Cc: Adrian Bunk <bunk@kernel.org>, Trenton Adams <trenton.d.adams@gmail.com>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hugh Dickins wrote:
> On Mon, 20 Apr 2009, Chris Friesen wrote:

>> For anonymous mappings, the older kernels put the starting address of the VMA
>> (from the point of view of the app) as the offset.  Until the recent change,
>> new kernels still did this for most VMAs, but the stack offset was a 64-bit
>> value with no obvious relation to the VMA start address.
> 
> No, what they put there was something that in most cases matched the
> starting address of the VMA; but try moving that VMA with mremap (and
> an old /proc/<pid>/maps!) and you'll see that the "offset" remained
> unchanged even when the starting address of the VMA was changed.
> 
> (The offset remaining constant so that rmap can locate the VMA's pages
> and unmap them, despite their being mapped at different virtual
> addresses in parent and child after a move in one of them.)
> 
> ... so I think your app was indeed already broken, wasn't it?
> 
> It's also unclear why you'd want to use the offset field for the
> starting address of the VMA, when /proc/<pid>/maps already shows
> the starting address of the VMA.  I think you've more to tell us!

Yeah, given the above the app was broken.  We just didn't run into any 
cases where the assumption caused any problems.

Also, it's not so much that we were relying on the offset value for 
anything, so much as we were parsing the file and had made some 
assumptions about valid offsets for anonymous memory.

Anyways, we'll fix it going forward to simply ignore the offset for 
anonymous memory.

Chris
