From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/6] ACPI: Simplifications of the GPE-handling
	code
Date: Fri, 25 Jun 2010 01:17:44 +0200
Message-ID: <201006250117.45148.rjw__19058.0892180607$1277422372$gmane$org@sisk.pl>
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
Cc: len.brown@intel.com, "Lin, Ming M" <ming.m.lin@intel.com>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi,

The following patches are intended to simplify the GPE-handling code in
ACPICA and the kernel.

[1/6] and [2/6], already posted as https://patchwork.kernel.org/patch/107612/
and https://patchwork.kernel.org/patch/107613/ , respectively, rework the GPE
code so that reference counting is only used for GPEs enabled at run time.

[3/6] and [4/6] modify the EC driver so that it doesn't use acpi_set_gpe().

[5/6] modifies acpi_ev_initialize_gpe_block() so that it will use a low-level
GPE enabling routine instead of acpi_set_gpe().

Finally, [6/6] removes acpi_set_gpe() which is no longer necessary
(and there is a good reason to get rid of it).

Please apply.

Rafael
