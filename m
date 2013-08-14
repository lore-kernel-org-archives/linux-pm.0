From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH] cpufreq: add frequency table to at32ap driver
Date: Wed, 14 Aug 2013 08:07:18 +0200
Message-ID: <20130814060718.GA6539@samfundet.no>
References: <1376334657-23578-1-git-send-email-egtvedt@samfundet.no>
 <CAKohpokCsCLS=8FNZpUBgEVi7YropyR4UoLC9XNN+rs5xuigMw@mail.gmail.com>
 <CAKohponh4tW8j3qk7eP9YnfXufutNkK-+iCQRvqSUC2=GwvqeA@mail.gmail.com>
 <20130813065208.GB7055@samfundet.no>
 <CAKohponXSvxQwyx7YJYbcQHD8X2F=EuFpFd31DR5HY3JjvS+rQ@mail.gmail.com>
 <20130813090613.GA1850@samfundet.no>
 <CAKohpokqMt2L_r3WR=vTPyW0kUS5wZ8FxS3ii=B=H=Yizuu=ig@mail.gmail.com>
 <CAKohpomya5EcqRabz7k=eT_vMdb5yuMCbk0vJuY7fLwpCZbc-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpomya5EcqRabz7k=eT_vMdb5yuMCbk0vJuY7fLwpCZbc-A@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

Around Tue 13 Aug 2013 19:00:22 +0530 or thereabout, Viresh Kumar wrote:
> On 13 August 2013 14:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Yes, that's what.. That generic routine can be used instead of your .verify()..
> 
> So here is a patch for that which I will include in my original series. It uses
> functions from this patch:
> 
> http://www.kernelhub.org/?msg=309940&p=2

Great. Is there anything left for the at32ap cpufreq driver?

> -----------x-------------------x---------------------
> 
> commit e02892f73f8f669b265310e51a677c7253e32389
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Fri Aug 9 12:05:56 2013 +0530
> 
>     cpufreq: at32ap: Use generic cpufreq routines
> 
>     Most of the CPUFreq drivers do similar things in .exit() and
> .verify() routines
>     and .attr. So its better if we have generic routines for them
> which can be used
>     by cpufreq drivers then.
> 
>     This patch uses these generic routines for this driver.
> 
>     Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/cpufreq/at32ap-cpufreq.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
