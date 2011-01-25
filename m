From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
	iomaps management
Date: Tue, 25 Jan 2011 17:43:22 +0800 (SGT)
Message-ID: <Pine.LNX.4.64.1101251740380.3737__17002.4510975511$1295948683$gmane$org@boston.corp.fedex.com>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


On Tue, Jan 25, 2011 at 5:37 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, January 24, 2011, Henrique de Moraes Holschuh wrote:
> It turns out there's a bug in intel_idle causing people a lot of pain 
> with CPU hotplugging.  Should be fixed now it the Linus' tree.

Uh, I see the git fix now. Thanks. The workaround I did was to manually 
offline all CPUs before suspend and that fixed it too.

As for the thinkpad-acpi, here a little patch to disable all hotkeys so 
that Fn-F4 works natively to suspend-to-memory when 
CONFIG_THINKPAD_ACPI_HOTKEY_POLL is not set.

Thanks,
Jeff

--- lx/drivers/platform/x86/thinkpad_acpi.c.org	2011-01-22 21:48:05.000000000 +0800
+++ lx/drivers/platform/x86/thinkpad_acpi.c	2011-01-22 21:55:14.000000000 +0800
@@ -8776,10 +8776,12 @@
  	{
  		.data = &thinkpad_acpi_driver_data,
  	},
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
  	{
  		.init = hotkey_init,
  		.data = &hotkey_driver_data,
  	},
+#endif
  	{
  		.init = bluetooth_init,
