From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 2/3] intel_idle, Introduce cstate limits and fix hardware cstate disable value
Date: Mon, 21 Mar 2016 08:49:28 -0400
Message-ID: <1458564569-19672-3-git-send-email-prarit@redhat.com>
References: <1458564569-19672-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755912AbcCUMtg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Mar 2016 08:49:36 -0400
In-Reply-To: <1458564569-19672-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, x86@kernel.org, Len Brown <lenb@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, linux-pm@vger.kernel.org

Some Skylake Intel i7-6700HQ processors have cstates limited by
MSR_PKG_CST_CONFIG_CONTROL (0xE2), which specifies the lowest
processor-specific C-state code name (consuming the least power).  The
intel_idle driver does not query this MSR to see if states are limited by
hardware.  In the case of the i7-6700HQ the value of bits 3:0 on the MSR
are 0x6, meaning that C9-SKL (0x7) and C10-SKL (0x8) should have been
disabled.

This patch adds a limit field to the cpuidle_state struct to hold the
cstate encodings for each processor, and queries the values the values
to confirm support.

After applying this patch the Skylake-H system now boots and reports that
some states have been disabled:

[root@dhcp40-125 ~]# dmesg | grep intel_idle
[    1.163367] intel_idle: MWAIT substates: 0x11142120
[    1.163368] intel_idle: v0.4 model 0x5E
[    1.163369] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.163370] intel_idle: state C9-SKL (0x7) is disabled.  Max Package limit is 0x6.
[    1.163371] intel_idle: state C10-SKL (0x8) is disabled.  Max Package limit is 0x6.

[root@dhcp40-125 ~]# egrep ^ /sys/devices/system/cpu/cpu0/cpuidle/state?/disable
/sys/devices/system/cpu/cpu0/cpuidle/state0/disable:1:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/disable:1:0
/sys/devices/system/cpu/cpu0/cpuidle/state2/disable:1:0
/sys/devices/system/cpu/cpu0/cpuidle/state3/disable:1:0
/sys/devices/system/cpu/cpu0/cpuidle/state4/disable:1:0
/sys/devices/system/cpu/cpu0/cpuidle/state5/disable:1:0
/sys/devices/system/cpu/cpu0/cpuidle/state6/disable:1:0
/sys/devices/system/cpu/cpu0/cpuidle/state7/disable:1:1
/sys/devices/system/cpu/cpu0/cpuidle/state8/disable:1:1

The cstate encodings were determined from the Intel SDM [1].

[1] http://www.intel.com/content/www/us/en/processors/architectures-software-developer-manuals.html

