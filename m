From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
 params
Date: Fri, 6 Jan 2012 07:18:18 -0800
Message-ID: <20120106151818.GC12530@mgross-G62>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 06, 2012 at 02:36:20AM +0200, Antti P Miettinen wrote:
> The inspiration for this patch series is the N9 CPU frequency boost
> upon input events:
> 
> http://www.spinics.net/lists/cpufreq/msg00667.html
> 
> and the related changes in git://codeaurora.org/kernel/msm.git tree.
> Those patches modify the ondemand cpufreq governor. This patch series
> adds minimum and maximum CPU frequency as PM QoS parameters and
> modifies the cpufreq core to enforce the PM QoS limits. There is also
> an example module for boosting the frequency upon input events.
> 
> I've been testing these changes against Ubuntu 3.2 kernel on a Dell
> E6420 with the ACPI cpufreq driver. The patches are against
> linux-next/master, compile tested against it.

wow, isn't this is timely :)
I was working on the same thing.  I used different names.  FWIW our
issue is motivated by some graphics workloads that get starved for
frames because the cpufreq governor sees nothing by < 50% CPU use so it
pushes the cpu into a low P-state which doesn't have throughput to feed
the next frame of OpenGL data before the next frame time.  This is
pretty common for some graphics workloads.

I look forward to reviewing you path set!

--mark


> 	--Antti
> 
> Alex Frid (1):
>   PM QoS: Simplify PM QoS expansion/merge
> 
> Antti P Miettinen (5):
>   PM QoS: Add CPU frequency min/max as PM QoS params
>   cpufreq: Export user_policy min/max
>   cpufreq: Preserve sysfs min/max request
>   cpufreq: Enforce PM QoS min/max limits
>   input: CPU frequency booster
> 
>  drivers/cpufreq/cpufreq.c     |   57 +++++++++++++-
>  drivers/input/Kconfig         |    9 ++
>  drivers/input/Makefile        |    1 +
>  drivers/input/input-cfboost.c |  174 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_qos.h        |   19 ++++-
>  kernel/power/qos.c            |   55 ++++++++++----
>  6 files changed, 293 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/input/input-cfboost.c
> 
> -- 
> 1.7.4.1
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
