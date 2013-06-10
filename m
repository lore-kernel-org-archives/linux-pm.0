From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 5/5] cpufreq:boost:Kconfig: Enable boost support at Kconfig
Date: Mon, 10 Jun 2013 15:20:27 +0200
Message-ID: <20130610152027.3133d1ab@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1370502472-7249-6-git-send-email-l.majewski@samsung.com>
 <20130606155815.GB21272@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <20130606155815.GB21272@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

> On Thu, Jun 06, 2013 at 09:07:52AM +0200, Lukasz Majewski wrote:
> > Enable/disable support for BOOST. New flag - CPU_FREQ_BOOST has been
> > defined for that.
> 
> What's the reason for this? Why would you want to not compile-in the
> boosting code?

I think that this flag could be removed and the "boost" could be
compiled-in permanently.

Viresh, what is your opinion?

> 
> Also, at least on x86, even with this feature disabled, the CPU will
> boost by default unless you fiddle with it through the MSRs as root.
> 

So this is a good argument for removing this flag from Kconfig.


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
