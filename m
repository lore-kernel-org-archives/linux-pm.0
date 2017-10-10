From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: dt-platdev: drop socionext,uniphier-ld6b from whitelist
Date: Tue, 10 Oct 2017 17:45:38 +0200
Message-ID: <CAJZ5v0hhh9Bu2LMS1WwaobhiX9fOcsogH8n=1O_CPQaJyH30Nw@mail.gmail.com>
References: <1504021023-12459-1-git-send-email-yamada.masahiro@socionext.com>
 <20170914212655.GD11836@ubuntu> <20171010032525.GE4031@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45539 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932142AbdJJPpj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 11:45:39 -0400
In-Reply-To: <20171010032525.GE4031@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Oct 10, 2017 at 5:25 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 14-09-17, 14:26, Viresh Kumar wrote:
>> On 30-08-17, 00:37, Masahiro Yamada wrote:
>> > As you see arch/arm/boot/dts/uniphier-ld6b.dtsi, it includes
>> > uniphier-pxs2.dtsi, which uses "operating-points-v2" property
>> > and whose cpufreq device is automatically created.
>> >
>> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > ---
>> >
>> >  drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
>> >  1 file changed, 2 deletions(-)
>> >
>> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> > index a020da7940d6..c344fc1c4eb8 100644
>> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> > @@ -83,8 +83,6 @@ static const struct of_device_id whitelist[] __initconst = {
>> >     { .compatible = "rockchip,rk3368", },
>> >     { .compatible = "rockchip,rk3399", },
>> >
>> > -   { .compatible = "socionext,uniphier-ld6b", },
>> > -
>> >     { .compatible = "st-ericsson,u8500", },
>> >     { .compatible = "st-ericsson,u8540", },
>> >     { .compatible = "st-ericsson,u9500", },
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> @Rafael: You missed my Ack while applying this patch ?

No, I had applied it before you acked it, because it was super-obvious. :-)
