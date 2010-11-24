From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/13] ACPI / PM: Rework power resources management
Date: Thu, 25 Nov 2010 00:01:11 +0100
Message-ID: <201011250001.11297.rjw__35276.6085452915$1290640668$gmane$org@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Unfortunately there are a few problems with ACPI power resources management
that should be fixed by the following series of patches.

Patch [1/13] is necessary to fix a recent regression in the mainline kernel and
patch [2/13] also should go into 2.6.37 IMO.  The remaining patches are not so
urgent, but they all are necessary.

[1/13] - Fix regression if fan resume resulting from the rework of power
         resources reference counting.

[2/13] - Do not reference count power resources that can't be turned on.

[3/13] - Rework acpi_power_get_inferred_state() so that it doesn't update
         device->power.state behind the caller's back.

[4/13] - Introduce functions for handling lists of power resources.

[5/13] - Introduce helper function for reference counting power resources
         for a given device and power state.

[6/13] - Introduce function for reading device power state without modifying
         the device object.

[7/13] - Add function for device power state initialization.

[8/13] - Add function for updating device power state in a consistent way.

[9/13] - Register acpi_power_driver before scanning the root of the namespace.

[10/13] - Add power resource ACPI device objects as soon as they are needed.

[11/13] - Rework the management of ACPI power resources in the ACPI fan driver.

[12/13] - Drop acpi_bus_get_power() that has no users now.

[13/13] - Drop acpi_power_nocheck which isn't necessary any more.

The patches have been tested on my HP nx6325 (which is the only machine using
ACPI power resources I have) and a combo patch functionally equivalen to this
series has been tested by Maciej Rutecki.

Please apply.

Thanks,
Rafael
