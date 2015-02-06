From: Mason <mpeg.blue@free.fr>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Fri, 06 Feb 2015 13:17:56 -0800
Message-ID: <54D52F84.9050600@free.fr>
References: <54C8E125.3070905@free.fr> <e028a4eb604a491f4438557f4a1373ef@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <e028a4eb604a491f4438557f4a1373ef@agner.ch>
Sender: cpufreq-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, DT <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Stefan Agner wrote:

> Just recently I added support of ARM global timer as clocksource for
> Vybrid SoC. This SoC doesn't use cpufreq, hence it is safe to use the
> ARM global timer. The nice thing of device tree is, the patch to add
> support for that did not change a single line of code:
>
> http://thread.gmane.org/gmane.linux.kernel/1794460

Hello Stefan,

Your changes are not yet accepted in mainline, are they?
(I don't see them in 3.18.5)

Do you also use the ARM local timers in your port?
Is there generic code to handle them?

Regards.

