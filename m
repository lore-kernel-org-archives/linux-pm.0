From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 211/228] cpufreq: tegra: remove calls to cpufreq_notify_transition()
Date: Sun, 15 Sep 2013 07:05:48 +0200
Message-ID: <32077984.uYNhUh2ogt@vostro.rjw.lan>
References: <cover.1379063063.git.viresh.kumar@linaro.org> <52339729.7030309@wwwdotorg.org> <CAKohpono-J-Ohzdn=pbNK+HhXhJ2Lf-UBM7OPynTgAwxLd4F4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpono-J-Ohzdn=pbNK+HhXhJ2Lf-UBM7OPynTgAwxLd4F4A@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, September 14, 2013 09:39:31 AM Viresh Kumar wrote:
> On 14 September 2013 04:22, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > I wonder if this series is bisectable? Perhaps I should just go and read
> > the rest of the series, but I presume there's a patch somewhere else
> > that adds those two cpufreq_notify_transition() to the cpufreq core.
> > Either that happens before this patch (in which case listeners will get
> > two notifications each time; perhaps that is safe?), or after this patch
> > (in which case with just this patch applied, no notifications will be
> > sent until a later patch!
> 
> Hmm.. Good Catch..
> 
> So, yes git bisect would be compilable but not runnable.. As we are
> already serialized notifications and so two PRE notifications will
> generate a crash..
> 
> But I don't want to get all that in a single patch as that would be:
> 
>  40 files changed, 192 insertions(+), 623 deletions(-)
> 
> And that would be hard to review it..
> 
> Any suggestions?

Well, I guess you can assume that everyone has a chance to review the series
by now and send it as one patch in the next iteration.

A patch that adds 192 lines of code isn't shockingly large by any measure.

Thanks,
Rafael

