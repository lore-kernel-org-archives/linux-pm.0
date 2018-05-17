From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: brcmstb-avs-cpufreq: sort frequencies in
 ascending order
Date: Thu, 17 May 2018 09:44:48 +0530
Message-ID: <20180517041448.ceh4g5fs2qfqqojm@vireshk-i7>
References: <20180516034954.56475-1-code@mmayer.net>
 <20180516043218.7ktq5vjq2rhcszz5@vireshk-i7>
 <71309e94-90d4-2b58-729b-9ab488c6d554@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <71309e94-90d4-2b58-729b-9ab488c6d554@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Markus Mayer <code@mmayer.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 16-05-18, 12:24, Florian Fainelli wrote:
> On 05/15/2018 09:32 PM, Viresh Kumar wrote:
> > On 15-05-18, 20:49, Markus Mayer wrote:
> >> From: Markus Mayer <mmayer@broadcom.com>
> >>
> >> Most CPUfreq drivers (at least on ARM) seem to be sorting the available
> >> frequencies from lowest to highest. To match this behaviour, we reverse
> >> the sorting order in brcmstb-avs-cpufreq, so it is now also lowest to
> >> highest.
> > 
> > The reasoning isn't correct. Just because everyone else is doing it
> > doesn't make it right and so you shouldn't change just because of
> > that.
> > 
> > What you must written instead in the commit log is that the cpufreq
> > core performs better if the table is sorted (in any order), and so we
> > must sort it as well.
> 
> Is there a reason why set_freq_table_sorted() tries an ascending or
> descending sort, but does not enforce one versus another for all drivers?

set_freq_table_sorted() doesn't sort the frequency table but checks if
the table is already sorted in a particular order. And then
cpufreq_frequency_table_target() is optimized based on this flag. We
don't have to enforce any particular ordering here.

> > But I feel the table is already sorted for your platform, isn't it?
> > And I don't see a clear advantage of merging this patch.
> 
> The patch changes the order to have the lowest to highest, whereas the
> current implementation has them from highest to lowest. From what you
> are saying, it sounds like this is unnecessary, since the sorting is
> already making things efficient enough, so this is just a cosmetic thing?

Right. It shouldn't make any performance improvements.

-- 
viresh
