From: Georgi Djakov <georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v0 1/2] interconnect: Add generic interconnect controller
 API
Date: Tue, 14 Mar 2017 17:35:57 +0200
Message-ID: <20fa9f6c-22b8-08d0-8fbd-82cbad9acc87@linaro.org>
References: <20170301182235.19154-1-georgi.djakov@linaro.org>
 <20170301182235.19154-2-georgi.djakov@linaro.org>
 <15929d7a-65e5-f8ba-2fac-0381c5f8e8fc@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <15929d7a-65e5-f8ba-2fac-0381c5f8e8fc-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, seansw-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org, davidai-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 03/03/2017 12:53 AM, Randy Dunlap wrote:
> On 03/01/17 10:22, Georgi Djakov wrote:
>>
>> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
>> new file mode 100644
>> index 000000000000..103524b59905
>> --- /dev/null
>> +++ b/drivers/interconnect/Kconfig
>> @@ -0,0 +1,10 @@
>> +menuconfig INTERCONNECT
>> +	bool "On-Chip Interconnect management support"
>
> Why isn't this symbol tristate instead of bool so that the
> interconnect management support can be built as a loadable module?
>

Thanks for the comment! For simplicity, the core API currently is
only supported as a built-in, but we can definitely try making it
modular. I can do it after we get some initial feedback on if and
how this concept fits in the kernel and set the direction we want
to go.

BR,
Georgi

>
>> +	help
>> +	  Support for management of the on-chip interconnects.
>> +
>> +	  This framework is designed to provide a generic interface for
>> +          managing the interconnects in a SoC.
>> +
>> +	  If unsure, say no.
>> +
>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
