From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: 2.6.28-rc7-git2: Reported regressions from 2.6.27
Date: Wed, 03 Dec 2008 18:17:21 -0600
Message-ID: <1228349841.5551.100.camel__14553.8888442845$1228350133$gmane$org@localhost.localdomain>
References: <QFIA5HSHV8B.A.2aG.hoxNJB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <QFIA5HSHV8B.A.2aG.hoxNJB@chimera>
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
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2008-12-03 at 22:49 +0100, Rafael J. Wysocki wrote:
> Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=12120
> Subject         : [Block layer or SCSI] requests aborted too early
> during check_partition()
> Submitter       : Stefan Richter <stefan-r-bz@s5r6.in-berlin.de>
> Date            : 2008-11-29 05:19 (5 days old)

Fixed by this patch:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9728c0814ecb505546696a659858fdb761375544

James
