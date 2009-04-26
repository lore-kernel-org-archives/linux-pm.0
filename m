From: "Almer S. Tigelaar" <almer@gnome.org>
Subject: Re: [Regression] sony-laptop breaks resume from S2RAM
 (was: Re: Resume after suspend-to-ram broken for Vaio SR19VN in 30rc2)
Date: Sun, 26 Apr 2009 17:52:04 +0200
Message-ID: <1240761124.8277.10.camel@rufio.student.utwente.nl>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com>
	<200904212050.25531.rjw@sisk.pl>
	<31c940650904220555v1c1a6046ifa40b9c81b390731@mail.gmail.com>
	<200904222202.24271.rjw@sisk.pl>
	<31c940650904221335v21fbffc2y2e9598b564d65659@mail.gmail.com>
	<20090423125025.GA6195@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090423125025.GA6195@kamineko.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mattia Dongili <malattia@linux.it>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, fanderay <fanderay4@googlemail.com>
List-Id: linux-pm@vger.kernel.org

Hi Mattia,

On Thu, 2009-04-23 at 21:50 +0900, Mattia Dongili wrote:
> On Wed, Apr 22, 2009 at 09:35:13PM +0100, fanderay wrote:
> > >> CONFIG_SONY_LAPTOP=y, the hard freeze on resume occurs.  Without this
> > >> driver in the kernel, resume after s2ram -f -p appears to work
> > >> correctly.
>
> Almer,
> you have an SR too, do you see the same problem as fanderay?

This problem does not occur with 2.6.30-rc2 for me (when using
sony-laptop as a module). It comes out of the resume just fine.

Note that this is with an Sony SR39VN, which is a newer version of the
SR model than fanderay's. If the same problem persists for him (even
when loading it as a module): I suspect this might be a firmware / BIOS
version issue.

Sidenote: I can not see many interesting differences between the DSDT's
of the two models (see below).

With kind regards,

Almer S. Tigelaar

--- SR19VN.dsl	2009-04-26 17:46:01.000000000 +0200
+++ SR39VN.dsl	2009-04-26 17:46:27.000000000 +0200
@@ -2,20 +2,20 @@
  * Intel ACPI Component Architecture
  * AML Disassembler version 20061109
  *
- * Disassembly of dsdt.bin, Thu Apr 23 17:48:38 2009
+ * Disassembly of DSDT.aml, Mon Mar  2 21:06:47 2009
  *
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000857E (34174)
+ *     Length           0x00008505 (34053)
  *     Revision         0x01
  *     OEM ID           "Sony"
  *     OEM Table ID     "VAIO"
- *     OEM Revision     0x20081231 (537399857)
+ *     OEM Revision     0x20081113 (537399571)
  *     Creator ID       "INTL"
  *     Creator Revision 0x20051117 (537202967)
  */
-DefinitionBlock ("dsdt.aml", "DSDT", 1, "Sony", "VAIO", 0x20081231)
+DefinitionBlock ("DSDT.aml", "DSDT", 1, "Sony", "VAIO", 0x20081113)
 {
     External (PDC3)
     External (PDC2)
@@ -94,7 +94,7 @@
     Name (PDBR, 0x4D)
     Name (TPMF, 0x01)
     Name (SMBL, 0x10)
-    OperationRegion (GNVS, SystemMemory, 0xBDEEFD90, 0x0100)
+    OperationRegion (GNVS, SystemMemory, 0xBDEEDD90, 0x0100)
     Field (GNVS, AnyAcc, Lock, Preserve)
     {
         OSYS,   16, 
@@ -219,7 +219,7 @@
 
     Scope (\_SB)
     {
-        Name (PR00, Package (0x16)
+        Name (PR00, Package (0x15)
         {
             Package (0x04)
             {
@@ -311,14 +311,6 @@
 
             Package (0x04)
             {
-                0x001AFFFF, 
-                0x03, 
-                LNKC, 
-                0x00
-            }, 
-
-            Package (0x04)
-            {
                 0x001BFFFF, 
                 0x00, 
                 LNKG, 
@@ -397,7 +389,7 @@
                 0x00
             }
         })
-        Name (AR00, Package (0x16)
+        Name (AR00, Package (0x15)
         {
             Package (0x04)
             {
@@ -489,14 +481,6 @@
 
             Package (0x04)
             {
-                0x001AFFFF, 
-                0x03, 
-                0x00, 
-                0x12
-            }, 
-
-            Package (0x04)
-            {
                 0x001BFFFF, 
                 0x00, 
                 0x00, 
@@ -6221,7 +6205,7 @@
         }
     }
 
-    OperationRegion (SMI0, SystemMemory, 0xBDF04B90, 0x0420)
+    OperationRegion (SMI0, SystemMemory, 0xBDF05B90, 0x0420)
     Field (SMI0, AnyAcc, NoLock, Preserve)
     {
         BCMD,   8, 
@@ -6673,13 +6657,6 @@
                         Notify (\_SB.PCI0.LPCB.SNC, 0x93)
                     }
 
-                    Method (_Q43, 0, NotSerialized)
-                    {
-                        P8XH (0x00, 0x43)
-                        Or (\_SB.PCI0.LPCB.SNC.ESR, 0x08, \_SB.PCI0.LPCB.SNC.ESR)
-                        Notify (\_SB.PCI0.LPCB.SNC, 0x93)
-                    }
-
                     Name (MB1P, 0x81)
                     Name (MB1R, 0x01)
                     Name (MB2P, 0x82)
