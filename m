From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/34] cpufreq: cris: remove calls to
 cpufreq_notify_transition()
Date: Tue, 10 Oct 2017 14:43:01 +0530
Message-ID: <20171010091301.GH4031@vireshk-i7>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
 <d8b7b00908f0fa16feca841b1bf7fb1a49c62df1.1376619363.git.viresh.kumar@linaro.org>
 <20171010075742.GL17578@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171010075742.GL17578@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jesper Nilsson <jespern@axis.com>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel <linux-cris-kernel@axis.com>
List-Id: linux-pm@vger.kernel.org

On 10-10-17, 09:57, Jesper Nilsson wrote:
> On Fri, Aug 16, 2013 at 04:25:04AM +0200, Viresh Kumar wrote:
> > Most of the drivers do following in their ->target_index() routines:
> > 
> > 	struct cpufreq_freqs freqs;
> > 	freqs.old = old freq...
> > 	freqs.new = new freq...
> > 
> > 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> > 
> > 	/* Change rate here */
> > 
> > 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> > 
> > This is replicated over all cpufreq drivers today and there doesn't exists a
> > good enough reason why this shouldn't be moved to cpufreq core instead.
> > 
> > Earlier patches have added support in cpufreq core to do cpufreq notification on
> > frequency change, this one removes it from this driver.
> > 
> > Some related minor cleanups are also done along with it.
> > 
> 
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

Wow..

You just Acked a 4 years old patch :)

-- 
viresh
