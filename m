From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] genirq/timings: Add array suffix computation code
Date: Tue, 26 Mar 2019 17:04:28 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1903261702320.1789@nanos.tec.linutronix.de>
References: <20190308212047.28767-1-daniel.lezcano@linaro.org> <20190308212047.28767-3-daniel.lezcano@linaro.org> <alpine.DEB.2.21.1903241825210.1798@nanos.tec.linutronix.de> <5ad6f7d7-3081-8eef-1adf-3ce705a1ba94@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5ad6f7d7-3081-8eef-1adf-3ce705a1ba94@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Daniel,

On Tue, 26 Mar 2019, Daniel Lezcano wrote:
> >> +/*
> >> + * Exponential moving average computation
> >> + */
> >> +static int irq_timings_ema_new(s64 value, s64 ema_old)
> > 
> > There is a mixed bag of s64/u64 all over this code. Please stay
> > consistent. We had enough sign confusion bugs in the past.
> 
> Right.
> 
> I have a question, ema_old and value will be always u64 type and the
> function irq_timings_ema_new() will return an u64 ...
> 
> > 	value = (value - ema_old) * EMA_ALPHA_VAL;
> > 	return ema_old + value >> EMA_ALPHA_SHIFT;
> 
> ... how can I deal with the operations above when value < ema_old ?
> 
> Shall I use an intermediate s64 ?
> 
> eg:
> 
> 	s64 aux = (value - ema_old) * EMA_ALPHA_VAL;
> 	return ema_old + aux >> EMA_ALPHA_SHIFT;
> ?

That should work if ema_old is not ever having the topmost bit set :)

Thanks,

	tglx
