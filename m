From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/6] iio/adc/cc10001_adc.c: Fix !HAS_IOMEM build
Date: Mon, 30 Mar 2015 20:40:39 +0100
Message-ID: <5519A6B7.1000706@kernel.org>
References: <1426541230-928-1-git-send-email-richard@nod.at> <1426541230-928-6-git-send-email-richard@nod.at> <550D5772.2010400@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <550D5772.2010400-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 21/03/15 11:35, Jonathan Cameron wrote:
> On 16/03/15 21:27, Richard Weinberger wrote:
>> Fixes:
>> drivers/built-in.o: In function `cc10001_adc_probe':
>> cc10001_adc.c:(.text+0x412e92): undefined reference to `devm_ioremap_resource'
>>
>> Signed-off-by: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
> Applied to the fixes-togreg branch of iio.git.
> Won't push this out for a day or so as waiting for Greg to pull the previous set.
>> ---
>>  drivers/iio/adc/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 202daf8..46379b1 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -137,7 +137,8 @@ config AXP288_ADC
>>  
>>  config CC10001_ADC
>>  	tristate "Cosmic Circuits 10001 ADC driver"
>> -	depends on HAS_IOMEM || HAVE_CLK || REGULATOR
>> +	depends on HAVE_CLK || REGULATOR
>> +	depends on HAS_IOMEM
>>  	select IIO_BUFFER
>>  	select IIO_TRIGGERED_BUFFER
>>  	help
>>
Hmm. Just noticed this whilst sending the pull request.  That
HAVE_CLK || REGULATOR also seems rather implausible!

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
