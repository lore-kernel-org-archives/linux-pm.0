From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -v3 5/5] oom, PM: make OOM detection in the freezer path
 raceless
Date: Mon, 12 Jan 2015 12:22:51 -0500
Message-ID: <20150112172251.GB22156@htj.dyndns.org>
References: <1420801555-22659-1-git-send-email-mhocko@suse.cz>
 <1420801555-22659-6-git-send-email-mhocko@suse.cz>
 <20150110194322.GE25319@htj.dyndns.org>
 <20150112161011.GE4877@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:65162 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbALRW4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 12:22:56 -0500
Content-Disposition: inline
In-Reply-To: <20150112161011.GE4877@dhcp22.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Hocko <mhocko@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On Mon, Jan 12, 2015 at 05:10:11PM +0100, Michal Hocko wrote:
> Yes I had it this way but it didn't work out because thaw_kernel_threads
> is not called on the resume because it is only used as a fail
> path when kernel threads freezing fails. I would rather keep the

Ooh, that's kinda asymmetric.

> enabling/disabling points as we had them. This is less risky IMHO.

Okay, please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
