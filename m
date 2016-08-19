From: Al Stone <ahs3@redhat.com>
Subject: [PATCH 0/2] minor x86 PM source file cleanup
Date: Fri, 19 Aug 2016 17:24:00 -0600
Message-ID: <1471649042-19418-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754491AbcHSXYG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Aug 2016 19:24:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, trivial@kernel.org

Really minor patches: one to cleanup whitespace, the second just makes
the code a wee bit more maintainable by correcting some variable names
without changing functionality.

Al Stone (2):
  x86: ACPI: remove extraneous white space after semicolon
  x86: ACPI: make variable names clearer in
    acpi_parse_madt_lapic_entries()

 arch/x86/kernel/acpi/boot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4

