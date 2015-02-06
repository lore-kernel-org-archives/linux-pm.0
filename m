From: Stefan Agner <stefan@agner.ch>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Fri, 06 Feb 2015 22:31:41 +0100
Message-ID: <266c7b1ff2d1a8ba0ae4866f4fb4eca5@agner.ch>
References: <54C8E125.3070905@free.fr>
 <e028a4eb604a491f4438557f4a1373ef@agner.ch> <54D52F84.9050600@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <54D52F84.9050600@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, DT <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2015-02-06 22:17, Mason wrote:
> Stefan Agner wrote:
> 
>> Just recently I added support of ARM global timer as clocksource for
>> Vybrid SoC. This SoC doesn't use cpufreq, hence it is safe to use the
>> ARM global timer. The nice thing of device tree is, the patch to add
>> support for that did not change a single line of code:
>>
>> http://thread.gmane.org/gmane.linux.kernel/1794460
> 
> Hello Stefan,
> 
> Your changes are not yet accepted in mainline, are they?
> (I don't see them in 3.18.5)

The changes have been accepted and went upstream in the 3.19 merge
window, see
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=81c4831907fb00efdc97093b09e333009a57d005

> Do you also use the ARM local timers in your port?
> Is there generic code to handle them?

It seems that there has been support for local timers once, but has been
removed. But I'm not aware of the details:
https://lkml.org/lkml/2013/2/22/49

--
Stefan
