From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [RFC PATCH] PM, freezer: Don't thaw when it's intended frozen processes
Date: Mon, 11 May 2015 13:28:54 +0900
Message-ID: <CAH9JG2VROCekWCAa+1t6Giy2wHC171TD-AXQVxG2vTH-LPcoPA@mail.gmail.com>
References: <20150507064557.GA26928@july>
	<20150507154212.GA12245@htj.duckdns.org>
	<CAH9JG2UAVRgX0Mg0d7WgG0URpkgu4q_bbNMXyOOEh9WFPztppQ@mail.gmail.com>
	<20150508152513.GB28439@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36261 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbbEKE2z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 00:28:55 -0400
In-Reply-To: <20150508152513.GB28439@htj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "\\Rafael J. Wysocki\\" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Sat, May 9, 2015 at 12:25 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Kyungmin.
>
> On Fri, May 08, 2015 at 09:04:26AM +0900, Kyungmin Park wrote:
>> > I need to think more about it but as an *optimization* we can add
>> > freezing() test before actually waking tasks up during resume, but can
>> > you please clarify what you're seeing?
>>
>> The mobile application has life cycle and one of them is 'suspend'
>> state. it's different from 'pause' or 'background'.
>> if there are some application and enter go 'suspend' state. all
>> behaviors are stopped and can't do anything. right it's suspended. but
>> after system suspend & resume, these application is thawed and
>> running. even though system know it's suspended.
>>
>> We made some test application, print out some message within infinite
>> loop. when it goes 'suspend' state. nothing is print out. but after
>> system suspend & resume, it prints out again. that's not desired
>> behavior. and want to address it.
>>
>> frozen user processes should be remained as frozen while system
>> suspend & resume.
>
> Yes, they should and I'm not sure why what you're saying is happening
> because freezing() test done from the frozen tasks themselves should
> keep them in the freezer.  Which kernel version did you test?  Can you
> please verify it against a recent kernel?

The kernel 3.10 is not working as expected, but right the latest
kernel is working correctly.

I see I'll check what's different and which are modified.

Thank you,
Kyungmin Park
