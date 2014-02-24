From: skannan@codeaurora.org
Subject: Re: [PATCH] cpufreq: Set policy to non-NULL only after all hotplug
 online work is done
Date: Mon, 24 Feb 2014 09:00:03 -0000
Message-ID: <d7272b91c74148c56de5f1c27dc7b7c7.squirrel@www.codeaurora.org>
References: <1393225072-3997-1-git-send-email-skannan@codeaurora.org>
    <530AF7E4.5080806@linux.vnet.ibm.com>
    <CAKohpok-8_JV8hRDiWnRLYqEqyvD60cyn5Hs1HcZTSEPZjLvOQ@mail.gmail.com>
    <a7536f7b5a03fe287aaf1974db74ba64.squirrel@www.codeaurora.org>
    <CAKohpomRqboKjHRF8ev9erJ6MdRWcsX2jO7A=g47gMmewm_ZiQ@mail.gmail.com>
    <b59f4a49af4ebd12c2d61e58dfb27a39.squirrel@www.codeaurora.org>
    <CAKohpok2rbepUS_7quZ0AThPckvVnAZybVpsV0ctiDWZmxTdRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKohpok2rbepUS_7quZ0AThPckvVnAZybVpsV0ctiDWZmxTdRw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


Viresh Kumar wrote:
> On 24 February 2014 14:17,  <skannan@codeaurora.org> wrote:
>> Sorry, not sure I understand what you mean.
>>
>> I agree, wording in my commit text might be unclear. I'll fix it after
>> we
>> agree on the code fix. In the MSM case, each CPU has it's own policy.
>>
>> I'm assuming your original complaint was about my confusing wording.
>> Maybe
>> that's not what you were pointing out?
>
> In your case each CPU has a separate policy structure as they have
> separately
> controllable clocks. But you also said that CPU0 is setting CPU1's
> governor to
> NULL. I don't see that happening. Each CPU sets its own governor to NULL
> on
> init().

When I said "CPU0 is setting CPU1's governor to NULL", I meant
thread/context running in CPU0 is setting CPU1's governor as part of
CPU1's ONLINE notifier.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
