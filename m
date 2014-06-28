From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: cpu0: Extend support beyond CPU0
Date: Sat, 28 Jun 2014 22:52:54 +0800
Message-ID: <20140628145253.GB7869@dragon>
References: <cover.1403684824.git.viresh.kumar@linaro.org>
 <e9c0eef07745e561b9d12dcb50c3e2f7eb3e8880.1403684824.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <e9c0eef07745e561b9d12dcb50c3e2f7eb3e8880.1403684824.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: nm@ti.com, linaro-kernel@lists.linaro.org, mturquette@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, t.figa@samsung.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, thomas.ab@samsung.com, linux-arm-msm@vger.kernel.org, arvind.chauhan@arm.com, spk.linux@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 25, 2014 at 02:12:29PM +0530, Viresh Kumar wrote:
> cpufreq-cpu0 driver supports only platforms which have single clock line shared
> among all CPUs.
> 
> We already have platforms where this limitation doesn't hold true.For example on
> Qualcomm's KRAIT all CPUs have separate clock line and so have separate
> policies.
> 
> Instead of adding another driver for this (Stephen just tried that:
> https://lkml.org/lkml/2014/6/24/918), we must reuse cpufreq-cpu0 driver.
> 
> cpufreq-cpu0 must be updated to break the assumption on which it is based (all
> cores sharing clock line) and this patch tries to do exactly that.
> 
> As we don't have standard DT bindings to mention CPUs sharing clock-line, i.e.
> affected_cpus, this patch also have few limitations. Though easy to fix once we
> have proper bindings.
> 
> Limitation: We only supports two types of platforms:
> - All CPUs sharing same clock line, existing user platforms
> - All CPUs have separate clock lines, KRAIT
> 
> And so platforms which have multiple clusters with multiple CPUs per cluster
> aren't supported yet. We need proper bindings for that first.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |   8 +-
>  drivers/cpufreq/Kconfig                            |   5 +-
>  drivers/cpufreq/cpufreq-cpu0.c                     | 280 +++++++++++++--------
>  3 files changed, 190 insertions(+), 103 deletions(-)

Hi Viresh,

Thanks for all the effort on maintaining and improving cpufreq-cpu0
driver.  Your patch rewrote the most part of the driver, so I'd like to
hand over the driver to you.  Please add yourself as the primary person
for MODULE_AUTHOR.

Shawn
