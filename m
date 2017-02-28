From: Len Brown <lenb@kernel.org>
Subject: [PATCH] intel_idle: stop exposing platform acronyms in sysfs
Date: Tue, 28 Feb 2017 16:32:44 -0500
Message-ID: <c76f694bed60071096502e065313726e399df563.1488317499.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Renninger <trenn@suse.de>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Cosmetic only -- no functional change in this patch.

sysfs before:

state4/desc:MWAIT 0x20
state4/name:C6-HSW

sysfs after:

state4/desc:MWAIT 0x20
state4/name:C6

We remove the platform acronyms from the end of the state name
(-HSW in this case) for three reasonse.

1. more consistency with acpi_idle, which prints C1, C2, C3 etc.

2. users know what platform they are on already
   an acronym for the processor code name here
   seems to cause more confusion than clarity.

3. less clutter in "cpupower monitor" output,
   which truncates the names to 4 columns.

The precise definition of the state continues to be available in "desc".

Cc: Thomas Renninger <trenn@suse.de>
Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 172 +++++++++++++++++++++++-----------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 7d8ea3d5fda6..e045a5caa5bb 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -125,7 +125,7 @@ static struct cpuidle_state *cpuidle_state_table;
  */
 static struct cpuidle_state nehalem_cstates[] = {
 	{
-		.name = "C1-NHM",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 3,
@@ -133,7 +133,7 @@ static struct cpuidle_state nehalem_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-NHM",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -141,7 +141,7 @@ static struct cpuidle_state nehalem_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C3-NHM",
+		.name = "C3",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 20,
@@ -149,7 +149,7 @@ static struct cpuidle_state nehalem_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-NHM",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
@@ -162,7 +162,7 @@ static struct cpuidle_state nehalem_cstates[] = {
 
 static struct cpuidle_state snb_cstates[] = {
 	{
-		.name = "C1-SNB",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
@@ -170,7 +170,7 @@ static struct cpuidle_state snb_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-SNB",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -178,7 +178,7 @@ static struct cpuidle_state snb_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C3-SNB",
+		.name = "C3",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
@@ -186,7 +186,7 @@ static struct cpuidle_state snb_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-SNB",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 104,
@@ -194,7 +194,7 @@ static struct cpuidle_state snb_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C7-SNB",
+		.name = "C7",
 		.desc = "MWAIT 0x30",
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 109,
@@ -207,7 +207,7 @@ static struct cpuidle_state snb_cstates[] = {
 
 static struct cpuidle_state byt_cstates[] = {
 	{
-		.name = "C1-BYT",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
@@ -215,7 +215,7 @@ static struct cpuidle_state byt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6N-BYT",
+		.name = "C6N",
 		.desc = "MWAIT 0x58",
 		.flags = MWAIT2flg(0x58) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
@@ -223,7 +223,7 @@ static struct cpuidle_state byt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6S-BYT",
+		.name = "C6S",
 		.desc = "MWAIT 0x52",
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 500,
@@ -231,7 +231,7 @@ static struct cpuidle_state byt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C7-BYT",
+		.name = "C7",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1200,
@@ -239,7 +239,7 @@ static struct cpuidle_state byt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C7S-BYT",
+		.name = "C7S",
 		.desc = "MWAIT 0x64",
 		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
@@ -252,7 +252,7 @@ static struct cpuidle_state byt_cstates[] = {
 
 static struct cpuidle_state cht_cstates[] = {
 	{
-		.name = "C1-CHT",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
@@ -260,7 +260,7 @@ static struct cpuidle_state cht_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6N-CHT",
+		.name = "C6N",
 		.desc = "MWAIT 0x58",
 		.flags = MWAIT2flg(0x58) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
@@ -268,7 +268,7 @@ static struct cpuidle_state cht_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6S-CHT",
+		.name = "C6S",
 		.desc = "MWAIT 0x52",
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
@@ -276,7 +276,7 @@ static struct cpuidle_state cht_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C7-CHT",
+		.name = "C7",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1200,
@@ -284,7 +284,7 @@ static struct cpuidle_state cht_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C7S-CHT",
+		.name = "C7S",
 		.desc = "MWAIT 0x64",
 		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
@@ -297,7 +297,7 @@ static struct cpuidle_state cht_cstates[] = {
 
 static struct cpuidle_state ivb_cstates[] = {
 	{
-		.name = "C1-IVB",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
@@ -305,7 +305,7 @@ static struct cpuidle_state ivb_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-IVB",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -313,7 +313,7 @@ static struct cpuidle_state ivb_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C3-IVB",
+		.name = "C3",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
@@ -321,7 +321,7 @@ static struct cpuidle_state ivb_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-IVB",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
@@ -329,7 +329,7 @@ static struct cpuidle_state ivb_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C7-IVB",
+		.name = "C7",
 		.desc = "MWAIT 0x30",
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 87,
@@ -342,7 +342,7 @@ static struct cpuidle_state ivb_cstates[] = {
 
 static struct cpuidle_state ivt_cstates[] = {
 	{
-		.name = "C1-IVT",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
@@ -350,7 +350,7 @@ static struct cpuidle_state ivt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-IVT",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -358,7 +358,7 @@ static struct cpuidle_state ivt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C3-IVT",
+		.name = "C3",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
@@ -366,7 +366,7 @@ static struct cpuidle_state ivt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-IVT",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 82,
@@ -379,7 +379,7 @@ static struct cpuidle_state ivt_cstates[] = {
 
 static struct cpuidle_state ivt_cstates_4s[] = {
 	{
-		.name = "C1-IVT-4S",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
@@ -387,7 +387,7 @@ static struct cpuidle_state ivt_cstates_4s[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-IVT-4S",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -395,7 +395,7 @@ static struct cpuidle_state ivt_cstates_4s[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C3-IVT-4S",
+		.name = "C3",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
@@ -403,7 +403,7 @@ static struct cpuidle_state ivt_cstates_4s[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-IVT-4S",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 84,
@@ -416,7 +416,7 @@ static struct cpuidle_state ivt_cstates_4s[] = {
 
 static struct cpuidle_state ivt_cstates_8s[] = {
 	{
-		.name = "C1-IVT-8S",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
@@ -424,7 +424,7 @@ static struct cpuidle_state ivt_cstates_8s[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-IVT-8S",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -432,7 +432,7 @@ static struct cpuidle_state ivt_cstates_8s[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C3-IVT-8S",
+		.name = "C3",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
@@ -440,7 +440,7 @@ static struct cpuidle_state ivt_cstates_8s[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-IVT-8S",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 88,
@@ -453,7 +453,7 @@ static struct cpuidle_state ivt_cstates_8s[] = {
 
 static struct cpuidle_state hsw_cstates[] = {
 	{
-		.name = "C1-HSW",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
@@ -461,7 +461,7 @@ static struct cpuidle_state hsw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-HSW",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -469,7 +469,7 @@ static struct cpuidle_state hsw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C3-HSW",
+		.name = "C3",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 33,
@@ -477,7 +477,7 @@ static struct cpuidle_state hsw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-HSW",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
@@ -485,7 +485,7 @@ static struct cpuidle_state hsw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C7s-HSW",
+		.name = "C7s",
 		.desc = "MWAIT 0x32",
 		.flags = MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 166,
@@ -493,7 +493,7 @@ static struct cpuidle_state hsw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C8-HSW",
+		.name = "C8",
 		.desc = "MWAIT 0x40",
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
@@ -501,7 +501,7 @@ static struct cpuidle_state hsw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C9-HSW",
+		.name = "C9",
 		.desc = "MWAIT 0x50",
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 600,
@@ -509,7 +509,7 @@ static struct cpuidle_state hsw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C10-HSW",
+		.name = "C10",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2600,
@@ -521,7 +521,7 @@ static struct cpuidle_state hsw_cstates[] = {
 };
 static struct cpuidle_state bdw_cstates[] = {
 	{
-		.name = "C1-BDW",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
@@ -529,7 +529,7 @@ static struct cpuidle_state bdw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-BDW",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -537,7 +537,7 @@ static struct cpuidle_state bdw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C3-BDW",
+		.name = "C3",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 40,
@@ -545,7 +545,7 @@ static struct cpuidle_state bdw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-BDW",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
@@ -553,7 +553,7 @@ static struct cpuidle_state bdw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C7s-BDW",
+		.name = "C7s",
 		.desc = "MWAIT 0x32",
 		.flags = MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 166,
@@ -561,7 +561,7 @@ static struct cpuidle_state bdw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C8-BDW",
+		.name = "C8",
 		.desc = "MWAIT 0x40",
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
@@ -569,7 +569,7 @@ static struct cpuidle_state bdw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C9-BDW",
+		.name = "C9",
 		.desc = "MWAIT 0x50",
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 600,
@@ -577,7 +577,7 @@ static struct cpuidle_state bdw_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C10-BDW",
+		.name = "C10",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2600,
@@ -590,7 +590,7 @@ static struct cpuidle_state bdw_cstates[] = {
 
 static struct cpuidle_state skl_cstates[] = {
 	{
-		.name = "C1-SKL",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
@@ -598,7 +598,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-SKL",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -606,7 +606,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C3-SKL",
+		.name = "C3",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 70,
@@ -614,7 +614,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-SKL",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 85,
@@ -622,7 +622,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C7s-SKL",
+		.name = "C7s",
 		.desc = "MWAIT 0x33",
 		.flags = MWAIT2flg(0x33) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 124,
@@ -630,7 +630,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C8-SKL",
+		.name = "C8",
 		.desc = "MWAIT 0x40",
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
@@ -638,7 +638,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C9-SKL",
+		.name = "C9",
 		.desc = "MWAIT 0x50",
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 480,
@@ -646,7 +646,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C10-SKL",
+		.name = "C10",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 890,
@@ -659,7 +659,7 @@ static struct cpuidle_state skl_cstates[] = {
 
 static struct cpuidle_state skx_cstates[] = {
 	{
-		.name = "C1-SKX",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
@@ -667,7 +667,7 @@ static struct cpuidle_state skx_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-SKX",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -675,7 +675,7 @@ static struct cpuidle_state skx_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-SKX",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
@@ -688,7 +688,7 @@ static struct cpuidle_state skx_cstates[] = {
 
 static struct cpuidle_state atom_cstates[] = {
 	{
-		.name = "C1E-ATM",
+		.name = "C1E",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 10,
@@ -696,7 +696,7 @@ static struct cpuidle_state atom_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C2-ATM",
+		.name = "C2",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10),
 		.exit_latency = 20,
@@ -704,7 +704,7 @@ static struct cpuidle_state atom_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C4-ATM",
+		.name = "C4",
 		.desc = "MWAIT 0x30",
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 100,
@@ -712,7 +712,7 @@ static struct cpuidle_state atom_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-ATM",
+		.name = "C6",
 		.desc = "MWAIT 0x52",
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
@@ -724,7 +724,7 @@ static struct cpuidle_state atom_cstates[] = {
 };
 static struct cpuidle_state tangier_cstates[] = {
 	{
-		.name = "C1-TNG",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
@@ -732,7 +732,7 @@ static struct cpuidle_state tangier_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C4-TNG",
+		.name = "C4",
 		.desc = "MWAIT 0x30",
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 100,
@@ -740,7 +740,7 @@ static struct cpuidle_state tangier_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-TNG",
+		.name = "C6",
 		.desc = "MWAIT 0x52",
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
@@ -748,7 +748,7 @@ static struct cpuidle_state tangier_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C7-TNG",
+		.name = "C7",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1200,
@@ -756,7 +756,7 @@ static struct cpuidle_state tangier_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C9-TNG",
+		.name = "C9",
 		.desc = "MWAIT 0x64",
 		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
@@ -768,7 +768,7 @@ static struct cpuidle_state tangier_cstates[] = {
 };
 static struct cpuidle_state avn_cstates[] = {
 	{
-		.name = "C1-AVN",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
@@ -776,7 +776,7 @@ static struct cpuidle_state avn_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-AVN",
+		.name = "C6",
 		.desc = "MWAIT 0x51",
 		.flags = MWAIT2flg(0x51) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 15,
@@ -788,7 +788,7 @@ static struct cpuidle_state avn_cstates[] = {
 };
 static struct cpuidle_state knl_cstates[] = {
 	{
-		.name = "C1-KNL",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
@@ -796,7 +796,7 @@ static struct cpuidle_state knl_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze },
 	{
-		.name = "C6-KNL",
+		.name = "C6",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 120,
@@ -809,7 +809,7 @@ static struct cpuidle_state knl_cstates[] = {
 
 static struct cpuidle_state bxt_cstates[] = {
 	{
-		.name = "C1-BXT",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
@@ -817,7 +817,7 @@ static struct cpuidle_state bxt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-BXT",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -825,7 +825,7 @@ static struct cpuidle_state bxt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-BXT",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
@@ -833,7 +833,7 @@ static struct cpuidle_state bxt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C7s-BXT",
+		.name = "C7s",
 		.desc = "MWAIT 0x31",
 		.flags = MWAIT2flg(0x31) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 155,
@@ -841,7 +841,7 @@ static struct cpuidle_state bxt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C8-BXT",
+		.name = "C8",
 		.desc = "MWAIT 0x40",
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1000,
@@ -849,7 +849,7 @@ static struct cpuidle_state bxt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C9-BXT",
+		.name = "C9",
 		.desc = "MWAIT 0x50",
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2000,
@@ -857,7 +857,7 @@ static struct cpuidle_state bxt_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C10-BXT",
+		.name = "C10",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
@@ -870,7 +870,7 @@ static struct cpuidle_state bxt_cstates[] = {
 
 static struct cpuidle_state dnv_cstates[] = {
 	{
-		.name = "C1-DNV",
+		.name = "C1",
 		.desc = "MWAIT 0x00",
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
@@ -878,7 +878,7 @@ static struct cpuidle_state dnv_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C1E-DNV",
+		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
@@ -886,7 +886,7 @@ static struct cpuidle_state dnv_cstates[] = {
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
-		.name = "C6-DNV",
+		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 50,
-- 
2.11.0.161.g6610af872
