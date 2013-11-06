From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH update] PM / hibernate: Avoid overflow in hibernate_preallocate_memory
Date: Wed, 06 Nov 2013 08:41:31 +0800
Message-ID: <5279903B.40202@intel.com>
References: <52789B31.70005@intel.com> <1974778.1p97Y6DIEX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52711 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755373Ab3KFAkr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Nov 2013 19:40:47 -0500
In-Reply-To: <1974778.1p97Y6DIEX@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux-pm mailing list <linux-pm@vger.kernel.org>, Leon Drugi <eyak@wp.pl>

On 11/05/2013 10:22 PM, Rafael J. Wysocki wrote:
> On Tuesday, November 05, 2013 03:16:01 PM Aaron Lu wrote:
>>  	pages_highmem = preallocate_image_highmem(highmem / 2);
>> -	alloc = (count - max_size) - pages_highmem;
>> +	alloc = (count - max_size) > pages_highmem ?
>> +		(count - max_size - pages_highmem) : 0;
> 
> Well, what about
> 
> 	alloc = count - max_size;
> 	if (alloc > pages_highmem)
> 		alloc -= pages_highmem;
> 	else
> 		alloc = 0;
> 

OK, here it comes:

From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] PM / hibernate: Avoid overflow in hibernate_preallocate_memory

When system has a lot of highmem(e.g. 16GiB using a 32 bits kernel), the
code to calculate how much memory we need to preallocate in normal zone
may cause overflow. As Leon has analysed:
"
It looks that during computing 'alloc' variable there is overflow:
alloc = (3943404 - 1970542) - 1978280 = -5418 (signed)
And this function goes to err_out.
"
Fix this by avoiding that overflow.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=60817
Reported-and-tested-by: Leon Drugi <eyak@wp.pl>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 kernel/power/snapshot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 98c3b34a4cff..10c22cae83a0 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1402,7 +1402,11 @@ int hibernate_preallocate_memory(void)
 	 * highmem and non-highmem zones separately.
 	 */
 	pages_highmem = preallocate_image_highmem(highmem / 2);
-	alloc = (count - max_size) - pages_highmem;
+	alloc = count - max_size;
+	if (alloc > pages_highmem)
+		alloc -= pages_highmem;
+	else
+		alloc = 0;
 	pages = preallocate_image_memory(alloc, avail_normal);
 	if (pages < alloc) {
 		/* We have exhausted non-highmem pages, try highmem. */
-- 
1.8.4.39.ga0d3f10
