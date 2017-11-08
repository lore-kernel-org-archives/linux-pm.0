From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states after some time
Date: Wed, 8 Nov 2017 08:26:06 -0800
Message-ID: <001e01d358ae$48258a90$d8709fb0$@net>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> <000101d34938$da740870$8f5c1950$@net> <000801d34a78$cdd27890$697769b0$@net> <85fb012d-adba-a646-dfd5-a5322714a412@tu-dresden.de> <CAJvTdKkP5xu6r7k7u0yjjGBtQ=3giRehGxLL=VfyJLdV1XJZNg@mail.gmail.com> CJNmeKLfst1L5CJNneFmdJ
Mime-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta17.telus.net ([209.171.16.90]:59989 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751763AbdKHQ0J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Nov 2017 11:26:09 -0500
In-Reply-To: CJNmeKLfst1L5CJNneFmdJ
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Yu Chen' <yu.c.chen@intel.com>, 'Len Brown' <lenb@kernel.org>
Cc: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, =?iso-8859-1?Q?'Marcus_H=E4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?iso-8859-1?Q?'Robert_Sch=F6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, 'Ying Huang' <ying.huang@intel.com>, 'Linux PM list' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

On 2017.11.07.10:01 22:01 Yu Chen wrote:

... [snip]...

> According to the ftrace, there are mainly two problems here:
>
> 1. A local apic timer seems to always arrive earlier than it should be,
>   which causes the breakage of deep cstate, as a result the menu governor
>   would get a short 'next timer' event, which brings the cpu into poll_idle:

... [snip]...
      
> Question 1 is the reason why the cpu choose poll_idle, ...
> , and I think question 1 needs to be further investigated
> whether we program the clockevent too soon(than it should be),

Agreed.
Thank you for the information.

...[snip]...
