From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/8][Sorted-buddy] mm: Linux VM Infrastructure to
 support Memory Power Management
Date: Mon, 12 Nov 2012 21:44:26 +0530
Message-ID: <50A12062.4070205@linux.vnet.ibm.com>
References: <20121106195026.6941.24662.stgit@srivatsabhat.in.ibm.com> <20121108180257.GC8218@suse.de> <loom.20121109T172910-394@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:33745 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab2KLQPx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Nov 2012 11:15:53 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 13 Nov 2012 02:11:59 +1000
In-Reply-To: <loom.20121109T172910-394@post.gmane.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: SrinivasPandruvada <srinivas.pandruvada@linux.intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, mjg59@srcf.ucam.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Dave Hansen <dave@linux.vnet.ibm.com>, maxime.coquelin@stericsson.com, loic.pallardy@stericsson.com, Arjan van de Ven <arjan@linux.intel.com>, kmpark@infradead.org, kamezawa.hiroyu@jp.fujitsu.com, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, Ankita Garg <gargankita@gmail.com>, amit.kachhap@linaro.org, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, thomas.abraham@linaro.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-mm@kvack.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, andi@firstfloor.org

Hi Srinivas,

It looks like your email did not get delivered to the mailing
lists (and the people in the CC list) properly. So quoting your
entire mail as-it-is here. And thanks a lot for taking a look
at this patchset!

Regards,
Srivatsa S. Bhat

On 11/09/2012 10:18 PM, SrinivasPandruvada wrote:
> I did like this implementation and think it is valuable.
> I am experimenting with one of our HW. This type of partition does help in
> saving power. We believe we can save up-to 1W power per DIM with the help
> of some HW/BIOS changes. We are only talking about content preserving memory,
> so we don't have to be 100% correct.
> In my experiments, I tried two methods:
> - Similar to approach suggested by Mel Gorman. I have a special sticky
> migrate type like CMA.
> - Buddy buckets: Buddies are organized into memory region aware buckets.
> During allocation it prefers higher order buckets. I made sure that there is
> no affect of my change if there are no power saving memory DIMs. The advantage
> of this bucket is that I can keep the memory in close proximity for a related
> task groups by direct hashing to a bucket. The free list if organized as two
> dimensional array with bucket and migrate type for each order.
> 
> In both methods, currently reclaim is targetted to be done by a sysfs interface
> similar to memory compaction for a node allowing user space to initiate reclaim. 
> 
> Thanks,
> Srinivas Pandruvada
> Open Source Technology Center,
> Intel Corp.
> 

