From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: drivers/cpuidle/governors/menu.c:268:2: warning: comparison of
 distinct pointer types lacks a cast
Date: Tue, 23 Oct 2012 20:44:31 +0800
Message-ID: <20121023124431.GA17286@localhost>
References: <508610e6.lZq8SVXFvwZCcvw6%fengguang.wu@intel.com>
 <70A3B115BE79814398B8E4E7C4AE18EE138DCD@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53548 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399Ab2JWMof (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Oct 2012 08:44:35 -0400
Content-Disposition: inline
In-Reply-To: <70A3B115BE79814398B8E4E7C4AE18EE138DCD@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Song, Youquan" <youquan.song@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rik van Riel <riel@redhat.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

Youquan,

On Tue, Oct 23, 2012 at 07:23:00PM +0800, Song, Youquan wrote:
> Hi Fengguang,
> 
> Sorry. I built the kernel at 32bit OS RHEL6 i686 without any complain about it.
> Are you built it for sh architecture? by "make ARCH=sh sh7785lcr_32bit_defconfig", I do not know this architecture at all. Who can help me on it?

No worry. This is tested to remove the following warnings.

drivers/cpuidle/governors/menu.c: In function 'get_typical_interval':
drivers/cpuidle/governors/menu.c:268:2: warning: comparison of distinct pointer types lacks a cast [enabled by default]
drivers/cpuidle/governors/menu.c:277:2: warning: comparison of distinct pointer types lacks a cast [enabled by default]

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 26d5667..2efee27 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -248,7 +248,7 @@ static enum hrtimer_restart menu_hrtimer_notify(struct hrtimer *hrtimer)
 static u32 get_typical_interval(struct menu_device *data)
 {
 	int i = 0, divisor = 0;
-	int64_t max = 0, avg = 0, stddev = 0;
+	uint64_t max = 0, avg = 0, stddev = 0;
 	int64_t thresh = LLONG_MAX; /* Discard outliers above this value. */
 	unsigned int ret = 0;
 
