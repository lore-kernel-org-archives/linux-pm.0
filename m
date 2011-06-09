From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v4] ARM
	hibernation/suspend-to-disk	support
Date: Thu, 9 Jun 2011 18:53:13 +0100
Message-ID: <20110609175313.GG24424__16049.8983729214$1307642080$gmane$org@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<4DF0F45A.3030103@ti.com>
	<20110609164024.GB24424@n2100.arm.linux.org.uk>
	<4DF0FA73.8050607@ti.com>
	<20110609171255.GD24424@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110609171255.GD24424@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 09, 2011 at 06:12:55PM +0100, Russell King - ARM Linux wrote:
> > 3. Avoid direct write to AUXCTRL in generic suspend code.
> 
> This is the only problematical one that I can see.  We need to restore
> this on systems running in secure mode.  What we could do is rather than
> writing to the register, read it first and compare its value with what
> was saved to see whether we need to write it.
> 
> Then, if platforms run in non-secure mode, they are responsible for
> restoring that register back to its pre-suspend value before their
> assembly calls cpu_resume().

And here's a patch which does that:

8<-----------
From: Russell King <rmk+kernel@arm.linux.org.uk>
ARM: Avoid writing to auxctrl register unless it needs to be updated

As the auxiliary control register is not writable in non-secure mode
such as on OMAP, we must avoid writing the register when resuming in
non-secure mode.  Avoid this by moving the responsibility to the
SoC code in this case to ensure that the auxiliary control register
is restored before cpu_resume() is called.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
--
 arch/arm/mm/proc-v7.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3c38678..fa1e6d5 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -237,7 +237,9 @@ ENTRY(cpu_v7_do_resume)
 	mcr	p15, 0, r7, c2, c0, 0	@ TTB 0
 	mcr	p15, 0, r8, c2, c0, 1	@ TTB 1
 	mcr	p15, 0, ip, c2, c0, 2	@ TTB control register
-	mcr	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
+	mrc	p15, 0, r4, c1, c0, 1	@ Read auxiliary control register
+	teq	r4, r10
+	mcrne	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
 	mcr	p15, 0, r11, c1, c0, 2	@ Co-processor access control
 	ldr	r4, =PRRR		@ PRRR
 	ldr	r5, =NMRR		@ NMRR
