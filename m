From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 20/20] cpufreq: scmi: add support for fast frequency switching
Date: Wed, 8 Nov 2017 12:21:16 +0100
Message-ID: <CAJZ5v0hAiJBrdXNn2Gf_aC4z-UmBg8t4fTNRbWTPsvk+kFtABA@mail.gmail.com>
References: <1509720477-18936-1-git-send-email-sudeep.holla@arm.com>
 <1509720477-18936-21-git-send-email-sudeep.holla@arm.com> <4588325.776kYim3Ci@aspire.rjw.lan>
 <3f79f75f-1b6a-3f7b-b0c0-f970f0fb6c12@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3f79f75f-1b6a-3f7b-b0c0-f970f0fb6c12-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ALKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Roy Franz <roy.franz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Harb Abdulhamid <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, Ryan Harkin <Ryan.Harkin-5wv7dgnIgG8@public.gmane.org>, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 8, 2017 at 11:42 AM, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org> wrote:
>
>
> On 08/11/17 00:24, Rafael J. Wysocki wrote:
>> On Friday, November 3, 2017 3:47:57 PM CET Sudeep Holla wrote:
>>> The cpufreq core provides option for drivers to implement fast_switch
>>> callback which is invoked for frequency switching from interrupt context.
>>>
>>> This patch adds support for fast_switch callback in SCMI cpufreq driver
>>> by making use of polling based SCMI transfer. It also sets the flag
>>> fast_switch_possible.
>>>
>>> Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
>>> Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> Signed-off-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
>>
>> I'm assuming that this material will go in along with the rest of the series
>> through a different tree.
>>
>
> Indeed, I will ask ARM-SoC guys to take it via their tree when ready. I
> assume you are fine with that, please provide ack if that's still the case.

OK

Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

as long as the changes are fine by Viresh.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
