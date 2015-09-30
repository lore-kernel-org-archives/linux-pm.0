From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: [RFC] ECDT support in early stage
Date: Wed, 30 Sep 2015 03:31:57 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88340673F9@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Brown, Len" <len.brown@intel.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Ryan Underwood <nemesis@icequake.net>, Eddy Petri?or <eddy.petrisor+linbug@gmail.com>, John Morris <mailjohnmorris@gmail.com>, Alex Shumakovitch <shurik@gwu.edu>, "admin@movzx.org" <admin@movzx.org>, Milo Casagrande <milo_casagrande@yahoo.it>, "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>, Jiri Kosina <jikos@jikos.cz>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

There are many ECDT quirks in drivers/acpi/ec.c.

I tracked the commit log back to learn what was happening on each ECDT related commits.

My observation result is:
For ACPI 2.0+ compliant platforms, where ECDT may be introduced, the BIOSes that
contain the ECDT will make the named object's value that originally is flagged in
EC._REG() flagged very early (either default is flagged or flagged in _SB._INI) in order
to have all _INI control methods invoked with EC operation region accessibility ready.
This is one of the key ACPI 2.0 features.
And this implies that, for ACPI 2.0+, before executing all _INI control methods, BIOSes
have already a deal with OSPMs in the spec that there shouldn't be any control methods
executed before _SB._INI. In other words, for EC, in order to support ECDT in early stage,
when ECDT is probed, it:
1. Shouldn't enable GPE in order not to execute any _Lxx/_Exx;
2. Shouldn't handle SCI_EVT in order not to execute any _Qxx;
3. Shouldn't invoke _REG but should still make the region handler ready;
4. Shouldn't visit any namespace objects (either _GPE/_CRS or the EC device itself)
    since it shouldn't think the namespace is ready at this point.

Here is the details:

1. Pre-loaded DSDT EC
   Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=9916
   Reporter: Jiri Kosina <jikos@jikos.cz>
   Machine: Lenovo ThinkPad X61s
   DSDT: \_SB.PCI0.LPC.EC
   ECDT: \_SB.PCI0.LPC.EC
   _REG: Store(Arg1, \H8DR)
   \_H8DR: Default is Zero, set to One very early in \_SB._INI when _REV >= 2.
   Root cause: Shouldn't register EC GPE handler in early stage.
   Old fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=208c70a
   New fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2044702

It looks to me that:
1. The commit 208c70a is wrong, it shouldn't invoke acpi_get_handle() here.
2. The commit 2044702 is correct, it avoids executing control methods during early stage.

2. Pre-loaded DSDT EC is broken/reworked
   Bugzilla: http://bugzilla.kernel.org/show_bug.cgi?id=10100
             https://lkml.org/lkml/2008/2/25/282
   Reporter: Michael S. Tsirkin <m.s.tsirkin@gmail.com>
   Machine: Lenovo ThinkPad T61p
            DSDT: https://lkml.org/lkml/2008/2/25/337
   Root cause: Shouldn't register _Qxx handlers in early stage.
   DSDT: \_SB.PCI0.LPC.EC
   ECDT: \_SB.PCI0.LPC.EC
   _REG: Store(Arg1, \H8DR)
   \_H8DR: Default is Zero, set to One very early in \_SB._INI when _REV >= 2.
   Old Fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4af8e10
   New fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ce52ddf

It looks to me that:
1. The commit 4af8e10 is correct, it reverts wrong commit 208c70a.
2. The commit ce52ddf is wrong, it splits the _Qxx registration from ec_parse_devices() while it really should be there,
     and again invokes acpi_get_handle() in early stage.

Lenovo ThinkPad X61s and T61p are also good ECDT support examples that:
If OSPMs support ACPI 2.0, EC is accessible in AML before executing its _REG.
EC accessibility thus is ready very early in \_SB._INI so that all _INI control methods can access EC.

3. Wrong ECDT - reversed
   Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=9399
   Reporter: Milo Casagrande <milo_casagrande@yahoo.it>
   Machine: Asus L4R, Asus M6R
   DSDT: \_SB.PCI0.SBRG.EC0
   ECDT: \_SB.PCI0.SBRG.EC0
   _REG: Store (Arg1, \_SB.PCI0.SBRG.EC0.REGC)
   \_SB.PCI0.SBRG.EC0.REGC: Default is Zero, returned from \_SB.PCI0.SBRG.EC0.ECAV.
   \_SB.PCI0.SBRG.EC0.ECAV: Return One  If (_REG(0x03, Ones) && _REV >= 2) || _REG(0x03,  One)
                            Return Zero If (_REG(0x03, Ones) && _REV <  2) || _REG(0x03, zero)
                            When ECAV returns Zero, sometimes port 0x66 (EC command/status register) is directly accessed, sometimes no-op.
   Root cause: ECDT is broken. The command/data IO port addresses are reversed.
   Old fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2500822
   New fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c6cb0e8

