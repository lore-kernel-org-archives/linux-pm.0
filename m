From: Roger Shimizu <rogershimizu@gmail.com>
Subject: Re: [PATCH v3 1/3] power: reset: add linkstation-reset driver
Date: Tue, 3 Jan 2017 23:08:53 +0900
Message-ID: <CAEQ9gE=MoQcr3eX0DAxZtvx0FW9pzgkUGjdxKHcsKwH7_+UsUw@mail.gmail.com>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
 <20161227070611.14852-2-rogershimizu@gmail.com>
 <fff132e9-a178-6948-676e-6a4d24b6c4d6@gmail.com>
 <20170103130916.GA30197@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170103130916.GA30197@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, Ryan Tandy <ryan@nardis.ca>, linux-pm@vger.kernel.org, Herbert Valerio Riedel <hvr@gnu.org>, Martin Michlmayr <tbm@cyrius.com>, linux-arm-kernel@lists.infradead.org, Sylver Bruneau <sylver.bruneau@googlemail.com>
List-Id: linux-pm@vger.kernel.org

Dear Florian, Andrew,

Thanks for your email!

On Tue, Jan 3, 2017 at 2:19 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Interestingly, I submitted a patch doing nearly the same thing recently
> after hacking on a Buffalo Terastation Pro II two days after yours
> without seeing yours:
>
> https://lkml.org/lkml/2016/12/28/273

Glad to know there's other developer working on linkstation/kurobox platform!

> Some comments below.
>
>> +
>> +static void __iomem *base;
>> +static unsigned long tclk;
>> +static const struct reset_cfg *cfg;
>
> How about avoiding the singletons here and pass this down from the
> platform driver's private data after we (see below) also make use of a
> reboot notifier?

I see your patches. Indeed, it's a good idea to avoid the singletons
and use private data instead.

>> +static int linkstation_reset_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct resource *res;
>> +     struct clk *clk;
>> +     char symname[KSYM_NAME_LEN];
>> +
>> +     const struct of_device_id *match =
>> +             of_match_node(linkstation_reset_of_match_table, np);
>> +     cfg = match->data;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!res) {
>> +             dev_err(&pdev->dev, "Missing resource");
>> +             return -EINVAL;
>> +     }
>> +
>> +     base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>> +     if (!base) {
>> +             dev_err(&pdev->dev, "Unable to map resource");
>> +             return -EINVAL;
>> +     }
>> +
>> +     /* We need to know tclk in order to calculate the UART divisor */
>> +     clk = devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(clk)) {
>> +             dev_err(&pdev->dev, "Clk missing");
>> +             return PTR_ERR(clk);
>> +     }
>> +
>> +     tclk = clk_get_rate(clk);
>
> Does this work with the Terastation II which has not been converted to
> DT yet? Is tclk available through the CLK API there?

I have no idea whether device-based legacy code and make use of power
reset driver.
Maybe Sebastian Reichel can offer a comment?

However, I think Terastation II should convert to DT first.
If you're willing to test, I can help to provide a dts/dtb.
(If you use Debian, I can even provide DEB of kernel image and
flash-kernel patch, which is easy for you to test)

On Tue, Jan 3, 2017 at 10:09 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > +
>> > +   /* Check that nothing else has already setup a handler */
>> > +   if (pm_power_off) {
>> > +           lookup_symbol_name((ulong)pm_power_off, symname);
>> > +           dev_err(&pdev->dev,
>> > +                   "pm_power_off already claimed %p %s",
>> > +                   pm_power_off, symname);
>> > +           return -EBUSY;
>> > +   }
>> > +   pm_power_off = linkstation_reset;
>>
>> That seems a bit complicated, why not just assume that there will be
>> either this driver used, or not at all?
>
> That is probably my fault. This is a copy from code i wrote many years
> ago for the QNAP. I guess at the time i was battling with two
> different pm_power_off handlers, so put in this code.
>
>> Also, you are supposed to register a reboot notifier to which you can
>> pass private context:
>
> At the time i wrote the QNAP code, this did not exist. So maybe my
> code is no longer a good example to copy.

Really appreciated, Andrew!
I'll modify this part in next series.

BTW. the private data passing to reboot notifier can be shared to
power-off function as well?
Do you have example?

> https://lkml.org/lkml/2016/12/28/275
>
> As indicated in my patch series, the UART1-attached micro controller
> does a lot more things that just providing reboot, which is why I chose
> to move this code to a MFD driver, as the starting point before adding
> support for LEDs, FAN, PWM, beeper which would be other types of devices.
>
> Is adding support for other peripherals on your TODO as well?

Except reset feature (power-off and reboot), other feature, such as
LEDs / FAN speed / buttons, is managed by user-land program micro-evtd
[0][1].
Since the upstream [1] is not active anymore, Ryan Tandy (in CC) and I
are maintaining it in Debian [0].

[0] https://tracker.debian.org/pkg/micro-evtd
[1] https://sourceforge.net/projects/ppc-evtd

micro-evtd worked well for device-based legacy code, but after DT
conversion, Ryan found the device cannot shutdown properly (reboot is
OK).
That why I created this patch series.
I think for such old hardware and mature user-land program, it doesn't
deserve the effort to implement those again in kernel side.
What do you think?

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
