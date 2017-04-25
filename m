From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Performance of low-cpu utilisation benchmark regressed severely since 4.6
Date: Tue, 25 Apr 2017 00:13:29 -0700
Message-ID: <002e01d2bd93$7307d120$59177360$@net>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net>        <000a01d2b9e6$393afef0$abb0fcd0$@net> <000301d2bb31$c0037790$400a66b0$@net>     <000501d2bc46$ad4b1fc0$07e15f40$@net>   <CAJZ5v0gBhVOYJ5a7YWpRHSH20qx3Cjx_Lg0qk52st-p+fQS9bQ@mail.gmail.com> 2Sh4dt8AXIBJV2Sh6dNtdh 2ee6dqi43ISm62eusdKnGr
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:60962 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753147AbdDYHNi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Apr 2017 03:13:38 -0400
In-Reply-To: 2ee6dqi43ISm62eusdKnGr
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Mel Gorman' <mgorman@techsingularity.net>, 'Rafael Wysocki' <rafael.j.wysocki@intel.com>, =?utf-8?Q?'J=C3=B6rg_Otte'?= <jrg.otte@gmail.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Doug Smythies' <dsmythies@telus.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

On 2017.04.24 07:25 Doug wrote:
> On 2017.04.23 18:23 Srinivas Pandruvada wrote:
>> On Mon, 2017-04-24 at 02:59 +0200, Rafael J. Wysocki wrote:
>>> On Sun, Apr 23, 2017 at 5:31 PM, Doug Smythies <dsmythies@telus.net> wrote:
>
>>>> It looks like the cost is mostly related to moving the load from
>>>> one CPU to
>>>> another and waiting for the new one to ramp up then.
>> Last time when we analyzed Mel's result last year this was the
>> conclusion. The problem was more apparent on systems with per core P-
>> state.
>
> ?? I have never seen this particular use case before.
> Unless I have looked the wrong thing, Mel's issue last year was a
> different use case.
>
> ...[cut]...
> 
>>>>> We can do one more trick I forgot about.  Namely, if we are about
>>>>> to increase
>>>>> the P-state, we can jump to the average between the target and
>>>>> the max
>>>>> instead of just the target, like in the appended patch (on top of
>>>>> linux-next).
>>>>> 
>>>>> That will make the P-state selection really aggressive, so costly
>>>>> energetically,
>>>>> but it shoud small jumps of the average load above 0 to case big
>>>>> jumps of
>>>>> the target P-state.
>>>> I'm already seeing the energy costs of some of this stuff.
>>>> 3050.2 Seconds.
>>> Is this with or without reducing the sampling interval?
>
> It was without reducing the sample interval.
>
> So, it was the branch you referred us to the other day:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>
> with your patch (now deleted from this thread) applied.
>
>
> ...[cut]...
>
>>> Anyway, your results are somewhat counter-intuitive.
>
>>> Would it be possible to run this workload with the linux-next branch
>>> and the schedutil governor and see if the patch at
>>> https://patchwork.kernel.org/patch/9671829/ makes any difference?
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> Plus that patch is in progress.

3387.76 Seconds.
Idle power 3.85 watts.

Other potentially interesting information for 2 hour idle test:
Driver called 21209 times. Maximum duration 2396 Seconds. Minimum duration 20 mSec. 
Histogram of target pstates:
16 8
17 3149
18 1436
19 1479
20 196
21 2
22 3087
23 375
24 22
25 4
26 2
27 3736
28 2177
29 13
30 0
31 0
32 2
33 0
34 1533
35 246
36 0
37 4
38 3738

Compared to kernel 4.11-rc7 (passive mode, schedutil governor)
3297.82 (re-stated from a previous e-mail)
Idle power 3.81 watts

Other potentially interesting information for 2 hour idle test:
Driver called 1631 times. Maximum duration 2510 Seconds. Minimum duration 0.587 mSec.
Histogram of target pstates (missing lines mean 0 occurrences):
16 813
24 2
38 816

... Doug
