From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v1 5/6] bitops: Introduce BIT_ULL
Date: Thu, 19 Sep 2013 11:14:50 -0700
Message-ID: <1379614490.22168.7.camel@joe-AO722>
References: <1379606435-15871-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1379606435-15871-6-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20130919164830.GB9427@pd.tnic> <523B2F57.2050504@linux.intel.com>
	 <20130919172819.GD9412@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:33401 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752045Ab3ISSOz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2013 14:14:55 -0400
In-Reply-To: <20130919172819.GD9412@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com

On Thu, 2013-09-19 at 19:28 +0200, Borislav Petkov wrote:
> On Thu, Sep 19, 2013 at 10:07:35AM -0700, Srinivas Pandruvada wrote:
> > The current definition for BIT_64 is in arch/x86/include/asm/bitops.h.
> > I feel it should be applicable for all architectures and move to some
> > common file.
> 
> Feel free to move it there or change BIT_64 to BIT_ULL or whatever ...
> just don't add yet another redundant macro.

Seems sensible.

Maybe using U32_C/U64_C is better than 1ul and 1ull
as it'd work in assembly.

Maybe something like:

Add BIT_ULL/BIT_ULL_MASK/BIT_ULL_WORD
Rename BIT_64 uses to BIT_ULL
Remove BIT_64 from x86 specific location

---

It looks like bitops.h needs
#include <linux/kernel.h>
as it uses DIV_ROUND_UP

 arch/x86/include/asm/bitops.h    |  2 --
 arch/x86/kernel/cpu/mcheck/mce.c |  4 ++--
 drivers/edac/amd64_edac.c        | 10 +++++-----
 drivers/edac/mce_amd.c           |  2 +-
 drivers/edac/mce_amd.h           |  4 ++--
 include/linux/bitops.h           | 13 ++++++++++---
 6 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 41639ce..f0bb112 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -23,8 +23,6 @@
 # error "Unexpected BITS_PER_LONG"
 #endif
 
-#define BIT_64(n)			(U64_C(1) << (n))
-
 /*
  * These have to be done with inline assembly: that way the bit-setting
  * is guaranteed to be atomic. All bit operations return 0 if the bit
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index b3218cd..8074b58 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1551,8 +1551,8 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 				 rdmsrl(msrs[i], val);
 
 				 /* CntP bit set? */
-				 if (val & BIT_64(62)) {
-					val &= ~BIT_64(62);
+				 if (val & BIT_ULL(62)) {
+					val &= ~BIT_ULL(62);
 					wrmsrl(msrs[i], val);
 				 }
 			 }
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 3c9e4e9..f277053 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1310,7 +1310,7 @@ static u64 f1x_get_norm_dct_addr(struct amd64_pvt *pvt, u8 range,
 		if ((!(dct_sel_base_addr >> 16) ||
 		     dct_sel_base_addr < dhar_base(pvt)) &&
 		    dhar_valid(pvt) &&
-		    (sys_addr >= BIT_64(32)))
+		    (sys_addr >= BIT_ULL(32)))
 			chan_off = hole_off;
 		else
 			chan_off = dct_sel_base_off;
@@ -1324,7 +1324,7 @@ static u64 f1x_get_norm_dct_addr(struct amd64_pvt *pvt, u8 range,
 		 * else
 		 *	remove dram base to normalize to DCT address
 		 */
-		if (dhar_valid(pvt) && (sys_addr >= BIT_64(32)))
+		if (dhar_valid(pvt) && (sys_addr >= BIT_ULL(32)))
 			chan_off = hole_off;
 		else
 			chan_off = dram_base;
@@ -1459,7 +1459,7 @@ static int f1x_match_to_this_node(struct amd64_pvt *pvt, unsigned range,
 
 	if (dhar_valid(pvt) &&
 	    dhar_base(pvt) <= sys_addr &&
-	    sys_addr < BIT_64(32)) {
+	    sys_addr < BIT_ULL(32)) {
 		amd64_warn("Huh? Address is in the MMIO hole: 0x%016llx\n",
 			    sys_addr);
 		return -EINVAL;
@@ -1551,7 +1551,7 @@ static int f15_m30h_match_to_this_node(struct amd64_pvt *pvt, unsigned range,
 
 	if (dhar_valid(pvt) &&
 	    dhar_base(pvt) <= sys_addr &&
-	    sys_addr < BIT_64(32)) {
+	    sys_addr < BIT_ULL(32)) {
 		amd64_warn("Huh? Address is in the MMIO hole: 0x%016llx\n",
 			    sys_addr);
 		return -EINVAL;
@@ -1582,7 +1582,7 @@ static int f15_m30h_match_to_this_node(struct amd64_pvt *pvt, unsigned range,
 	leg_mmio_hole = (u8) (dct_cont_base_reg >> 1 & BIT(0));
 
 	/* Get normalized DCT addr */
-	if (leg_mmio_hole && (sys_addr >= BIT_64(32)))
+	if (leg_mmio_hole && (sys_addr >= BIT_ULL(32)))
 		chan_offset = dhar_offset;
 	else
 		chan_offset = dct_base << 27;
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 30f7309..6486270 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -395,7 +395,7 @@ static void decode_mc1_mce(struct mce *m)
 		pr_cont("%s TLB %s.\n", LL_MSG(ec),
 			(xec ? "multimatch" : "parity error"));
 	else if (BUS_ERROR(ec)) {
-		bool k8 = (boot_cpu_data.x86 == 0xf && (m->status & BIT_64(58)));
+		bool k8 = (boot_cpu_data.x86 == 0xf && (m->status & BIT_ULL(58)));
 
 		pr_cont("during %s.\n", (k8 ? "system linefill" : "NB data read"));
 	} else if (fam_ops->mc1_mce(ec, xec))
diff --git a/drivers/edac/mce_amd.h b/drivers/edac/mce_amd.h
index 51b7e3a..f4aa69d 100644
--- a/drivers/edac/mce_amd.h
+++ b/drivers/edac/mce_amd.h
@@ -32,8 +32,8 @@
 #define R4(x)				(((x) >> 4) & 0xf)
 #define R4_MSG(x)			((R4(x) < 9) ?  rrrr_msgs[R4(x)] : "Wrong R4!")
 
-#define MCI_STATUS_DEFERRED		BIT_64(44)
-#define MCI_STATUS_POISON		BIT_64(43)
+#define MCI_STATUS_DEFERRED		BIT_ULL(44)
+#define MCI_STATUS_POISON		BIT_ULL(43)
 
 extern const char * const pp_msgs[];
 
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index a3b6b82..33e6f13 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -3,11 +3,18 @@
 #include <asm/types.h>
 
 #ifdef	__KERNEL__
-#define BIT(nr)			(1UL << (nr))
-#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
-#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+
 #define BITS_PER_BYTE		8
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
+
+#define BIT(nr)			(U32_C(1) << (nr))
+#define BIT_MASK(nr)		(U32_C(1) << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+
+#define BIT_ULL(nr)		(U64_C(1) << (nr))
+#define BIT_ULL_MASK(nr)	(U64_C(1) << ((nr) % BITS_PER_LONG))
+#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG)
+
 #endif
 
 extern unsigned int __sw_hweight8(unsigned int w);


