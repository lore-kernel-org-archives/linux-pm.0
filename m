From: Len Brown <lenb@kernel.org>
Subject: [GIT PATCH] ACPI patches for 2.6.25-rc0 (#2)
Date: Fri, 8 Feb 2008 01:45:16 -0500
Message-ID: <200802080145.16774.lenb__275.374242528592$1202453335$gmane$org@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

Nothing exciting here, generally just tweaks to the previous batch.

This will update the files shown below.

thanks!

-Len

ps. individual patches are available on linux-acpi@vger.kernel.org
and a consolidated plain patch is available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.24/acpi-release-20070126-2.6.24.diff.gz

 Documentation/thermal/sysfs-api.txt |   23 +++++------
 drivers/acpi/Kconfig                |   20 +++++++--
 drivers/acpi/blacklist.c            |   20 +++++++++
 drivers/acpi/osl.c                  |    2 
 drivers/acpi/processor_perflib.c    |    7 +++
 drivers/misc/Kconfig                |    5 +-
 drivers/thermal/Kconfig             |    4 -
 drivers/thermal/thermal.c           |   49 +++++++++++++-----------
 8 files changed, 88 insertions(+), 42 deletions(-)

through these commits:

Carlos Corbacho (1):
      ACPI: WMI: Improve Kconfig description

Len Brown (6):
      ACPI: add newline to printk
      ACPI: build WMI on X86 only
      intel_menlo: build on X86 only
      ACPI: thermal: syntax, spelling, kernel-doc
      ACPI: DMI: add Panasonic CF-52 and Thinpad X61
      acer-wmi, tc1100-wmi: select ACPI_WMI

Thomas Renninger (1):
      ACPI: cpufreq: Print _PPC changes via cpufreq debug layer

with this log:

commit 2e6c4e5101633a54aeee1f2e83020ee77fcb70d2
Merge: 446b1df... 4a507d9...
Author: Len Brown <len.brown@intel.com>
Date:   Fri Feb 8 01:22:26 2008 -0500

    Merge branches 'release', 'dmi' and 'misc' into release

commit 4a507d93fac78ecd37d18343c57c564f6a126f01
Author: Len Brown <len.brown@intel.com>
Date:   Fri Feb 8 00:37:16 2008 -0500

    acer-wmi, tc1100-wmi: select ACPI_WMI
    
    It is safe for these Kconfig entries to use select because
    they select ACPI_WMI, which already has its dependencies
    satisfied.  This makes Kconfig more user friendly, since
    the user selects the driver they want and the dependency
    is met for them.  Otherwise, the user would have to find
    and enable ACPI_WMI to make enabling these drivers possible.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 20b4514799ebcfb04b45537e90e421cb73fd0cc9
Author: Carlos Corbacho <carlos@strangeworlds.co.uk>
Date:   Fri Feb 8 00:36:49 2008 -0500

    ACPI: WMI: Improve Kconfig description
    
    As Pavel Machek has pointed out, the Kconfig entry for WMI is pretty
    non-descriptive.
    
    Rewrite it so that it explains what ACPI-WMI is, and why anyone
    would want to enable it.
    
    Many thanks to Ray Lee for ideas on this.
    
    Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
    CC: Pavel Machek <pavel@ucw.cz>
    CC: Ray Lee <ray-lk@madrabbit.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 446b1dfc4cd1c2bbc7eb22d5fec38e23a577492c
Author: Len Brown <len.brown@intel.com>
Date:   Thu Feb 7 16:23:00 2008 -0500

    ACPI: DMI: add Panasonic CF-52 and Thinpad X61
    
    Add Lenovo X61
    Add Panasonic Toughbook CF-52
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 543a956140e1f57331c0e528d2367106057aeca0
Author: Len Brown <len.brown@intel.com>
Date:   Thu Feb 7 16:55:08 2008 -0500

    ACPI: thermal: syntax, spelling, kernel-doc
    
    Reviewed-by: Randy Dunlap <randy.dunlap@oracle.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9f2eef25e044603527e121066284d22f51d853cc
Author: Len Brown <len.brown@intel.com>
Date:   Thu Feb 7 16:19:56 2008 -0500

    intel_menlo: build on X86 only
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9c2f7de8c0f979fc6354bf0d22c0cdcc29722bf6
Author: Len Brown <len.brown@intel.com>
Date:   Thu Feb 7 16:18:24 2008 -0500

    ACPI: build WMI on X86 only
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 919158d17b42683a5c7368e1e77661c65a20a48a
Author: Thomas Renninger <trenn@suse.de>
Date:   Wed Oct 31 15:41:42 2007 +0100

    ACPI: cpufreq: Print _PPC changes via cpufreq debug layer
    
    enabled with CPU_FREQ_DEBUG
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b0b23e0ade6aa265d7278e06d50bc10ec81dd174
Author: Len Brown <len.brown@intel.com>
Date:   Thu Feb 7 14:42:25 2008 -0500

    ACPI: add newline to printk
    
    Signed-off-by: Len Brown <len.brown@intel.com>
