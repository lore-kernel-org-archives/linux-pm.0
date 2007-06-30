From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.22-rcX Transmeta/APM regression
Date: Sat, 30 Jun 2007 02:18:47 -0700
Message-ID: <20070630021847.ec7ae2b6.akpm@linux-foundation.org>
References: <20070630030343.31711.qmail@science.horizon.com>
	<4685D6CC.9070007@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4685D6CC.9070007@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: bk@suse.de, michal.k.k.piotrowski@gmail.com, ak@suse.de, linux-kernel@vger.kernel.org, linux@horizon.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 30 Jun 2007 00:06:36 -0400 "H. Peter Anvin" <hpa@zytor.com> wrote:

> linux@horizon.com wrote:
> > 
> > Anyway, the patch which introduces the problem is the aptly named 3ebad:
> > 3ebad59056: [PATCH] x86: Save and restore the fixed-range MTRRs of the BSP when suspending
> > 
> > 2.6.22-rc6 plus that one commit reverted successfully does APM suspend
> > (and resume) for me.
> 
> Okay, I would guess that that patch probably touches MTRRs without 
> actually verify that the CPU *has* MTRRs -- the Transmeta Crusoe CPU 
> doesn't have MTRRs.
> 

This?

--- a/arch/i386/kernel/cpu/mtrr/generic.c~i386-mtrr-crash-fix
+++ a/arch/i386/kernel/cpu/mtrr/generic.c
@@ -65,7 +65,8 @@ get_fixed_ranges(mtrr_type * frs)
 
 void mtrr_save_fixed_ranges(void *info)
 {
-	get_fixed_ranges(mtrr_state.fixed_ranges);
+	if (cpu_has_mtrr)
+		get_fixed_ranges(mtrr_state.fixed_ranges);
 }
 
 static void print_fixed(unsigned base, unsigned step, const mtrr_type*types)
_
