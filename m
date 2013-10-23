From: Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH v4 16/40] mm: Introduce a "Region Allocator" to
 manage entire memory regions
Date: Wed, 23 Oct 2013 11:10:12 +0100
Message-ID: <20131023101012.GB2043@cmpxchg.org>
References: <20130925231250.26184.31438.stgit@srivatsabhat.in.ibm.com>
 <20130925231730.26184.19552.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from zene.cmpxchg.org ([85.214.230.12]:60109 "EHLO zene.cmpxchg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab3JWKNF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Oct 2013 06:13:05 -0400
Content-Disposition: inline
In-Reply-To: <20130925231730.26184.19552.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, mgorman@suse.de, dave@sr71.net, tony.luck@intel.com, matthew.garrett@nebula.com, riel@redhat.com, arjan@linux.intel.com, srinivas.pandruvada@linux.intel.com, willy@linux.intel.com, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl, gargankita@gmail.com, paulmck@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, andi@firstfloor.org, isimatu.yasuaki@jp.fujitsu.com, santosh.shilimkar@ti.com, kosaki.motohiro@gmail.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Thu, Sep 26, 2013 at 04:47:34AM +0530, Srivatsa S. Bhat wrote:
> Today, the MM subsystem uses the buddy 'Page Allocator' to manage memory
> at a 'page' granularity. But this allocator has no notion of the physical
> topology of the underlying memory hardware, and hence it is hard to
> influence memory allocation decisions keeping the platform constraints
> in mind.

This is no longer true after patches 1-15 introduce regions and have
the allocator try to stay within the lowest possible region (patch
15).  Which leaves the question what the following patches are for.

This patch only adds a data structure and I gave up finding where
among the helpers, statistics, and optimization patches an actual
implementation is.

Again, please try to make every single a patch a complete logical
change to the code base.
