From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -v3 0/5] OOM vs PM freezer fixes
Date: Mon, 12 Jan 2015 15:59:35 -0800
Message-ID: <20150112155935.21b13bc41417ceedde9d640f@linux-foundation.org>
References: <1420801555-22659-1-git-send-email-mhocko@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37085 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbbALX7g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 18:59:36 -0500
In-Reply-To: <1420801555-22659-1-git-send-email-mhocko@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Hocko <mhocko@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On Fri,  9 Jan 2015 12:05:50 +0100 Michal Hocko <mhocko@suse.cz> wrote:

> Hi,

I've been cheerily ignoring this discussion, sorry.  I trust everyone's
all happy and ready to go with this?

> [what changed since the last patchset]
>
> ...
>
> [testing results]
>
> ...
>
> [overview of the 5 patches]
>
> ...
> 

That's nice, but it doesn't really tell us what the patchset does.  The
first paragraph of the [5/5] changelog provides hints, but doesn't
explain why we even need to fix a race which is "quite small and really
unlikely".

So...  could we please have a few words describing the overall intent
and effect of this patchset?

Thanks.
