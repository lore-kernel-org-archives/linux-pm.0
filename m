From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
 power
Date: Tue, 21 Feb 2017 18:27:59 +0000
Message-ID: <94167d3a-e005-3af0-d290-a1086684d570@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <69ab75a1-2e04-19e2-d1ad-12ca1cfc7625@arm.com>
 <CAMuHMdWjseO3XSOH2XCbM411Aj12RpdZZbHkpfFUfej58myz5Q@mail.gmail.com>
 <445b2f49-5d15-30af-a431-1c4edcd049a4@arm.com>
 <CAMuHMdUS96tPJRqNxG6sJjvC0LN-FjCeKOm7Zg2V_qMeQ_1QSQ@mail.gmail.com>
 <81df65a9-d2f1-26df-a977-5265feba25a3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <81df65a9-d2f1-26df-a977-5265feba25a3@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Len Brown <len.brown@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 21/02/17 17:51, Sudeep Holla wrote:
> 
> 
> On 21/02/17 17:34, Geert Uytterhoeven wrote:

[...]

>>
>> The SoC can wake-up. It's just not guaranteed that it can wake-up using
>> the wakeup-source configured from Linux. Which wakeup-sources are available
>> depends on the actual PSCI implementation.  It's not specified by the PSCI
>> specification.
>>
>>> Just botching whatever shallow state you can enter on a particular SoC
>>> into standard "mem" state sounds *horrible* to me.
>>
>> That's more or less what /sys/power/mem_sleep does, though.
>>
> 
> OK, I will go through that in detail.
> 

OK, I went through the patch and the main intention is was added.
So I will begin by summarizing my understanding:

A new suspend interface(/sys/power/mem_sleep) is added to allow the
"mem" string in /sys/power/state to represent multiple things that can
be selected.

Before:
A. echo freeze > /sys/power/state ---> Enters s2idle
B. echo mem > /sys/power/state ---> Enters s2r(a.k.a now deep mem sleep)

After:
1. echo freeze > /sys/power/state ---> Enters s2idle still same
2. echo s2idle > /sys/power/mem_sleep
   echo mem > /sys/power/state ---> Also enter s2idle
3. echo deep > /sys/power/mem_sleep
   echo mem > /sys/power/state ---> Also enter s2r(same as [B] above)

Please note I have carefully dropped standby/shallow as we will not
support that state on ARM64 platforms(refer previous discussions for the
same)

Now IIUC, you need 2 above. So, since this new interface allow mem to
mean "s2idle", we need to fix the core to register default suspend_ops
to achieve what you need. And since I now better understand you problem,
you get extra NACK for this series ;)

-- 
Regards,
Sudeep
