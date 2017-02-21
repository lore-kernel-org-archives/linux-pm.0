From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
Date: Tue, 21 Feb 2017 16:51:48 +0000
Message-ID: <016dd5fc-08c2-0084-5332-2992ab95f134@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <08c5dcf3-9d7c-33ff-f801-8f94f630f49b@arm.com>
 <CAMuHMdUAcRVLzDZCZucAt0agGZynQtqhWeh7yPaBrogCYhRW4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbdBUQwB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Feb 2017 11:52:01 -0500
In-Reply-To: <CAMuHMdUAcRVLzDZCZucAt0agGZynQtqhWeh7yPaBrogCYhRW4g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 21/02/17 16:23, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Tue, Feb 21, 2017 at 11:42 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 20/02/17 20:33, Geert Uytterhoeven wrote:
>>> Enable support for "shallow" suspend mode, also known as "Standby" or
>>> "Power-On Suspend".
>>>
>>> As secondary CPU cores are taken offline, "shallow" suspend mode saves
>>> slightly more power than "s2idle", but less than "deep" suspend mode.
>>> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>>> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>>> an optional API in PSCI v1.0.
>>>
>>> List the available system suspend modes:
>>>
>>>     $ cat /sys/power/mem_sleep
>>>     s2idle shallow [deep]
>>>
>>> Suspend to "shallow" mode:
>>>
>>>     $ echo shallow > /sys/power/mem_sleep
>>>     $ echo mem > /sys/power/state
>>>
>>
>> I don't have the links to such previous attempts handy, but we have
> 
> Don't worry, I did read earlier discussions about implementing shallow mode.
> 

In short or just to summarize in one line, just use "freeze"(a.k.a
suspend-to-idle suspend mode)

-- 
Regards,
Sudeep
