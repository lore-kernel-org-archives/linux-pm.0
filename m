From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/9] cgroup: implement generic child / descendant walk
 macros
Date: Tue, 6 Nov 2012 12:31:54 -0800
Message-ID: <20121106203154.GV30069@mtj.dyndns.org>
References: <1351931915-1701-1-git-send-email-tj@kernel.org>
 <1351931915-1701-4-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33933 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab2KFUb7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Nov 2012 15:31:59 -0500
Content-Disposition: inline
In-Reply-To: <1351931915-1701-4-git-send-email-tj@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lizefan@huawei.com, mhocko@suse.cz, rjw@sisk.pl
Cc: containers@lists.linux-foundation.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, fweisbec@gmail.com

On Sat, Nov 03, 2012 at 01:38:29AM -0700, Tejun Heo wrote:
> Currently, cgroup doesn't provide any generic helper for walking a
> given cgroup's children or descendants.  This patch adds the following
> three macros.
> 
> * cgroup_for_each_child() - walk immediate children of a cgroup.
> 
> * cgroup_for_each_descendant_pre() - visit all descendants of a cgroup
>   in pre-order tree traversal.
> 
> * cgroup_for_each_descendant_post() - visit all descendants of a
>   cgroup in post-order tree traversal.
> 
> All three only require the user to hold RCU read lock during
> traversal.  Verifying that each iterated cgroup is online is the
> responsibility of the user.  When used with proper synchronization,
> cgroup_for_each_descendant_pre() can be used to propagate config
> updates to descendants in reliable way.  See comments for details.

Michal, Li, how does this look to you?  Would this be okay for memcg
too?  Li, do you think the comment on cgroup_for_each_descendant_pre()
is correct?

Thanks.

-- 
tejun
