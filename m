From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.30-rc2-git2: Reported regressions from 2.6.29
Date: Thu, 16 Apr 2009 17:46:15 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904161742140.4042__15637.4699705795$1239929852$gmane$org@localhost.localdomain>
References: <EJaiQ4Wfaz.A.3YG.4v85JB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <EJaiQ4Wfaz.A.3YG.4v85JB@chimera>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 16 Apr 2009, Rafael J. Wysocki wrote:
> 
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=13098
> Subject		: 2.6.29-git12 breaks vga=0x0f07 on MSI/Intel GPU
> Submitter	: Andi Kleen <andi@firstfloor.org>
> Date		: 2009-04-06 01:14 (11 days old)
> References	: http://lkml.org/lkml/2009/4/5/200
> Handled-By	: H. Peter Anvin <hpa@zytor.com>

I think this got fixed already. The VGA moresettign was reverted back to 
the old order.

> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=13044
> Subject		: 2.6.30-rc1 can't find the root fs
> Submitter	: Heinz Diehl <htd@fancy-poultry.org>
> Date		: 2009-04-08 13:35 (9 days old)

This was one of the async things that got fixed by just waiting for module 
async work to finish.

		Linus
