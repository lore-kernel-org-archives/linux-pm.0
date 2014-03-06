From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 3/3] cpufreq: initialize governor for a new policy under policy->rwsem
Date: Thu, 06 Mar 2014 13:34:43 +0100
Message-ID: <4694302.3z6tDHSNGj@vostro.rjw.lan>
References: <98b7ae22d936456bf830aa749556a115969cfa47.1393904428.git.viresh.kumar@linaro.org> <1892466.Txf61ZRumM@vostro.rjw.lan> <CAKohponJrsrFiugxALugZu3AKtD2i-Tk3NjeFM3KhXSoKgtLXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponJrsrFiugxALugZu3AKtD2i-Tk3NjeFM3KhXSoKgtLXg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, March 06, 2014 10:24:38 AM Viresh Kumar wrote:
> On 6 March 2014 09:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > I've rebased this one on top of 3.14-rc5 and queued it up for 3.14-rc6.
> >
> > Please check the bleeding-edge branch for the result.
> 
> Yeah, it looks fine. And I assume that you are planning to take 1/3 in 3.15?
> Or going to drop it?

I'm going to queue it up for 3.15.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
