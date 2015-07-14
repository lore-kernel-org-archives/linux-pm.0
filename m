From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PM / Domains: Correct unit address in power-controller example
Date: Tue, 14 Jul 2015 16:28:29 +0200
Message-ID: <CAJZ5v0hTk7+ib9gHtyx4h80Pr7evDWxHx-VT_PNf75emEucH-g@mail.gmail.com>
References: <1430748804-7586-1-git-send-email-geert+renesas@glider.be>
	<CAMuHMdXwOVMt2HR+Y4jB0LeCPWPfPgR4A+qEzyoWWd0hMNBj=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f67.google.com ([74.125.82.67]:32904 "EHLO
	mail-wg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbGNO2a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 10:28:30 -0400
Received: by wgwk7 with SMTP id k7so905107wgw.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2015 07:28:29 -0700 (PDT)
In-Reply-To: <CAMuHMdXwOVMt2HR+Y4jB0LeCPWPfPgR4A+qEzyoWWd0hMNBj=w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>

Hi Geert,

On Tue, Jul 14, 2015 at 2:03 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> ping?

Am I supposed to take this?


> On Mon, May 4, 2015 at 4:13 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> In example 2 of the generic PM domains DT bindings, the unit address of
>> the device node representing the child power controller doesn't match
>> its "reg" property. Correct it.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Acked-by: Kevin Hilman <khilman@linaro.org>
>> ---
>> v2:
>>   - Add Acked-by
>> ---
>>  Documentation/devicetree/bindings/power/power_domain.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>> index d6505bef655dc2df..32d1d3a399fe2a48 100644
>> --- a/Documentation/devicetree/bindings/power/power_domain.txt
>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>> @@ -56,7 +56,7 @@ Example 2:
>>                 #power-domain-cells = <1>;
>>         };
>>
>> -       child: power-controller@12340000 {
>> +       child: power-controller@12341000 {
>>                 compatible = "foo,power-controller";
>>                 reg = <0x12341000 0x1000>;
>>                 power-domains = <&parent 0>;
>> --
>> 1.9.1
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
