From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/3] Add support for Tegra Activity Monitor
Date: Tue, 9 Dec 2014 23:18:49 +0900
Message-ID: <CAAVeFuJY_31ayqnoY65uCoP9AadvucEARmuv4jr_DoS6Aj5rGA@mail.gmail.com>
References: <1417709696-29281-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAAVeFuJkpuWocEDTfSAK7_UfhZvqOfYJY6sLgsy9i+KcMAkbCQ@mail.gmail.com> <548703C4.1030300@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <548703C4.1030300-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 9, 2014 at 11:14 PM, Tomeu Vizoso
<tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
> On 12/09/2014 06:38 AM, Alexandre Courbot wrote:
>> On Fri, Dec 5, 2014 at 1:14 AM, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
>>> Hello,
>>>
>>> this v3 addresses the comments that the devfreq implementation got, namely:
>>>
>>> * Address misc. style issues found by Thierry and Alexander
>>> * Added helpers for register i/o
>>> * Further documented the structs
>>> * Enable the ACTMON after the IRQ handler has been installed
>>> * Disable the ACTMON before removing the IRQ handler
>>> * Add governor in a subsys initcall
>>>
>>> There's an open question on whether some functionality currently in this
>>> devfreq driver should be moved into the devfreq framework, but without knowing
>>> of other SoC family that would benefit from it, I'm reticent. It would be
>>> great to hear from the devfreq maintainers if they have any plans regarding
>>> this, or if they have any suggestion.
>>
>> I cannot make a thorough review because of the problem I mentioned in
>> patch 3/3, but I am guessing this series is converging towards what we
>> want. Now the main question will be how we can leverage Arto's
>> watermark series for this one. I am ready to bet that doing so can
>> reduce quite a lot of code.
>>
>> Since you are likely to be the first user of the watermarking feature,
>> could you comment on its potential shortcomings and whatever needs to
>> be fixed to best implement ACTMON support using it? I will try to push
>> it myself, but you are obviously in a better position to understand
>> what is needed.
>
> Sure, I'm still playing with the idea, but I have sent a few questions
> to that thread already.

Seen that, thanks! After seeing your comments I come to thing that
maybe we should merge ACTMON support first and then adapt it to use
watermarking afterwards. I'm all for incremental changes and after 4
iterations this series should be close to completion now - would be
sad to go back to the design board at this stage.

Reviewing your v4 is on my schedule for tomorrow, thanks for your patience!
