From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 6/8] mm: Demarcate and maintain pageblocks in region-order
 in the zones' freelists
Date: Tue, 06 Nov 2012 13:49:18 -0800
Message-ID: <509985DE.8000508@linux.vnet.ibm.com>
References: <20121106195026.6941.24662.stgit@srivatsabhat.in.ibm.com> <20121106195342.6941.94892.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:42739 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870Ab2KFVtk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 6 Nov 2012 16:49:40 -0500
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <dave@linux.vnet.ibm.com>;
	Tue, 6 Nov 2012 16:49:38 -0500
In-Reply-To: <20121106195342.6941.94892.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, mgorman@suse.de, mjg59@srcf.ucam.org, paulmck@linux.vnet.ibm.com, maxime.coquelin@stericsson.com, loic.pallardy@stericsson.com, arjan@linux.intel.com, kmpark@infradead.org, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl, gargankita@gmail.com, amit.kachhap@linaro.org, svaidy@linux.vnet.ibm.com, thomas.abraham@linaro.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On 11/06/2012 11:53 AM, Srivatsa S. Bhat wrote:
> This is the main change - we keep the pageblocks in region-sorted order,
> where pageblocks belonging to region-0 come first, followed by those belonging
> to region-1 and so on. But the pageblocks within a given region need *not* be
> sorted, since we need them to be only region-sorted and not fully
> address-sorted.
> 
> This sorting is performed when adding pages back to the freelists, thus
> avoiding any region-related overhead in the critical page allocation
> paths.

It's probably _better_ to do it at free time than alloc, but it's still
pretty bad to be doing a linear walk over a potentially 256-entry array
holding the zone lock.  The overhead is going to show up somewhere.  How
does this do with a kernel compile?  Looks like exit() when a process
has a bunch of memory might get painful.

