From: Thomas Renninger <trenn@suse.de>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc5
Date: Thu, 13 Mar 2008 14:50:12 +0100
Message-ID: <1205416212.21619.2.camel__24433.6626412862$1205416368$gmane$org@queen.suse.de>
References: <200803130214.36861.lenb@kernel.org>
	<20080312234516.bb079cc5.akpm@linux-foundation.org>
	<1205391105.2240.68.camel@acpi-hp-zz.sh.intel.com>
	<20080313125541.GA7365@v2.random>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080313125541.GA7365@v2.random>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrea Arcangeli <andrea@qumranet.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2008-03-13 at 13:55 +0100, Andrea Arcangeli wrote:
> On Thu, Mar 13, 2008 at 02:51:45PM +0800, Zhang, Rui wrote:
> > Well, the patch looks good, this may be caused by a BIOS problem.
> > anyway, I wish to get the response from Andrea so that I can do some
> > investigation ASAP.
> 
> Here attached again. syslog isn't available because by the time it
> crash netconsole isn't up yet, but I try to compile it as module and
> see if it crashes by loading it manually later after netconsole
> started. (you didn't ask for syslog until today)
> 
> Hardware is ASUS M2A-VM ACPI BIOS Revision 1604.

If you want to give them a try..., these are the patches which should
fix this BIOS issue (from Len's release branch):

commit c8d16e27a3601d1cbcdfe657eb4ff5e762019e8d
Author: Lin Ming <ming.m.lin@intel.com>
Date:   Fri Feb 29 07:38:54 2008 +0800

    ACPI: fix boot oops regression in thermal
    
    Fix a memory overflow bug when copying
    NULL internal package element object to external.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=10132
    
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/utilities/utobject.c b/drivers/acpi/utilities/utobject.c
index 76ee766..e08b3fa 100644
--- a/drivers/acpi/utilities/utobject.c
+++ b/drivers/acpi/utilities/utobject.c
@@ -432,7 +432,7 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 	 * element -- which is legal)
 	 */
 	if (!internal_object) {
-		*obj_length = 0;
+		*obj_length = sizeof(union acpi_object);
 		return_ACPI_STATUS(AE_OK);
 	}
 

commit b6a163875935ce8e8e85901a7f2b68f7a314d914
Author: Thomas Renninger <trenn@suse.de>
Date:   Wed Mar 12 01:06:24 2008 +0100

    ACPICA: Warn if packages with invalid references are evaluated
    
    And return an error to avoid NULL pointer access by the caller
    Lin Ming's patch avoids corrupted mem access when
    BIOS has invalid references included, the handle is now zero
    instead of corrupted.
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index eba55b7..44ea60c 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -407,6 +407,12 @@ acpi_evaluate_reference(acpi_handle handle,
 			break;
 		}
 
+		if (!element->reference.handle) {
+			printk(KERN_WARNING PREFIX "Invalid reference in"
+			       " package %s\n", pathname);
+			status = AE_NULL_ENTRY;
+			break;
+		}
 		/* Get the  acpi_handle. */
 
 		list->handles[i] = element->reference.handle;