It looks to me that:
1. The commit 2500822 is good, it adds quirks for the root cause.
2. The commit c6cb0e8 is wrong, it makes the platform working by use namespace EC
     instead of ECDT EC which make the early namespace referencing problem more serious.

For this platform, it looks _REG(0x03, Ones) may be invoked by an OEM driver.
So we may not fix this platform using such a kind of quirk.
If we want to add quirk for this platform in Linux,  we may just make sure:
  EC data register address < EC status/command register address

4. Wrong ECDT - dummy
   Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=11880
   Reporter: <admin@movzx.org>
   Machine: Asus X50GL
   DSDT: \_SB.PCI0.SBRG.EC0
   ECDT: \_SB.PCI0.ISA.EC
   _REG: Store (Arg1, \_SB.PCI0.SBRG.EC0.ECFL)
   \_SB.PCI0.SBRG.EC0.ECFL: Default is Ones, returned from \_SB.PCI0.SBRG.EC0.ECAV
   \_SB.PCI0.SBRG.EC0.ECAV: Return  One If _REV >= 2 || ECFL ==  One
                            Return Zero If _REV <  2 || ECFL == Ones || ECFL == Zero
                            When ECAV returns Zero, always no-op.
   Root cause: ECDT is broken. Both the command/data I/O port addresses and GPE are zero. EC Namepath is incorrect.
   Old fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c5279de

It looks to me that:
1. The commit 2500822 is good, ECDT validation is always needed, but we should
    abort ECDT probing rather than initializing namespace EC instead or we should override ECDT instead.

By investigation, on this platform, EC accessibility can be ready even earlier than thinkpad.
As all EC accesses are allowed even before executing \_SB._INI if OSPMs support ACPI 2.0.

5. Limit pre-loaded DSDT EC to Asus
   Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=11884
   Reporter: Alex Shumakovitch <shurik@gwu.edu>
   Machine: HP EliteBook 2730p
   DSDT: \_SB.PCI0.LPCB.EC0
   ECDT: N/A
   Old fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=235c4a5

It looks to me that this is a small coding issue fix.
See comments for the 9th bug.

6. Wrong ECDT - reversed
   Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=12461
   Reporter: John Morris <mailjohnmorris@gmail.com>
   Machine: MSI MS-171F
   DSDT: \_SB.PCI0.SBRG.EC0
   ECDT: \_SB.PCI0.SBRG.EC0
   _REG: Store (Arg1, \_SB.PCI0.SBRG.EC0.MYEC)
   \_SB.PCI0.SBRG.MYEC: Default is One.
   Root cause: ECDT is broken. The command/data IO port addresses are reversed.
   Old fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a5032bf

It looks to me that:
1. The commit a5032bf is wrong, it shouldn't invoke ec_parse_devices() in early stage.

On this platform, EC accessibility can be ready even earlier than thinkpad/asus.
As all EC accesses are allowed even before loading the DSDT.

7. Broken MSI quirk
   Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=14081
   Reporter: Ryan Underwood <nemesis@icequake.net>
   Machine: HP Pavilion dv2700
   Root cause: DMI table includes "Notebook" which matches MSI quirk
   Old fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0adf3c7

It looks to me that this is a small coding issue fix.
See comments for the 9th bug.

8. ECDT probe code execute control method too early
   Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=14086
   Reporter: Maxim Levitsky <maximlevitsky@gmail.com>
   Machine: Acer Aspire 5720G
   DSDT: \LPCB.EC0
   ECDT: N/A
   _REG: Store (Arg1, \LPCB.EC0.Z009)
   Root cause: _REG shouldn't be invoked (but not fixed correctly)
   Old fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=478fa03

It looks to me that this is a good example that good platforms are broken by the wrong approach (a5032bf).
And the reporter is so good that he has root caused the issue.

9. Broken MSI quirk
   Bugzilla: http://bugzilla.kernel.org/show_bug.cgi?id=14446
   Reporter: Eddy Petri?or <eddy.petrisor+linbug@gmail.com>
   Machine: MSI S271
   Root cause: 
   Old fix: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=55b313f

It looks to me that this is a small coding issue fix. 
And 5,7,8,9 looks to me like that good vendors do not want the buggy quirk applying on their platforms.

The early namespace referencing becomes a serious problem affecting others:
1. After ACPI 2.0, module level AML is actually valid, but this prevents it from
    being correctly supported.
2. Since AML interpreter may be executed in early stage where threading is
     not ready, any AML interpreter fixes need to consider a portable solution for
     both environments while it needn't be that complicated.

Thanks and best regards
-Lv
