From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [RFC PATCH v1] ACPI S3 to work under Xen.
Date: Wed, 31 Aug 2011 14:31:17 -0400
Message-ID: <1314815484-4668-1-git-send-email-konrad.wilk__9592.4528468915$1314917920$gmane$org@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org, tglx@linutronix.de, tboot-devel@lists.sourceforge.net, shane.wang@intel.com, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, len.brown@in
Cc: xen-devel@lists.xensource.com
List-Id: linux-pm@vger.kernel.org

Attached is an RFC set of patches to enable S3 to work with the Xen hypervisor.

The relationship that Xen has with Linux kernel is symbiotic. The Linux
kernel does the ACPI "stuff" and tells the hypervisor to do the low-level
stuff (such as program the IOAPIC, setup vectors, etc). The realm of
ACPI S3 is more complex as we need to save the CPU state (and Intel TXT
values - which the hypervisor has to do) and then restore them.

The major difficulties we hit was with 'acpi_suspend_lowlevel' - which tweaks
a lot of lowlevel values and some of them are not properly handled by Xen.
Liang Tang has figured which ones of them we trip over (read below) - and he
suggested that perhaps we can provide a registration mechanism to abstract
this away.

So the attached patches do exactly that - there are two entry points
in the ACPI.

 1). For S3: acpi_suspend_lowlevel -> .. lots of code -> acpi_enter_sleep_state
 2). For S1/S4/S5: acpi_enter_sleep_state

The first naive idea was of abstracting away in the 'acpi_enter_sleep_state'
function the tboot_sleep code so that we can use it too. And low-behold - it
worked splendidly for powering off (S5 I believe)

For S3 that did not work - during suspend the hypervisor tripped over when
saving cr8. During resume it tripped over at restoring the cr3, cr8, idt,
and gdt values.

What do you guys think? One thought is to use the paravirt interface to
deal with cr3, cr8, idt, gdt for suspend/resume case.. But that is a lot
of extra 'if' in the paravirt code  - which the callback registration would
effectively do the same thing as the paravirt - except at a higher level.

Thoughts?


Konrad Rzeszutek Wilk (5):
      x86: Expand the x86_msi_ops to have a restore MSIs.
      x86, acpi, tboot: Have a ACPI sleep override instead of calling tboot_sleep.
      xen: Utilize the restore_msi_irqs hook.
      xen/acpi/sleep: Enable ACPI sleep via the __acpi_override_sleep
      xen/acpi/sleep: Register to the acpi_suspend_lowlevel a callback.

Liang Tang (1):
      x86/acpi/sleep: Provide registration for acpi_suspend_lowlevel.

Yu Ke (1):
      xen/acpi: Domain0 acpi parser related platform hypercall

 arch/ia64/include/asm/xen/interface.h |    1 +
 arch/x86/include/asm/acpi.h           |    5 +-
 arch/x86/include/asm/pci.h            |    9 +
 arch/x86/include/asm/x86_init.h       |    1 +
 arch/x86/include/asm/xen/hypercall.h  |    8 +
 arch/x86/include/asm/xen/interface.h  |    1 +
 arch/x86/kernel/acpi/boot.c           |    5 +
 arch/x86/kernel/acpi/sleep.c          |    4 +-
 arch/x86/kernel/acpi/sleep.h          |    2 +
 arch/x86/kernel/tboot.c               |   13 +-
 arch/x86/kernel/x86_init.c            |    1 +
 arch/x86/pci/xen.c                    |   12 ++
 arch/x86/xen/enlighten.c              |    3 +
 drivers/acpi/acpica/hwsleep.c         |   12 +-
 drivers/acpi/sleep.c                  |    2 +
 drivers/pci/msi.c                     |   29 +++-
 drivers/xen/Makefile                  |    2 +-
 drivers/xen/acpi.c                    |   25 +++
 include/linux/tboot.h                 |    3 +-
 include/xen/acpi.h                    |   38 ++++
 include/xen/interface/physdev.h       |    7 +
 include/xen/interface/platform.h      |  320 +++++++++++++++++++++++++++++++++
 include/xen/interface/xen.h           |    1 +
 23 files changed, 491 insertions(+), 13 deletions(-)
