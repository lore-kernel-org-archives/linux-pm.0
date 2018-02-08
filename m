From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: remove at32ap-cpufreq
Date: Thu, 08 Feb 2018 11:16:21 +0100
Message-ID: <1921177.y5JRJ3llXq@aspire.rjw.lan>
References: <20180118200202.11883-1-clabbe.montjoie@gmail.com> <20180119054441.GM3012@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180119054441.GM3012@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, January 19, 2018 6:44:41 AM CET Viresh Kumar wrote:
> On 18-01-18, 21:02, Corentin Labbe wrote:
> > Since AVR32 arch was removed, at32ap-cpufreq is useless.
> > Remove this driver.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  drivers/cpufreq/Kconfig          |  10 ---
> >  drivers/cpufreq/Makefile         |   1 -
> >  drivers/cpufreq/at32ap-cpufreq.c | 127 ---------------------------------------
> >  3 files changed, 138 deletions(-)
> >  delete mode 100644 drivers/cpufreq/at32ap-cpufreq.c
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!
