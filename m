From: Yi Yang <yi.y.yang@intel.com>
Subject: [PATCH 2.6.24-rc8] cpufreq: fix obvious condition
	statement error
Date: Wed, 23 Jan 2008 07:05:26 +0800
Message-ID: <1201043126.3861.5.camel__14954.5503467836$1201076281$gmane$org@yangyi-dev.bj.intel.com>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: torvalds@linux-foundation.org
Cc: davej@codemonkey.org.uk, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
List-Id: linux-pm@vger.kernel.org

The function __cpufreq_set_policy in file drivers/cpufreq/cpufreq.c
has a very obvious error:

        if (policy->min > data->min && policy->min > policy->max) {
                ret = -EINVAL;
                goto error_out;
        }

This condtion statement is wrong because it returns -EINVAL only if
policy->min is greater than policy->max (in this case, 
"policy->min > data->min" is true for ever.). In fact, it should
return -EINVAL as well if policy->max is less than data->min.

The correct condition should be:

	if (policy->min > data->max || policy->max < data->min) {

The following test result testifies the above conclusion:

Before applying this patch:

[root@yangyi-dev /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
2394000 1596000
[root@yangyi-dev /]# echo 1596000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
[root@yangyi-dev /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
1596000
[root@yangyi-dev /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
1596000
[root@yangyi-dev /]# echo "2000000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
-bash: echo: write error: Invalid argument
[root@yangyi-dev /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
1596000
[root@yangyi-dev /]# echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
[root@yangyi-dev /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
1596000
[root@yangyi-dev /]# echo "1595000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
[root@yangyi-dev /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
1596000
[root@yangyi-dev /]#


After applying this patch:

[root@yangyi-dev /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
2394000 1596000
[root@yangyi-dev /]# echo 1596000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
[root@yangyi-dev /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
1596000
[root@yangyi-dev /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
1596000
[root@localhost /]# echo "2000000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
-bash: echo: write error: Invalid argument
[root@localhost /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
1596000
[root@localhost /]# echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
-bash: echo: write error: Invalid argument
[root@localhost /]# echo "1595000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
-bash: echo: write error: Invalid argument
[root@localhost /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
1596000
[root@localhost /]# echo "1596000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
[root@localhost /]# echo "2394000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
[root@localhost /]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
2394000
[root@localhost /]


Signed-off-by: Yi Yang <yi.y.yang@intel.com>
---
 cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/cpufreq.c	2008-01-23 05:02:28.000000000 +0800
+++ b/drivers/cpufreq/cpufreq.c	2008-01-23 06:11:21.000000000 +0800
@@ -1608,7 +1608,7 @@ static int __cpufreq_set_policy(struct c
 	memcpy(&policy->cpuinfo, &data->cpuinfo,
 				sizeof(struct cpufreq_cpuinfo));
 
-	if (policy->min > data->min && policy->min > policy->max) {
+	if (policy->min > data->max || policy->max < data->min) {
 		ret = -EINVAL;
 		goto error_out;
 	}
