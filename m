From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/10] ACPI, APEI, EINJ Allow empty Trigger Error Action Table
Date: Mon, 23 Jan 2012 20:30:07 -0500
Message-ID: <4c40aed869a200a621b53bcb491c5ee8a34ef5f1.1327368464.git.len.brown@intel.com>
References: <1327368609-28409-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1327368609-28409-1-git-send-email-lenb@kernel.org>
In-reply-to: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
References: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ericsson.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Niklas S=C3=B6derlund <niklas.soderlund@ericsson.com>

According to the ACPI spec [1] section 18.6.4 the TRIGGER_ERROR action
table can consists of zero elements.

[1] Advanced Configuration and Power Interface Specification
    Revision 5.0, December 6, 2011
	http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund@ericsson.com>
Acked-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/apei/einj.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 5b898d4..bb20b03 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -276,7 +276,7 @@ static int einj_check_trigger_header(struct acpi_ei=
nj_trigger *trigger_tab)
 	if (trigger_tab->header_size !=3D sizeof(struct acpi_einj_trigger))
 		return -EINVAL;
 	if (trigger_tab->table_size > PAGE_SIZE ||
-	    trigger_tab->table_size <=3D trigger_tab->header_size)
+	    trigger_tab->table_size < trigger_tab->header_size)
 		return -EINVAL;
 	if (trigger_tab->entry_count !=3D
 	    (trigger_tab->table_size - trigger_tab->header_size) /
@@ -340,6 +340,11 @@ static int __einj_error_trigger(u64 trigger_paddr,=
 u32 type,
 			   "The trigger error action table is invalid\n");
 		goto out_rel_header;
 	}
+
+	/* No action structures in the TRIGGER_ERROR table, nothing to do */
+	if (!trigger_tab->entry_count)
+		goto out_rel_header;
+
 	rc =3D -EIO;
 	table_size =3D trigger_tab->table_size;
 	r =3D request_mem_region(trigger_paddr + sizeof(*trigger_tab),
--=20
1.7.9.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
