From: Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH -v2 1/5] oom: add helpers for setting and clearing
 TIF_MEMDIE
Date: Wed, 7 Jan 2015 19:23:35 +0100
Message-ID: <20150107182335.GG16553@dhcp22.suse.cz>
References: <20141110163055.GC18373@dhcp22.suse.cz>
 <1417797707-31699-1-git-send-email-mhocko@suse.cz>
 <1417797707-31699-2-git-send-email-mhocko@suse.cz>
 <20150107175731.GG4395@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:46693 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbbAGSXk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jan 2015 13:23:40 -0500
Content-Disposition: inline
In-Reply-To: <20150107175731.GG4395@htj.dyndns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On Wed 07-01-15 12:57:31, Tejun Heo wrote:
> On Fri, Dec 05, 2014 at 05:41:43PM +0100, Michal Hocko wrote:
> > +/**
> > + * Unmarks the current task as OOM victim.
> > + */
> > +void unmark_tsk_oom_victim(void)
> > +{
> > +	clear_thread_flag(TIF_MEMDIE);
> > +}
> 
> This prolly should be unmark_current_oom_victim()?

OK.

> Also, can we
> please use full "task" at least in global symbols?  I don't think tsk
> abbreviation is that popular in function names.

It is mimicking *_tsk_thread_flag() API.

-- 
Michal Hocko
SUSE Labs
