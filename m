From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/6] ACPI / PM: Simplifications of core suspend
	and hibernate code
Date: Mon, 7 Feb 2011 23:16:41 +0100
Message-ID: <201102072316.41270.rjw__29749.5790910491$1297117569$gmane$org@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches reduces complexity of the core suspend
and hibernate code a bit.

[1/6] - Remove acpi_restore_state_mem() which isn't used.
[2/6] - Do not turn interrupts on/off in acpi_suspend_enter().
[3/6] - Move the "back to C" message and make it meaningful.
[4/6] - Move the call to acpi_save_state_mem() towards do_suspend_lowlevel().
[5/6] - Merge do_suspend_lowlevel() into acpi_save_state_mem().
[6/6] - Do not turn interrupts on/off in acpi_hibernation_enter().

I'm regarding these patches as 2.6.39 material, if there are no objections.

Thanks,
Rafael
