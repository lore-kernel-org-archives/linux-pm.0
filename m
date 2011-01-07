From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5] PM / ACPI: Fix problems with ACPI NVS saving
	related to using ioremap_cache() by ACPI
Date: Fri, 7 Jan 2011 01:41:02 +0100
Message-ID: <201101070141.02951.rjw__17490.786399185$1294362629$gmane$org@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches makes the NVS save/restore code work correctly
if ioremap_cache() is used by ACPI.

[1/5] - Fix Oops in the NVS saving code related to failing ioremap()
        (patch from Jiri).

[2/5] - Move the NVS save/restore code to drivers/acpi.

[3/5] - Update file information and the list of includes in nvs.c.

[4/5] - Make suspend_nvs_save() use acpi_os_map_memory().

[5/5] - Make ACPI use ioremap_cache() internally.

Please review/test.

Do you want me to take these patches to my tree or are you going to push them
to Linus?

Rafael
