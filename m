From: Paul Turner <pjt@google.com>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU controller
Date: Thu, 30 Mar 2017 14:13:04 -0700
Message-ID: <CAPM31RLJKgnNLv9-fpwxHNNNxfGv2NoyWHD3kUivU+RSgoR5Dw@mail.gmail.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org> <20170320180837.GB28391@e110439-lin>
 <CAEi0qNmQWxc+SWYPfbf7jzz3w4-k-uatUHT1r2m_68EOFAVp=A@mail.gmail.com>
 <20170323103254.GA11362@e110439-lin> <20170323160112.GA5953@htj.duckdns.org>
 <20170323181533.GB11362@e110439-lin> <20170323183937.GC5953@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35386 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933687AbdC3VNh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 17:13:37 -0400
Received: by mail-yw0-f182.google.com with SMTP id d191so30393921ywe.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2017 14:13:36 -0700 (PDT)
In-Reply-To: <20170323183937.GC5953@htj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, "Joel Fernandes (Google)" <joel.opensrc@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

There is one important, fundamental difference here:
 {cfs,rt}_{period,runtime}_us is a property that applies to a group of
threads, it can be sub-divided.
We can consume 100ms of quota either by having one thread run for
100ms, or 2 threads running for 50ms.

This is not true for capacity.  It's a tag that affects the individual
threads it's applied to.
I'm also not sure if it's a hard constraint.  For example, suppose we
set a max that is smaller than a "big" cpu on an asymmetric system.
In the case that the faster CPU is relatively busy, but still
opportunistically available, we would still want to schedule it there.

This definitely seems to make more sense as a per-thread interface in
its current form.
