From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpufreq: skip invalid entries when searching the frequency
Date: Wed, 12 Oct 2016 21:34:51 +0200
Message-ID: <5873941.X9i1CsAkCq@vostro.rjw.lan>
References: <10213813.22087-1-aaro.koskinen@iki.fi> <3b0a25515d3dc44d8fbdb91a35eaa13565a204f6.1476241978.git.viresh.kumar@linaro.org> <20161012183303.GA31195@raspberrypi.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161012183303.GA31195@raspberrypi.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 12, 2016 09:33:03 PM Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Oct 12, 2016 at 08:45:05AM +0530, Viresh Kumar wrote:
> > From: Aaro Koskinen <aaro.koskinen@iki.fi>
> > 
> > Skip invalid entries when searching the frequency. This fixes cpufreq
> > at least on loongson2 MIPS board.
> > 
> > Fixes: da0c6dc00c69 ("cpufreq: Handle sorted frequency tables more efficiently")
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V1->V2:
> > - Use cpufreq_frequency_table() instead.
> > 
> > Hi Aaro,
> > 
> > Can you please test this patch instead?
> 
> Seems to work as well.

I'm going to apply this patch then.

Thanks,
Rafael
