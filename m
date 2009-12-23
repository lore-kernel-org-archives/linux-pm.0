From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression,
	2.6.32->33-rc1] Commit 9f15226e755 breaks resume on Toshiba Portege
	R500
Date: Thu, 24 Dec 2009 00:01:26 +0100
Message-ID: <200912240001.26764.rjw__26197.775200899$1261609337$gmane$org@sisk.pl>
References: <200912230158.42161.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912230158.42161.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andreas Herrmann <andreas.herrmann3@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 23 December 2009, Rafael J. Wysocki wrote:
> Hi Andreas,
> 
> Unfortunately your commit 9f15226e75583547aaf542c6be4bdac1060dd425
> (x86, ucode-amd: Ensure ucode update on suspend/resume after CPU off/online
> cycle) breaks resume from suspend to RAM on my Toshiba Portege R500 (an attempt
> to resume causes a hard hang with 100% CPU load, reproducible 100% of the
> time).  This has been found by bisection and confirmed by reverting this commit
> on top of 2.6.33-rc1.
> 
> Strangely enough, the box doesn't even have an AMD CPU, there's an Intel Core2
> Duo in it, so I suspect some missing check somewhere.
> 
> If I have the time, I'll look deeper into this tomorrow.

I think commit 9f15226e755 is wrong, since it causes microcode_init_cpu()
to be called during resume even for CPUs for which there's no microcode to
apply.  That, in turn, results in executing request_firmware() (on Intel CPUs
at least) which doesn't work at this stage of resume (we have device interrupts
disabled, I/O devices are still suspended and so on).

If I'm not mistaken, the "if (uci->valid)" logic means "if that CPU is known
to us" , so before commit 9f15226e755 microcode_resume_cpu() was called for
all CPUs already in the system during suspend, which was the right thing to do.
The commit changed it so that the CPUs without microcode to apply are now
treated as "unknown", which is not quite right.

The problem this commit attempted to solve has to be handled differently.

Linus, please revert commit 9f15226e755.

Rafael
