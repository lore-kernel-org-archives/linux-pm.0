From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] PM: declare __tracedata symbols as char[] rather than char
Date: Sun, 24 Jan 2016 20:08:52 -0600
Message-ID: <1453687732-1602-1-git-send-email-ebiggers3@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38060 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbcAYCJc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jan 2016 21:09:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>

Accessing more than one byte from a symbol declared simply 'char' is undefined
behavior, as reported by UBSAN:

	UBSAN: Undefined behaviour in drivers/base/power/trace.c:178:18
	load of address ffffffff8203fc78 with insufficient space
	for an object of type 'char'

Avoid this by declaring the symbols as arrays.

Signed-off-by: Eric Biggers <ebiggers3@gmail.com>
---
 drivers/base/power/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index a311cfa..a697579 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -166,14 +166,14 @@ void generate_pm_trace(const void *tracedata, unsigned int user)
 }
 EXPORT_SYMBOL(generate_pm_trace);
 
-extern char __tracedata_start, __tracedata_end;
+extern char __tracedata_start[], __tracedata_end[];
 static int show_file_hash(unsigned int value)
 {
 	int match;
 	char *tracedata;
 
 	match = 0;
-	for (tracedata = &__tracedata_start ; tracedata < &__tracedata_end ;
+	for (tracedata = __tracedata_start ; tracedata < __tracedata_end ;
 			tracedata += 2 + sizeof(unsigned long)) {
 		unsigned short lineno = *(unsigned short *)tracedata;
 		const char *file = *(const char **)(tracedata + 2);
-- 
2.7.0

