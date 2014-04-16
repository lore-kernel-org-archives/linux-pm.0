From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq, powernv: Fix build failure on UP
Date: Wed, 16 Apr 2014 11:18:13 +0530
Message-ID: <534E199D.2090504@linux.vnet.ibm.com>
References: <20140415141111.GA28352@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20140415141111.GA28352@windriver.com>
Sender: linux-next-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com, linux-next@vger.kernel.org, rafael.j.wysocki@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04/15/2014 07:41 PM, Paul Gortmaker wrote:
> Hi all,
> 
> This new driver is causing build fails on linux-next for non-SMP.
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/10911507/
> 
> I didn't bisect since there are only two commits in total.  :)
> 
> Looks like some header foo where <linux/smp.h> is not getting <asm/smp.h>
> 

Hi Paul,

Thanks a lot for reporting the build failure. Please find the fix
below.
 
Regards,
Srivatsa S. Bhat

---------------------------------------------------------------------------

From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq, powernv: Fix build failure on UP

Paul Gortmaker reported the following build failure of the powernv cpufreq
driver on UP configs:

drivers/cpufreq/powernv-cpufreq.c:241:2: error: implicit declaration of
function 'cpu_sibling_mask' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[3]: *** [drivers/cpufreq/powernv-cpufreq.o] Error 1
make[2]: *** [drivers/cpufreq] Error 2
make[1]: *** [drivers] Error 2
make: *** [sub-make] Error 2

The trouble here is that cpu_sibling_mask is defined only in <asm/smp.h>, and
<linux/smp.h> includes <asm/smp.h> only in SMP builds.

So fix this build failure by explicitly including <asm/smp.h> in the driver,
so that we get the definition of cpu_sibling_mask even in UP configurations.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/cpufreq/powernv-cpufreq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 9edccc6..ed1c7e5 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -29,6 +29,7 @@
 
 #include <asm/cputhreads.h>
 #include <asm/reg.h>
+#include <asm/smp.h>
 
 #define POWERNV_MAX_PSTATES	256
 
