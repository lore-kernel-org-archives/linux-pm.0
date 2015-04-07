From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Subject: Re: [RFC/PATCH 2/4] ARM: shmobile: Add cpuidle_ops for R-Car cpuidle
Date: Tue, 7 Apr 2015 14:56:42 +0900
Message-ID: <5523719A.7060301@renesas.com>
References: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com> <1428292244-2160-3-git-send-email-keita.kobayashi.ym@renesas.com> <20150407015040.GD27486@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150407015040.GD27486@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Simon

Thank you for your feedback.

(2015/04/07 10:50), Simon Horman wrote:

> On Mon, Apr 06, 2015 at 12:50:42PM +0900, Keita Kobayashi wrote:
>> This patch add Core-Standby support for R-Car cpuidle.
>>
>> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> 
> [snip]
> 
>> diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
>> index 6815781..846b8ae 100644
> 
> [snip]
> 
>> +struct cpuidle_ops rcar_cpuidle_ops __initdata = {
>> +	.suspend = rcar_cpuidle_enter,
>> +};
>> +CPUIDLE_METHOD_OF_DECLARE(rcar, "renesas,rcar-idle", &rcar_cpuidle_ops);
>> +#endif
> 
> It seems to me that that renesas,rcar-idle should be documented
> as an enable-method in Documentation/devicetree/bindings/arm/cpus.txt.
> 
> That change could be a separate patch for device tree.

I understand. I will document it.

Regards.
Keita Kobayashi
