From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] drivers: cpuidle: add status property to ARM idle
 states
Date: Mon, 10 Nov 2014 08:45:32 +0100
Message-ID: <54606D1C.3000300@linaro.org>
References: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com> <7hbnp6e81x.fsf@deeprootsystems.com> <20141021162058.GA17610@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141021162058.GA17610-7AyDDHkRsp3ZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chander Kashyap <k.chander-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 10/21/2014 06:20 PM, Lorenzo Pieralisi wrote:
> On Mon, Oct 20, 2014 at 10:38:02PM +0100, Kevin Hilman wrote:
>> Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org> writes:
>>
>>> On some platforms the device tree bindings must provide the kernel
>>> with a status flag for idle states, that defines whether the idle
>>> state is operational or not in the current configuration.
>>>
>>> This patch adds a status property to the ARM idle states compliant
>>> with ePAPR v1.1 and updates the DT parsing code accordingly.
>>>
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
>>
>> For the series:
>>
>> Acked-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Thanks ! I will queue it for 3.19 then.

Applied to my tree for 3.19.

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
