From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: return EEXIST instead of EBUSY for second registering
Date: Fri, 20 Sep 2013 00:37:50 +0200
Message-ID: <11319698.mBBnJVdnIk@vostro.rjw.lan>
References: <1379563520-7221-1-git-send-email-yinghai@kernel.org> <CAKohpomt+sASL=2i-v=HSkhOZhbPmnFesEfPoEqSE+WKcCfnmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomt+sASL=2i-v=HSkhOZhbPmnFesEfPoEqSE+WKcCfnmw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Yinghai Lu <yinghai@kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 19, 2013 09:38:32 AM Viresh Kumar wrote:
> On 19 September 2013 09:35, Yinghai Lu <yinghai@kernel.org> wrote:
> > System that cpu support intel_pstate, acpi_cpufreq fail to
> > load, and udev keep trying until trace get filled up and
> > kernel crash.
> >
> > The root cause is driver return ret from cpufreq_register_driver
> > and when some other driver take over before, it would return
> > EBUSY, then udev will keep trying...
> >
> > cpufreq_register_driver should return EEXIST instead.
> > then system could boot without appending intel_pstate=disable
> > and still use intel_pstate.
> >
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
