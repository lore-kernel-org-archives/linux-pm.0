From: SrinivasPandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC PATCH 0/8][Sorted-buddy] mm: Linux VM Infrastructure to support Memory Power Management
Date: Fri, 9 Nov 2012 16:48:37 +0000 (UTC)
Message-ID: <loom.20121109T172910-394@post.gmane.org>
References: <20121106195026.6941.24662.stgit@srivatsabhat.in.ibm.com> <20121108180257.GC8218@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38887 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881Ab2KIQt5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 9 Nov 2012 11:49:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1TWrmN-0005eY-Cv
	for linux-pm@vger.kernel.org; Fri, 09 Nov 2012 17:50:03 +0100
Received: from 134.134.139.76 ([134.134.139.76])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Fri, 09 Nov 2012 17:50:03 +0100
Received: from srinivas.pandruvada by 134.134.139.76 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Fri, 09 Nov 2012 17:50:03 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

I did like this implementation and think it is valuable.
I am experimenting with one of our HW. This type of partition does help in
saving power. We believe we can save up-to 1W power per DIM with the help
of some HW/BIOS changes. We are only talking about content preserving memory,
so we don't have to be 100% correct.
In my experiments, I tried two methods:
- Similar to approach suggested by Mel Gorman. I have a special sticky
migrate type like CMA.
- Buddy buckets: Buddies are organized into memory region aware buckets.
During allocation it prefers higher order buckets. I made sure that there is
no affect of my change if there are no power saving memory DIMs. The advantage
of this bucket is that I can keep the memory in close proximity for a related
task groups by direct hashing to a bucket. The free list if organized as two
dimensional array with bucket and migrate type for each order.

In both methods, currently reclaim is targetted to be done by a sysfs interface
similar to memory compaction for a node allowing user space to initiate reclaim. 

Thanks,
Srinivas Pandruvada
Open Source Technology Center,
Intel Corp.


