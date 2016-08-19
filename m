From: Al Stone <ahs3@redhat.com>
Subject: [PATCH 1/2] x86: ACPI: remove extraneous white space after semicolon
Date: Fri, 19 Aug 2016 17:24:01 -0600
Message-ID: <1471649042-19418-2-git-send-email-ahs3@redhat.com>
References: <1471649042-19418-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471649042-19418-1-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, trivial@kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Al Stone <ahs3@redhat.com>
---
 arch/x86/kernel/acpi/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 90d84c3..5fb8f05 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1513,7 +1513,7 @@ void __init acpi_boot_table_init(void)
 	 * If acpi_disabled, bail out
 	 */
 	if (acpi_disabled)
-		return; 
+		return;
 
 	/*
 	 * Initialize the ACPI boot-time table parser.
-- 
2.7.4
