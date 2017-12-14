From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/3] PM / core: Add IN_BAND_WAKEUP driver flag
Date: Thu, 14 Dec 2017 15:27:43 +0100
Message-ID: <CAMuHMdWecaCT30CNTs1rPXbJ4R_XbVuFH6mH3-DHYkcByV_1bA@mail.gmail.com>
References: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
 <1510588003-16650-3-git-send-email-ulf.hansson@linaro.org>
 <1926914.PsNMcYBlGW@aspire.rjw.lan> <CAMuHMdUE+fdbS+HDxbcWNHaTZubnrQ7ai4bkOsBpLriG1y-gZg@mail.gmail.com>
 <CAPDyKFoAY7yZJz9obke5DeqadpqJ0MEKPQJvxibpq85f+==BBA@mail.gmail.com>
 <CAMuHMdXk9GaExvYbdSfV0bf4Kh1TNrZDKtAfTDaDfWFMvk6Snw@mail.gmail.com>
 <CAPDyKFoey_kSf0OE7OmHCX4H4VFQcWOU6NE4suZ9=9stZVQNpQ@mail.gmail.com>
 <CAMuHMdXqK4QA=rqWpBMPmXY7vb2Feoncb4wym0C9y7tvV71zBw@mail.gmail.com> <CAPDyKFpFiBbuC6vhv4-gA+WOy2igwSZzZXtN9a9sH-f6FSWwWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpFiBbuC6vhv4-gA+WOy2igwSZzZXtN9a9sH-f6FSWwWQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On Thu, Dec 14, 2017 at 3:13 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 14 December 2017 at 11:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Mon, Dec 11, 2017 at 9:59 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 11 December 2017 at 11:48, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>> On Mon, Dec 11, 2017 at 11:24 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>> On 10 December 2017 at 11:16, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>>> To complicate matters, some drivers may be used on SoCs where the device
>>>>>> needs to be kept running (clock and/or power domain), and on SoCs where the
>>>>>> device is always running. This difference is typically handled by genpd,
>>>>>> and the device driver may not even be aware. Of course the driver can just
>>>>>> set IN_BAND_WAKEUP regardless, (else it has to check for the presence of
>>>>>> clocks and/or power-domains properties itself, duplicating genpd
>>>>>> core/driver code).
>>>>>>
>>>>>> So what about
>>>>>>
>>>>>>          if (IN_BAND_WAKEUP ||
>>>>>>             (GENPD_FLAG_ACTIVE_WAKEUP && !OUT_BAND_WAKEUP)) {
>>>>>
>>>>> We don't want to suspend the device in case of IN_BAND_WAKEUP, right!?
>>>>>
>>>>>>                 ... suspend device...
>>>>>>         }
>>>>
>>>> Oops, inverted logic. I should not write technical emails on Sunday morning.
>>>>
>>>> Yes, the device must be kept awake if either IN_BAND_WAKEUP is set, or
>>>> if GENPD_FLAG_ACTIVE_WAKEUP is set but OUT_BAND_WAKEUP isn't.
>>>
>>> Putting together the pieces of information received here, you have
>>> convinced me that we should stick to use the current
>>> GENPD_FLAG_ACTIVE_WAKEUP for now, which allows genpds to opt-in for
>>> start dealing with in-band-wakeups.
>>
>> Thank you!
>>
>> So I'll move forward with "[PATCH v2 0/3] PM / Domain: renesas: Fix active
>> wakeup behavior"
>> (https://www.spinics.net/lists/linux-renesas-soc/msg19941.html)
>
> Yes! I just added my reviewed-by tag to these.

Thanks a lot!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
