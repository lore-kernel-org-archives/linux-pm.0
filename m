From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] cpufreq: do not mark s3c2410_plls_add as __init
Date: Wed, 18 Nov 2015 09:44:48 +0900
Message-ID: <564BCA00.3040906@samsung.com>
References: <8497197.sYxqVOch7s@wuerfel> <4389196.cuM78vZZnJ@wuerfel>
 <564A899C.4040402@samsung.com> <4654010.UfKTsDKyes@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4654010.UfKTsDKyes@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 17.11.2015 18:01, Arnd Bergmann wrote:
> On Tuesday 17 November 2015 10:57:48 Krzysztof Kozlowski wrote:
>> On 17.11.2015 07:17, Arnd Bergmann wrote:
>>> On Monday 16 November 2015 23:36:42 Rafael J. Wysocki wrote:
>>>>
>>>> This should go in through the Samsung tree, so I'll leave it for them to pick
>>>> it up (at least for the time being).
>>>
>>> Ok, fair enough. Kukjin or Krzysztof, can you pick this up?
>>
>> Sure.
>>
>> As for the patch I think everything can be converted to init/initdata
>> (as in attachment).
>>
> 
> I don't think so:
> 
> static struct subsys_interface s3c2442_plls169344_interface __initdata = {
>         .name           = "s3c2442_plls169344",
>         .subsys         = &s3c2442_subsys,
>         .add_dev        = s3c2440_plls169344_add,
> };
> 
> This gets passed into subsys_interface_register(), which is not __init
> in turn. subsys_interface_register() then goes on to add
> s3c2442_plls169344_interface into a linked list that is traversed
> at runtime, but the __initdata section gets discarded so you now
> have a broken list.

Ah, yes, so the patch is fine:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
