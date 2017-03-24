From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU
 controller
Date: Fri, 24 Mar 2017 11:00:46 -0400
Message-ID: <20170324150046.GA21525@htj.duckdns.org>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org>
 <20170320180837.GB28391@e110439-lin>
 <CAEi0qNmQWxc+SWYPfbf7jzz3w4-k-uatUHT1r2m_68EOFAVp=A@mail.gmail.com>
 <20170323103254.GA11362@e110439-lin>
 <20170323160112.GA5953@htj.duckdns.org>
 <20170323181533.GB11362@e110439-lin>
 <20170323183937.GC5953@htj.duckdns.org>
 <CAEi0qNniGZPuuHmcz_YeYWxp4K=J7-VaiRYjJ3nFyGQ6WZK+_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36648 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdCXPAu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 11:00:50 -0400
Content-Disposition: inline
In-Reply-To: <CAEi0qNniGZPuuHmcz_YeYWxp4K=J7-VaiRYjJ3nFyGQ6WZK+_g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Hello,

On Thu, Mar 23, 2017 at 11:37:50PM -0700, Joel Fernandes (Google) wrote:
> > That's also why we're gonna have problem if we later decide we need a
> > thread based API for it.  Once we make cgroup the primary owner of the
> > attribute, it's not straight forward to add another owner.
> 
> Sorry I don't immediately see why it is not straight forward to have a
> per-task API later once CGroup interface is added? Maybe if you don't
> mind giving an example that will help?
> 
> I can start with an example, say you have a single level hierarchy
> (Top-app in Android terms is the set of tasks that are user facing and
> we'd like to enforce some capacity minimums, background on the other
> hand is the opposite):
> 
>                    ROOT (min = 0, max = 1024)
>                    /                         \
>                   /                           \
>               TOP-APP (min = 200, max = 1024)  BACKGROUND (min = 0, max = 500)
> 
> If in the future, if we want to have a per-task API to individually
> configure the task with these limits, it seems it will be straight
> forward to implement IMO.

Ah, you're right.  I got fixated on controllers which control single
value attributes (the net ones).  Yeah, we can extend the same range
interace to thread level.  Sorry about the confusion.

Not necessarliy specific to the API discussion but in general lower
level in the configuration hierarchy shouldn't be able to restrict
what the parents can do, so we need to think more about how delegation
should work.

> As Patrick mentioned, all of the usecases needing this right now is an
> informed runtime placing a task in a group of tasks and not needing to
> set attributes for each individual task. We are already placing tasks
> in individual CGroups in Android based on the information the runtime
> has so adding in the capacity constraints will make it fit naturally
> while leaving the door open for any future per-task API additions IMO.

But the question is that while the use case can be served by cgroup as
the primary API, it doesn't have to be.  This still is an attribute
range restriction controller rather than an actual hierarchical
resource distributor.  All the controller does is restricting per-task
configuration which is the only thing operative.  This is different
from bandwidth which is an actual resource controller which
distributes cpu cycles hierarchically.

There can be some benefits to having cgroup restrictions on capacity
but they won't add anything functionally fundamental.  So, I still
don't see why making cgroup the primary interface would be a good idea
here.

Thanks.

-- 
tejun
