From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC PATCH] PM, freezer: Don't thaw when it's intended frozen processes
Date: Mon, 11 May 2015 15:33:10 +0900
Message-ID: <CAJKOXPfmzvE_P15jTrkrXMDuWdqewj2uhM6N1vt=QBD2_ZFhrg@mail.gmail.com>
References: <20150507064557.GA26928@july>
	<20150507154212.GA12245@htj.duckdns.org>
	<CAH9JG2UAVRgX0Mg0d7WgG0URpkgu4q_bbNMXyOOEh9WFPztppQ@mail.gmail.com>
	<20150508152513.GB28439@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150508152513.GB28439@htj.duckdns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "\\Rafael J. Wysocki\\" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2015-05-09 0:25 GMT+09:00 Tejun Heo <tj@kernel.org>:
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

Hi,

I tested it on v4.1-rc3 and next-20150508.

Task was moved to frozen cgroup:
-----
root@localhost:/sys/fs/cgroup/freezer/frozen# grep . *
cgroup.clone_children:0
cgroup.procs:2750
freezer.parent_freezing:0
freezer.self_freezing:1
freezer.state:FROZEN
notify_on_release:0
tasks:2750
tasks:2773
-----

Unfortunately during system resume the process was woken up. The "if
(frozen(p))" check was true. Is it expected behaviour?

Best regards,
Krzysztof

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
