From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
Date: Tue, 12 Feb 2019 11:32:29 -0800
Message-ID: <20190212193229.GT117604@google.com>
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
 <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
 <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Lukasz Luba <l.luba@partner.samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, joel@joelfernandes.org, chris.diamand@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Feb 12, 2019 at 02:46:24PM +0900, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
> > This patch set changes workqueue related features in devfreq framework.
> > First patch switches to delayed work instead of deferred.
> > The second switches to regular system work and deletes custom 'devfreq'.
> > 
> > Using deferred work in this context might harm the system performance.
> > When the CPU enters idle, deferred work is not fired. The devfreq device's
> > utilization does not have to be connected with a particular CPU.
> > The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
> > They all are missing opportunity to check the HW state and react when
> > the deferred work is not fired.
> > A corner test case, when Dynamic Memory Controller is utilized by CPUs running
> > on full speed, might show x5 worse performance if the crucial CPU is in idle.
> 
> The devfreq framework keeps the balancing between performance
> and power-consumption. It is wrong to focus on only either
> performance or power.
> 
> This cover-letter focus on the only performance without any power-consumption
> disadvantages. It is easy to raise the performance with short sampling rate
> with polling modes. To get the performance, it is good as short as possible
> of period.
> 
> Sometimes, when cpu is idle, the device might require the busy state.
> It is very difficult to catch the always right timing between them.
> 
> Also, this patch cannot prevent the unneeded wakeup from idle state.
> Apparently, it only focuses on performance without considering
> the power-consumption disadvantage. In the embedded device,
> the power-consumption is very important point. We can not ignore
> the side effect.
> 
> Always, I hope to improve the devfreq framwork more that older.
> But, frankly, it is difficult to agree because it only consider
> the performance without considering the side-effect.
> 
> The power management framework always have to consider
> the power-consumption issue. This point is always true.

I missed the impact of forcing a CPU out of an idle state and/or not
allowing it to enter a more power efficient state. I agree that this
should be avoided.

I wonder if using a power-efficient workqueue could help here:

  Instead of running work on the local CPU, the workqueue core asks the
  scheduler to provide the target CPU for the work queued on unbound
  workqueues (which includes those marked as power-efficient). So they
  will not get pinned on a single CPU as can happen with regular
  workqueues.

  https://lwn.net/Articles/731052/


Since this series also changes from a custom to system workqueue it
seems worth to mention that there are power-efficient system workqueues:

system_power_efficient_wq
system_freezable_power_efficient_wq


In case a power-efficient workqueue is suitable in principle there
would still be a problem though: the feature is currently disabled by
default, hence devfreq couldn't really rely on it. It is enabled in
the arm64 defconfig though, so at least devices on this architecture
would benefit from it. Also power-efficient workqueues might be
enabled by default in the future as the scheduler becomes more energy
aware.

Cheers

Matthias
