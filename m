From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/3] intel_idle: mark states tables with __initdata tag
Date: Fri, 30 Aug 2013 12:26:42 +0200
Message-ID: <3627555.yC4BdJJnVe@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52617 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab3H3K0t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Aug 2013 06:26:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

States tables are only accessed during driver initialization so they
can be marked with __initdata tag.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/idle/intel_idle.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9c97fbb42..53b24f1 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -123,7 +123,7 @@ static struct cpuidle_state *cpuidle_state_table;
  * which is also the index into the MWAIT hint array.
  * Thus C0 is a dummy.
  */
-static struct cpuidle_state nehalem_cstates[] = {
+static struct cpuidle_state nehalem_cstates[] __initdata = {
 	{
 		.name = "C1-NHM",
 		.desc = "MWAIT 0x00",
@@ -156,7 +156,7 @@ static struct cpuidle_state nehalem_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state snb_cstates[] = {
+static struct cpuidle_state snb_cstates[] __initdata = {
 	{
 		.name = "C1-SNB",
 		.desc = "MWAIT 0x00",
@@ -196,7 +196,7 @@ static struct cpuidle_state snb_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state ivb_cstates[] = {
+static struct cpuidle_state ivb_cstates[] __initdata = {
 	{
 		.name = "C1-IVB",
 		.desc = "MWAIT 0x00",
@@ -236,7 +236,7 @@ static struct cpuidle_state ivb_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state hsw_cstates[] = {
+static struct cpuidle_state hsw_cstates[] __initdata = {
 	{
 		.name = "C1-HSW",
 		.desc = "MWAIT 0x00",
@@ -297,7 +297,7 @@ static struct cpuidle_state hsw_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state atom_cstates[] = {
+static struct cpuidle_state atom_cstates[] __initdata = {
 	{
 		.name = "C1E-ATM",
 		.desc = "MWAIT 0x00",
-- 
1.8.2.3


