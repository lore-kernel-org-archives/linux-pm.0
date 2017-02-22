From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
Date: Wed, 22 Feb 2017 14:35:37 +0000
Message-ID: <a2e09969-3a67-6947-4dd8-2a153d1f48e7@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <20170221110712.GB5021@amd> <de2a15d4-9ac2-9ba9-a47a-eacbf478f601@arm.com>
 <CAMuHMdVmu4AYZ6MZHd79N2-2gELR6s3oZ46UnEszCfLvHymY1w@mail.gmail.com>
 <3caf0f3f-76e5-cb1e-7c0f-87ed5e1c2b86@arm.com>
 <CAMuHMdU0fTtEXN9k477e3S-UUMNhd=U4_r0VOcyA1TGEgA5rmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU0fTtEXN9k477e3S-UUMNhd=U4_r0VOcyA1TGEgA5rmA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 22/02/17 13:47, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Tue, Feb 21, 2017 at 6:22 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

>>
>> IIUC, it's not implemented today. I can't talk about future ;), but your
> 
> Good, so there's no need for the DT property, and drivers/firmware/psci.c
> should aways call do_cpu_idle() instead of PSCI SYSTEM_SUSPEND if any
> other wake-up sources are configured?
> 

No.

> That follows the principle of least surprise: it doesn't leave the user with
> a system that won't wake up the way he configured it to wake up.
> 

But he can still wake up with the "switch" so there's no surprise. He
just need to better understand his system before playing with it ;)

-- 
Regards,
Sudeep
