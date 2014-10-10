From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 07:48:08 -0400
Message-ID: <5437C778.4040108@redhat.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com> <54353223.7080704@redhat.com> <CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com> <5437C12D.1070803@redhat.com> <CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com> <5437C535.3070707@redhat.com> <CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbaJJLsV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Oct 2014 07:48:21 -0400
In-Reply-To: <CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?UTF-8?B?Um9iZXJ0IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>



On 10/10/2014 07:46 AM, Viresh Kumar wrote:
> On 10 October 2014 17:08, Prarit Bhargava <prarit@redhat.com> wrote:
>> Yes, I unfortunately have a different set of issues with vanilla 3.17
>> (previously mentioned locking issue).  I've done a quick and dirty hack to get
>> around that, and everything seems okay.
>>
>> I apply your patches and I get a panic the first time I read sysfs
> 
> All changes in my patches are touching these routines:
> - cpufreq_set_policy()
> - __cpufreq_governor()
> 
> And these two doesn't get called in the read path at all. And so I am not sure
> how can these make things bad for you.
> 
> I had doubt on just one change, can you please check the v2 branch once to
> see if that gives the same problem ?
> 

Yep, trying it now ...

P.
