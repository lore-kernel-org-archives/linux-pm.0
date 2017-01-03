From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] power: reset: add linkstation-reset driver
Date: Tue, 3 Jan 2017 10:39:05 -0800
Message-ID: <37480c0b-0539-a214-d863-02bf82cdddb9@gmail.com>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
 <20161227070611.14852-2-rogershimizu@gmail.com>
 <fff132e9-a178-6948-676e-6a4d24b6c4d6@gmail.com>
 <20170103130916.GA30197@lunn.ch>
 <CAEQ9gE=MoQcr3eX0DAxZtvx0FW9pzgkUGjdxKHcsKwH7_+UsUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEQ9gE=MoQcr3eX0DAxZtvx0FW9pzgkUGjdxKHcsKwH7_+UsUw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Shimizu <rogershimizu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, Sylver Bruneau <sylver.bruneau-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Herbert Valerio Riedel <hvr-mXXj517/zsQ@public.gmane.org>, Ryan Tandy <ryan-pRYBVO4bdZ33fQ9qLvQP4Q@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 01/03/2017 06:08 AM, Roger Shimizu wrote:
> Dear Florian, Andrew,
> 
> Thanks for your email!
> 
> On Tue, Jan 3, 2017 at 2:19 PM, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> Interestingly, I submitted a patch doing nearly the same thing recently
>> after hacking on a Buffalo Terastation Pro II two days after yours
>> without seeing yours:
>>
>> https://lkml.org/lkml/2016/12/28/273
> 
> Glad to know there's other developer working on linkstation/kurobox platform!
> 
>> Some comments below.
>>
>>> +
>>> +static void __iomem *base;
>>> +static unsigned long tclk;
>>> +static const struct reset_cfg *cfg;
>>
>> How about avoiding the singletons here and pass this down from the
>> platform driver's private data after we (see below) also make use of a
>> reboot notifier?
> 
> I see your patches. Indeed, it's a good idea to avoid the singletons
> and use private data instead.
> 
>>> +static int linkstation_reset_probe(struct platform_device *pdev)
>>> +{
>>> +     struct device_node *np = pdev->dev.of_node;
>>> +     struct resource *res;
>>> +     struct clk *clk;
>>> +     char symname[KSYM_NAME_LEN];
>>> +
>>> +     const struct of_device_id *match =
>>> +             of_match_node(linkstation_reset_of_match_table, np);
>>> +     cfg = match->data;
>>> +
>>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +     if (!res) {
>>> +             dev_err(&pdev->dev, "Missing resource");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>>> +     if (!base) {
>>> +             dev_err(&pdev->dev, "Unable to map resource");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     /* We need to know tclk in order to calculate the UART divisor */
>>> +     clk = devm_clk_get(&pdev->dev, NULL);
>>> +     if (IS_ERR(clk)) {
>>> +             dev_err(&pdev->dev, "Clk missing");
>>> +             return PTR_ERR(clk);
>>> +     }
>>> +
>>> +     tclk = clk_get_rate(clk);
>>
>> Does this work with the Terastation II which has not been converted to
>> DT yet? Is tclk available through the CLK API there?
> 
> I have no idea whether device-based legacy code and make use of power
> reset driver.
> Maybe Sebastian Reichel can offer a comment?
> 
> However, I think Terastation II should convert to DT first.
> If you're willing to test, I can help to provide a dts/dtb.
> (If you use Debian, I can even provide DEB of kernel image and
> flash-kernel patch, which is easy for you to test)
> 
> On Tue, Jan 3, 2017 at 10:09 PM, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> wrote:
>>>> +
>>>> +   /* Check that nothing else has already setup a handler */
>>>> +   if (pm_power_off) {
>>>> +           lookup_symbol_name((ulong)pm_power_off, symname);
>>>> +           dev_err(&pdev->dev,
>>>> +                   "pm_power_off already claimed %p %s",
>>>> +                   pm_power_off, symname);
>>>> +           return -EBUSY;
>>>> +   }
>>>> +   pm_power_off = linkstation_reset;
>>>
>>> That seems a bit complicated, why not just assume that there will be
>>> either this driver used, or not at all?
>>
>> That is probably my fault. This is a copy from code i wrote many years
>> ago for the QNAP. I guess at the time i was battling with two
>> different pm_power_off handlers, so put in this code.
>>
>>> Also, you are supposed to register a reboot notifier to which you can
>>> pass private context:
>>
>> At the time i wrote the QNAP code, this did not exist. So maybe my
>> code is no longer a good example to copy.
> 
> Really appreciated, Andrew!
> I'll modify this part in next series.
> 
> BTW. the private data passing to reboot notifier can be shared to
> power-off function as well?
> Do you have example?
> 
>> https://lkml.org/lkml/2016/12/28/275
>>
>> As indicated in my patch series, the UART1-attached micro controller
>> does a lot more things that just providing reboot, which is why I chose
>> to move this code to a MFD driver, as the starting point before adding
>> support for LEDs, FAN, PWM, beeper which would be other types of devices.
>>
>> Is adding support for other peripherals on your TODO as well?
> 
> Except reset feature (power-off and reboot), other feature, such as
> LEDs / FAN speed / buttons, is managed by user-land program micro-evtd
> [0][1].
> Since the upstream [1] is not active anymore, Ryan Tandy (in CC) and I
> are maintaining it in Debian [0].
> 
> [0] https://tracker.debian.org/pkg/micro-evtd
> [1] https://sourceforge.net/projects/ppc-evtd
> 
> micro-evtd worked well for device-based legacy code, but after DT
> conversion, Ryan found the device cannot shutdown properly (reboot is
> OK).
> That why I created this patch series.
> I think for such old hardware and mature user-land program, it doesn't
> deserve the effort to implement those again in kernel side.
> What do you think?

An argument could be made that these are hardware peripherals, and so
the kernel is the best place to abstract support for that, and present
you with the standard device drive model for such kind of peripherals.

We don't have to do everything at the same time, so first things first,
get the reboot working, have me convert the Terastation over to Device
Tree and then we can decide what to do with these additional peripherals.

Thanks!
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
