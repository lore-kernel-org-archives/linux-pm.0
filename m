From: Len Brown <lenb@kernel.org>
Subject: [PATCH 66/76] ACPI: Fix use-after-free in acpi_map_lsapic
Date: Fri, 30 Mar 2012 06:14:09 -0400
Message-ID: <ac909ec308ce8d5177963c780564824d12bc3fa2.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Alok N Kataria <akataria@vmware.com>, Petr Vandrovec <petr@vmware.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Petr Vandrovec <petr@vmware.com>

When processor is being hot-added to the system, acpi_map_lsapic invokes
ACPI _MAT method to find APIC ID and flags, verifies that returned structure
is indeed ACPI's local APIC structure, and that flags contain MADT_ENABLED
bit.  Then saves APIC ID, frees structure - and accesses structure when
computing arguments for acpi_register_lapic call.  Which sometime leads
to acpi_register_lapic call being made with second argument zero, failing
to bring processor online with error 'Unable to map lapic to logical cpu
number'.

As lapic->lapic_flags & ACPI_MADT_ENABLED was already confirmed to be non-zero
few lines above, we can just pass unconditional ACPI_MADT_ENABLED to the
acpi_register_lapic.

Signed-off-by: Petr Vandrovec <petr@vmware.com>
Signed-off-by: Alok N Kataria <akataria@vmware.com>
Reviewed-by: Toshi Kani <toshi.kani@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/boot.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index ce664f3..bbcc2c3 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -642,6 +642,7 @@ static int __cpuinit _acpi_map_lsapic(acpi_handle handle, int *pcpu)
 	kfree(buffer.pointer);
 	buffer.length = ACPI_ALLOCATE_BUFFER;
 	buffer.pointer = NULL;
+	lapic = NULL;
 
 	if (!alloc_cpumask_var(&tmp_map, GFP_KERNEL))
 		goto out;
@@ -650,7 +651,7 @@ static int __cpuinit _acpi_map_lsapic(acpi_handle handle, int *pcpu)
 		goto free_tmp_map;
 
 	cpumask_copy(tmp_map, cpu_present_mask);
-	acpi_register_lapic(physid, lapic->lapic_flags & ACPI_MADT_ENABLED);
+	acpi_register_lapic(physid, ACPI_MADT_ENABLED);
 
 	/*
 	 * If mp_register_lapic successfully generates a new logical cpu
-- 
1.7.10.rc2.19.gfae9d
