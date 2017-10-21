From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states after some time
Date: Sat, 21 Oct 2017 07:27:33 -0700
Message-ID: <000701d34a78$be36a6e0$3aa3f4a0$@net>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> <4491b9f9-bc6f-f173-5816-c46a2f41de8e@tu-dresden.de> <CAJvTdKkDcfNvLUq6fond7s2qG-UiZOAjszJOUmoGHsE6MTsVyw@mail.gmail.com> 5alHedkBdhCDu5alJeMF7o
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta17.telus.net ([209.171.16.90]:47411 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932099AbdJUO1m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Oct 2017 10:27:42 -0400
In-Reply-To: 5alHedkBdhCDu5alJeMF7o
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Len Brown' <lenb@kernel.org>
Cc: "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, 'Linux PM list' <linux-pm@vger.kernel.org>, =?utf-8?Q?'Marcus_H=C3=A4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?utf-8?Q?'Robert_Sch=C3=B6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de

On 2017.10.20 09:32 Thomas Ilsche wrote:

>> To prove that this is the result of OS C-state demotion, I have
>> implemented option "d)" in your paper.  I added a module param,
>> currently called "cpuidle.powersave", that causes cpuidle to bypass
>> the governor altogether and select the deepest state that is allowed
>> by PM_QOS.  (maybe I should call it cpuidle.bypass, or
>> cpuidle.deepest...)  When i set this parameter,  multi-user C-state
>> residency and power equal that seen in single-user mode, with no
>> spikes.
>
> Can you please share the patch, I'd like to use it for some experiments.

Can you not achieve the same, or at least similar and good enough for
testing, conditions by disabling all the other idle states?

On my system, the max idle state is 4 (C6), and I just disable states
0-3 to force always state 4.

... Doug