Cc: x86@kernel.org
Cc: Len Brown <lenb@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/idle/intel_idle.c |   87 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h   |    1 +
 2 files changed, 88 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 2609dff..58bc913 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -130,6 +130,7 @@ static struct cpuidle_state nehalem_cstates[] = {
 	{
 		.name = "C1-NHM",
 		.desc = "MWAIT 0x00",
+		.limit = 0x1,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 3,
 		.target_residency = 6,
@@ -138,6 +139,7 @@ static struct cpuidle_state nehalem_cstates[] = {
 	{
 		.name = "C1E-NHM",
 		.desc = "MWAIT 0x01",
+		.limit = 0x1,
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
@@ -146,6 +148,7 @@ static struct cpuidle_state nehalem_cstates[] = {
 	{
 		.name = "C3-NHM",
 		.desc = "MWAIT 0x10",
+		.limit = 0x2,
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 20,
 		.target_residency = 80,
@@ -154,6 +157,7 @@ static struct cpuidle_state nehalem_cstates[] = {
 	{
 		.name = "C6-NHM",
 		.desc = "MWAIT 0x20",
+		.limit = 0x3,
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
 		.target_residency = 800,
@@ -167,6 +171,7 @@ static struct cpuidle_state snb_cstates[] = {
 	{
 		.name = "C1-SNB",
 		.desc = "MWAIT 0x00",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
@@ -175,6 +180,7 @@ static struct cpuidle_state snb_cstates[] = {
 	{
 		.name = "C1E-SNB",
 		.desc = "MWAIT 0x01",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
@@ -183,6 +189,7 @@ static struct cpuidle_state snb_cstates[] = {
 	{
 		.name = "C3-SNB",
 		.desc = "MWAIT 0x10",
+		.limit = 0x7, /* cannot limit to C3 */
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 211,
@@ -191,6 +198,7 @@ static struct cpuidle_state snb_cstates[] = {
 	{
 		.name = "C6-SNB",
 		.desc = "MWAIT 0x20",
+		.limit = 0x2,
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 104,
 		.target_residency = 345,
@@ -199,6 +207,7 @@ static struct cpuidle_state snb_cstates[] = {
 	{
 		.name = "C7-SNB",
 		.desc = "MWAIT 0x30",
+		.limit = 0x4,
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 109,
 		.target_residency = 345,
@@ -212,6 +221,7 @@ static struct cpuidle_state byt_cstates[] = {
 	{
 		.name = "C1-BYT",
 		.desc = "MWAIT 0x00",
+		.limit = 0x1,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
@@ -220,6 +230,7 @@ static struct cpuidle_state byt_cstates[] = {
 	{
 		.name = "C6N-BYT",
 		.desc = "MWAIT 0x58",
+		.limit = 0x6,
 		.flags = MWAIT2flg(0x58) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
 		.target_residency = 275,
@@ -229,6 +240,7 @@ static struct cpuidle_state byt_cstates[] = {
 		.name = "C6S-BYT",
 		.desc = "MWAIT 0x52",
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.limit = 0x6,
 		.exit_latency = 500,
 		.target_residency = 560,
 		.enter = &intel_idle,
@@ -236,6 +248,7 @@ static struct cpuidle_state byt_cstates[] = {
 	{
 		.name = "C7-BYT",
 		.desc = "MWAIT 0x60",
+		.limit = 0x7,
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1200,
 		.target_residency = 4000,
@@ -244,6 +257,7 @@ static struct cpuidle_state byt_cstates[] = {
 	{
 		.name = "C7S-BYT",
 		.desc = "MWAIT 0x64",
+		.limit = 0x7,
 		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
 		.target_residency = 20000,
@@ -257,6 +271,7 @@ static struct cpuidle_state cht_cstates[] = {
 	{
 		.name = "C1-CHT",
 		.desc = "MWAIT 0x00",
+		.limit = 0x1,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
@@ -265,6 +280,7 @@ static struct cpuidle_state cht_cstates[] = {
 	{
 		.name = "C6N-CHT",
 		.desc = "MWAIT 0x58",
+		.limit = 0x6,
 		.flags = MWAIT2flg(0x58) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 275,
@@ -273,6 +289,7 @@ static struct cpuidle_state cht_cstates[] = {
 	{
 		.name = "C6S-CHT",
 		.desc = "MWAIT 0x52",
+		.limit = 0x6,
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
 		.target_residency = 560,
@@ -281,6 +298,7 @@ static struct cpuidle_state cht_cstates[] = {
 	{
 		.name = "C7-CHT",
 		.desc = "MWAIT 0x60",
+		.limit = 0x7,
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1200,
 		.target_residency = 4000,
@@ -289,6 +307,7 @@ static struct cpuidle_state cht_cstates[] = {
 	{
 		.name = "C7S-CHT",
 		.desc = "MWAIT 0x64",
+		.limit = 0x7,
 		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
 		.target_residency = 20000,
@@ -302,6 +321,7 @@ static struct cpuidle_state ivb_cstates[] = {
 	{
 		.name = "C1-IVB",
 		.desc = "MWAIT 0x00",
+		.limit = 0x1,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
@@ -310,6 +330,7 @@ static struct cpuidle_state ivb_cstates[] = {
 	{
 		.name = "C1E-IVB",
 		.desc = "MWAIT 0x01",
+		.limit = 0x1,
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
@@ -318,6 +339,7 @@ static struct cpuidle_state ivb_cstates[] = {
 	{
 		.name = "C3-IVB",
 		.desc = "MWAIT 0x10",
+		.limit = 0x2,
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 156,
@@ -326,6 +348,7 @@ static struct cpuidle_state ivb_cstates[] = {
 	{
 		.name = "C6-IVB",
 		.desc = "MWAIT 0x20",
+		.limit = 0x3,
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 300,
@@ -334,6 +357,7 @@ static struct cpuidle_state ivb_cstates[] = {
 	{
 		.name = "C7-IVB",
 		.desc = "MWAIT 0x30",
+		.limit = 0x4,
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 87,
 		.target_residency = 300,
@@ -347,6 +371,7 @@ static struct cpuidle_state ivt_cstates[] = {
 	{
 		.name = "C1-IVT",
 		.desc = "MWAIT 0x00",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
@@ -355,6 +380,7 @@ static struct cpuidle_state ivt_cstates[] = {
 	{
 		.name = "C1E-IVT",
 		.desc = "MWAIT 0x01",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 80,
@@ -363,6 +389,7 @@ static struct cpuidle_state ivt_cstates[] = {
 	{
 		.name = "C3-IVT",
 		.desc = "MWAIT 0x10",
+		.limit = 0x7, /* cannot limit to C3 */
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 156,
@@ -371,6 +398,7 @@ static struct cpuidle_state ivt_cstates[] = {
 	{
 		.name = "C6-IVT",
 		.desc = "MWAIT 0x20",
+		.limit = 0x3,
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 82,
 		.target_residency = 300,
@@ -384,6 +412,7 @@ static struct cpuidle_state ivt_cstates_4s[] = {
 	{
 		.name = "C1-IVT-4S",
 		.desc = "MWAIT 0x00",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
@@ -392,6 +421,7 @@ static struct cpuidle_state ivt_cstates_4s[] = {
 	{
 		.name = "C1E-IVT-4S",
 		.desc = "MWAIT 0x01",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 250,
@@ -400,6 +430,7 @@ static struct cpuidle_state ivt_cstates_4s[] = {
 	{
 		.name = "C3-IVT-4S",
 		.desc = "MWAIT 0x10",
+		.limit = 0x7, /* cannot limit to C3 */
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 300,
@@ -408,6 +439,7 @@ static struct cpuidle_state ivt_cstates_4s[] = {
 	{
 		.name = "C6-IVT-4S",
 		.desc = "MWAIT 0x20",
+		.limit = 0x3,
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 84,
 		.target_residency = 400,
@@ -421,6 +453,7 @@ static struct cpuidle_state ivt_cstates_8s[] = {
 	{
 		.name = "C1-IVT-8S",
 		.desc = "MWAIT 0x00",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
@@ -429,6 +462,7 @@ static struct cpuidle_state ivt_cstates_8s[] = {
 	{
 		.name = "C1E-IVT-8S",
 		.desc = "MWAIT 0x01",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 500,
@@ -437,6 +471,7 @@ static struct cpuidle_state ivt_cstates_8s[] = {
 	{
 		.name = "C3-IVT-8S",
 		.desc = "MWAIT 0x10",
+		.limit = 0x7, /* cannot limit to C3 */
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 600,
@@ -445,6 +480,7 @@ static struct cpuidle_state ivt_cstates_8s[] = {
 	{
 		.name = "C6-IVT-8S",
 		.desc = "MWAIT 0x20",
+		.limit = 0x3,
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 88,
 		.target_residency = 700,
@@ -458,6 +494,7 @@ static struct cpuidle_state hsw_cstates[] = {
 	{
 		.name = "C1-HSW",
 		.desc = "MWAIT 0x00",
+		.limit = 0x1,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
@@ -466,6 +503,7 @@ static struct cpuidle_state hsw_cstates[] = {
 	{
 		.name = "C1E-HSW",
 		.desc = "MWAIT 0x01",
+		.limit = 0x1,
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
@@ -474,6 +512,7 @@ static struct cpuidle_state hsw_cstates[] = {
 	{
 		.name = "C3-HSW",
 		.desc = "MWAIT 0x10",
+		.limit = 0x7, /* cannot limit to C3 */
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 33,
 		.target_residency = 100,
@@ -482,6 +521,7 @@ static struct cpuidle_state hsw_cstates[] = {
 	{
 		.name = "C6-HSW",
 		.desc = "MWAIT 0x20",
+		.limit = 0x3,
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
 		.target_residency = 400,
@@ -490,6 +530,7 @@ static struct cpuidle_state hsw_cstates[] = {
 	{
 		.name = "C7s-HSW",
 		.desc = "MWAIT 0x32",
+		.limit = 0x4,
 		.flags = MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 166,
 		.target_residency = 500,
@@ -498,6 +539,7 @@ static struct cpuidle_state hsw_cstates[] = {
 	{
 		.name = "C8-HSW",
 		.desc = "MWAIT 0x40",
+		.limit = 0x6,
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
 		.target_residency = 900,
@@ -506,6 +548,7 @@ static struct cpuidle_state hsw_cstates[] = {
 	{
 		.name = "C9-HSW",
 		.desc = "MWAIT 0x50",
+		.limit = 0x7,
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 600,
 		.target_residency = 1800,
@@ -514,6 +557,7 @@ static struct cpuidle_state hsw_cstates[] = {
 	{
 		.name = "C10-HSW",
 		.desc = "MWAIT 0x60",
+		.limit = 0x8,
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2600,
 		.target_residency = 7700,
@@ -526,6 +570,7 @@ static struct cpuidle_state bdw_cstates[] = {
 	{
 		.name = "C1-BDW",
 		.desc = "MWAIT 0x00",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
@@ -534,6 +579,7 @@ static struct cpuidle_state bdw_cstates[] = {
 	{
 		.name = "C1E-BDW",
 		.desc = "MWAIT 0x01",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
@@ -542,6 +588,7 @@ static struct cpuidle_state bdw_cstates[] = {
 	{
 		.name = "C3-BDW",
 		.desc = "MWAIT 0x10",
+		.limit = 0x2,
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 40,
 		.target_residency = 100,
@@ -550,6 +597,7 @@ static struct cpuidle_state bdw_cstates[] = {
 	{
 		.name = "C6-BDW",
 		.desc = "MWAIT 0x20",
+		.limit = 0x3,
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
 		.target_residency = 400,
@@ -558,6 +606,7 @@ static struct cpuidle_state bdw_cstates[] = {
 	{
 		.name = "C7s-BDW",
 		.desc = "MWAIT 0x32",
+		.limit = 0x5,
 		.flags = MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 166,
 		.target_residency = 500,
@@ -566,6 +615,7 @@ static struct cpuidle_state bdw_cstates[] = {
 	{
 		.name = "C8-BDW",
 		.desc = "MWAIT 0x40",
+		.limit = 0x6,
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
 		.target_residency = 900,
@@ -574,6 +624,7 @@ static struct cpuidle_state bdw_cstates[] = {
 	{
 		.name = "C9-BDW",
 		.desc = "MWAIT 0x50",
+		.limit = 0x7,
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 600,
 		.target_residency = 1800,
@@ -582,6 +633,7 @@ static struct cpuidle_state bdw_cstates[] = {
 	{
 		.name = "C10-BDW",
 		.desc = "MWAIT 0x60",
+		.limit = 0x8,
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2600,
 		.target_residency = 7700,
@@ -595,6 +647,7 @@ static struct cpuidle_state skl_cstates[] = {
 	{
 		.name = "C1-SKL",
 		.desc = "MWAIT 0x00",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
@@ -603,6 +656,7 @@ static struct cpuidle_state skl_cstates[] = {
 	{
 		.name = "C1E-SKL",
 		.desc = "MWAIT 0x01",
+		.limit = 0x0,
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
@@ -611,6 +665,7 @@ static struct cpuidle_state skl_cstates[] = {
 	{
 		.name = "C3-SKL",
 		.desc = "MWAIT 0x10",
+		.limit = 0x2,
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 70,
 		.target_residency = 100,
@@ -619,6 +674,7 @@ static struct cpuidle_state skl_cstates[] = {
 	{
 		.name = "C6-SKL",
 		.desc = "MWAIT 0x20",
+		.limit = 0x3,
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 85,
 		.target_residency = 200,
@@ -627,6 +683,7 @@ static struct cpuidle_state skl_cstates[] = {
 	{
 		.name = "C7s-SKL",
 		.desc = "MWAIT 0x33",
+		.limit = 0x5,
 		.flags = MWAIT2flg(0x33) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 124,
 		.target_residency = 800,
@@ -635,6 +692,7 @@ static struct cpuidle_state skl_cstates[] = {
 	{
 		.name = "C8-SKL",
 		.desc = "MWAIT 0x40",
+		.limit = 0x6,
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
 		.target_residency = 800,
@@ -643,6 +701,7 @@ static struct cpuidle_state skl_cstates[] = {
 	{
 		.name = "C9-SKL",
 		.desc = "MWAIT 0x50",
+		.limit = 0x7,
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 480,
 		.target_residency = 5000,
@@ -651,6 +710,7 @@ static struct cpuidle_state skl_cstates[] = {
 	{
 		.name = "C10-SKL",
 		.desc = "MWAIT 0x60",
+		.limit = 0x8,
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 890,
 		.target_residency = 5000,
@@ -664,6 +724,7 @@ static struct cpuidle_state atom_cstates[] = {
 	{
 		.name = "C1E-ATM",
 		.desc = "MWAIT 0x00",
+		.limit = 0x1,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 10,
 		.target_residency = 20,
@@ -672,6 +733,7 @@ static struct cpuidle_state atom_cstates[] = {
 	{
 		.name = "C2-ATM",
 		.desc = "MWAIT 0x10",
+		.limit = 0x7, /* undefined */
 		.flags = MWAIT2flg(0x10),
 		.exit_latency = 20,
 		.target_residency = 80,
@@ -680,6 +742,7 @@ static struct cpuidle_state atom_cstates[] = {
 	{
 		.name = "C4-ATM",
 		.desc = "MWAIT 0x30",
+		.limit = 0x4,
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 100,
 		.target_residency = 400,
@@ -688,6 +751,7 @@ static struct cpuidle_state atom_cstates[] = {
 	{
 		.name = "C6-ATM",
 		.desc = "MWAIT 0x52",
+		.limit = 0x5,
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
 		.target_residency = 560,
@@ -700,6 +764,7 @@ static struct cpuidle_state avn_cstates[] = {
 	{
 		.name = "C1-AVN",
 		.desc = "MWAIT 0x00",
+		.limit = 0x1,
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
@@ -708,6 +773,7 @@ static struct cpuidle_state avn_cstates[] = {
 	{
 		.name = "C6-AVN",
 		.desc = "MWAIT 0x51",
+		.limit = 0x5,
 		.flags = MWAIT2flg(0x51) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 15,
 		.target_residency = 45,
@@ -1034,11 +1100,22 @@ static int __init intel_idle_cpuidle_driver_init(void)
 {
 	int cstate;
 	struct cpuidle_driver *drv = &intel_idle_driver;
+	u64 msr;
+	unsigned int limit;
 
 	intel_idle_state_table_update();
 
 	drv->state_count = 1;
 
+	rdmsrl_on_cpu(0, MSR_PKG_CST_CONFIG_CONTROL, &msr);
+	/*
+	 * Older processors use bits 2:0 and have bits 9:3 reserved.
+	 * Newer processors use bits 3:0 and have bits 9:4 reserved.
+	 * It looks safe to use bits 3:0 everywhere as a mask, as
+	 * bit 3 on older processors is always zero.
+	 */
+	limit = msr & 0xF;
+
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
 		int num_substates, mwait_hint, mwait_cstate;
 
@@ -1063,6 +1140,16 @@ static int __init intel_idle_cpuidle_driver_init(void)
 		if (num_substates == 0)
 			continue;
 
+		/* Has this state been disabled in hardware? */
+		if (limit < cpuidle_state_table[cstate].limit) {
+			cpuidle_state_table[cstate].disabled = 1;
+			pr_debug(PREFIX "state %s (0x%x) is disabled.  Max Package limit is 0x%x.\n",
+				 cpuidle_state_table[cstate].name,
+				 cpuidle_state_table[cstate].limit,
+				 limit);
+
+		}
+
 		if (((mwait_cstate + 1) > 2) &&
 			!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 			mark_tsc_unstable("TSC halts in idle"
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 786ad32..8bcfabb 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -39,6 +39,7 @@ struct cpuidle_state {
 	char		name[CPUIDLE_NAME_LEN];
 	char		desc[CPUIDLE_DESC_LEN];
 
+	unsigned int	limit; /* compared to Package C-state Limit */
 	unsigned int	flags;
 	unsigned int	exit_latency; /* in US */
 	int		power_usage; /* in mW */
-- 
1.7.9.3

