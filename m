From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.29-rc6: Reported regressions from 2.6.28
Date: Tue, 24 Feb 2009 08:15:50 +0100
Message-ID: <20090224071550.GA10436__26340.7903993086$1235459938$gmane$org@elte.hu>
References: <GVhknozYwrL.A.hiC.rozoJB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <GVhknozYwrL.A.hiC.rozoJB@chimera>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, "Adam J. Richter" <adam@yggdrasil.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zij>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


(note, the standalone mail of this bug entry did not make it out 
for some reason.)

* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=12760
> Subject		: 2.6.29-rc5 hanging at boot when CONFIG_LOCK_STAT=y
> Submitter	: Adam J. Richter <adam@yggdrasil.com>
> Date		: 2009-02-16 6:50 (8 days old)
> References	: http://marc.info/?l=linux-kernel&m=123476768023893&w=4
> Handled-By	: Ingo Molnar <mingo@elte.hu>

Here we came to the conclusion that this is some LILO bug with a 
too large BSS section - that's one thing that CONFIG_LOCK_STAT 
causes. Under Grub the same kernel image boots fine. So unless 
Adam has new data that contradicts this i think we can close 
this bug.

	Ingo
