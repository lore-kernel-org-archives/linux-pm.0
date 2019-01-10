From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v10 15/15] OPTIONAL: cpufreq: dt: Register an Energy Model
Date: Thu, 10 Jan 2019 09:08:47 +0000
Message-ID: <20190110090845.6eeu326iudgmpdet@queper01-lin>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-16-quentin.perret@arm.com>
 <20190108203813.GS261387@google.com>
 <20190109105757.2rowxn3anzyycuod@queper01-lin>
 <20190109181451.GT261387@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109181451.GT261387@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 09 Jan 2019 at 10:14:51 (-0800), Matthias Kaehlcke wrote:
> I think registering the perf domain only once is fine, since the info
> isn't supposed to change and will likely be used again after
> _exit(). However since we have em_cpu_get() I'd suggest to use it and
> only call em_register_perf_domain() if no perf domain is registered
> yet for the CPU. This makes it more evident that the registration is
> only done once and simplifies error handling (currently not done at
> all), since it's not necessary to check for the special case -EEXIST.

Right, a check on em_cpu_get() on the driver side shouldn't hurt. We
don't actually have upstream drivers using that API yet but I intend to
change that soon. I guess we'll need to have that discussion with each
individual CPUFreq driver maintainer but that hopefully shouldn't be a
problem.

Thanks for the feedback,
Quentin
