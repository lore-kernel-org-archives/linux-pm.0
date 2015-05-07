From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] PM, freezer: Don't thaw when it's intended frozen
 processes
Date: Thu, 7 May 2015 11:42:12 -0400
Message-ID: <20150507154212.GA12245@htj.duckdns.org>
References: <20150507064557.GA26928@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35302 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbbEGPmR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 11:42:17 -0400
Content-Disposition: inline
In-Reply-To: <20150507064557.GA26928@july>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

Hello,

On Thu, May 07, 2015 at 03:45:57PM +0900, Kyungmin Park wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Some platform uses freezer cgroup for speicial purpose to schedule out some applications. but after suspend & resume, these processes are thawed and running. 

They shouldn't be able to leave the freezer tho.  Resuming does wake
up all tasks but freezing() test would still evaulate to true for the
ones frozen by cgroup freezer and they will stay inside the freezer.

> but it's inteneded and don't need to thaw it.
> 
> To avoid it, does it possible to modify resume code and don't thaw it when resume? does it resonable?

I need to think more about it but as an *optimization* we can add
freezing() test before actually waking tasks up during resume, but can
you please clarify what you're seeing?

Thanks.

-- 
tejun
