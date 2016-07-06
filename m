From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / hibernate: Add missing braces in hibernate_setup()
Date: Wed, 06 Jul 2016 02:40:56 +0200
Message-ID: <1591633.3ATZ6IOsAy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60809 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751157AbcGFAgW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2016 20:36:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make hibernate_setup() follow the coding style more closely by adding
some missing braces to the if () statement in it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is on top of https://patchwork.kernel.org/patch/9214179/

---
 kernel/power/hibernate.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -1119,11 +1119,11 @@ static int __init resume_offset_setup(ch
 
 static int __init hibernate_setup(char *str)
 {
-	if (!strncmp(str, "noresume", 8))
+	if (!strncmp(str, "noresume", 8)) {
 		noresume = 1;
-	else if (!strncmp(str, "nocompress", 10))
+	} else if (!strncmp(str, "nocompress", 10)) {
 		nocompress = 1;
-	else if (!strncmp(str, "no", 2)) {
+	} else if (!strncmp(str, "no", 2)) {
 		noresume = 1;
 		nohibernate = 1;
 	} else if (!strncmp(str, "protect_image", 13)) {

