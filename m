From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] genirq/timings: Add array suffix computation code
Date: Tue, 26 Mar 2019 16:22:59 +0100
Message-ID: <5ad6f7d7-3081-8eef-1adf-3ce705a1ba94@linaro.org>
References: <20190308212047.28767-1-daniel.lezcano@linaro.org>
 <20190308212047.28767-3-daniel.lezcano@linaro.org>
 <alpine.DEB.2.21.1903241825210.1798@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1903241825210.1798@nanos.tec.linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi Thomas,

thanks for reviewing this patch.

[ ... ]

>> +
>> +/*
>> + * Exponential moving average computation
>> + */
>> +static int irq_timings_ema_new(s64 value, s64 ema_old)
> 
> There is a mixed bag of s64/u64 all over this code. Please stay
> consistent. We had enough sign confusion bugs in the past.

Right.

I have a question, ema_old and value will be always u64 type and the
function irq_timings_ema_new() will return an u64 ...

> 	value = (value - ema_old) * EMA_ALPHA_VAL;
> 	return ema_old + value >> EMA_ALPHA_SHIFT;

... how can I deal with the operations above when value < ema_old ?

Shall I use an intermediate s64 ?

eg:

	s64 aux = (value - ema_old) * EMA_ALPHA_VAL;
	return ema_old + aux >> EMA_ALPHA_SHIFT;
?

[ ... ]

 > Other than that this looks good to me. Nice work!

Thanks, I appreciate.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
