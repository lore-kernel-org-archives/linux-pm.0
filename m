Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A3FECAAD2
	for <linux-pm@archiver.kernel.org>; Mon, 29 Aug 2022 16:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiH2QMi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 29 Aug 2022 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH2QMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2022 12:12:37 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A673323;
        Mon, 29 Aug 2022 09:12:36 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 25f68f9ee1e36123; Mon, 29 Aug 2022 18:12:34 +0200
Received: from kreacher.localnet (public-gprs523165.centertel.pl [31.61.162.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0945C66D25F;
        Mon, 29 Aug 2022 18:12:34 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1] ACPI: property: Use acpi_dev_parent()
Date:   Mon, 29 Aug 2022 18:12:33 +0200
Message-ID: <4756666.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 31.61.162.222
X-CLIENT-HOSTNAME: public-gprs523165.centertel.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeefuddriedurdduiedvrddvvddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfedurdeiuddrudeivddrvddvvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdho
 rhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After introducing acpi_dev_parent() in commit 62fcb99bdf10 ("ACPI: Drop
parent field from struct acpi_device"), it is better to use it instead
of accessing the dev.parent field in struct acpi_device directly.

Modify acpi_node_get_parent() accordingly.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/property.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -1269,10 +1269,11 @@ acpi_node_get_parent(const struct fwnode
 		return to_acpi_data_node(fwnode)->parent;
 	}
 	if (is_acpi_device_node(fwnode)) {
-		struct device *dev = to_acpi_device_node(fwnode)->dev.parent;
+		struct acpi_device *parent;
 
-		if (dev)
-			return acpi_fwnode_handle(to_acpi_device(dev));
+		parent = acpi_dev_parent(to_acpi_device_node(fwnode));
+		if (parent)
+			return acpi_fwnode_handle(parent);
 	}
 
 	return NULL;



