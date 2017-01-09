From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1.1] ARM: multi_v7_defconfig: Enable power sequence for
 Odroid U3
Date: Mon, 9 Jan 2017 19:38:03 +0200
Message-ID: <CAJKOXPdODg2gCXP-BCRhDZAc2+o1J7Ek9iLaYF7hn_R2mNiK3A@mail.gmail.com>
References: <20170107085203.4431-5-krzk@kernel.org> <20170107091651.10560-1-krzk@kernel.org>
 <d8ee24b1-9d6b-e76f-b5ef-71706efbf9e5@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d8ee24b1-9d6b-e76f-b5ef-71706efbf9e5-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Anand Moon <linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, Markus Reichl <m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 9, 2017 at 6:24 PM, Javier Martinez Canillas
<javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org> wrote:
> Hello Krzysztof,
>
> I think it would had been clearer if the subject prefix was "[PATCH v1.1 4/4]" :)

Ah, yes.

>
> On 01/07/2017 06:16 AM, Krzysztof Kozlowski wrote:
>> Odroid U3 needs a power sequence for lan9730, if it was enabled by
>> bootloader.  Also enable the USB3503 HSCI to USB2.0 driver (device
>> is present on Odroid U3).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>
>> ---
>>
>
> Do you think that makes sense to also enable GPIO_SYS for debugging
> purposes as you do in patch 3/4?

I like the GPIO_SYSFS interface because it is easy to use. However
now, after your question, I found this:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/470154.html
ARM/ARM64: defconfig: drop GPIO_SYSFS on multiplatforms

... so instead I will drop it from exynos_defconfig.

Best regards,
Krzysztof
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
