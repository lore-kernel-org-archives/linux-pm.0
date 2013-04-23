From: John Blackwood <john.blackwood@ccur.com>
Subject: [PATCH] cpufreq_conservative: initialize the cpu_dbs_info_s cpu field
Date: Tue, 23 Apr 2013 09:41:55 -0500
Message-ID: <51769DB3.7030404@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In the cpufreq conservative module, the cpu field in the cpu_dbs_info_s
structure was not being initialized, and thus all cpus were scheduling
their do_dbs_timer() delayed work processing on cpu 0.

Signed-off-by: John Blackwood <john.blackwood@ccur.com>
Index: b/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -506,6 +506,7 @@ static int cpufreq_governor_dbs(struct c
  		}
  		this_dbs_info->down_skip = 0;
  		this_dbs_info->requested_freq = policy->cur;
+		this_dbs_info->cpu = cpu;

  		mutex_init(&this_dbs_info->timer_mutex);
  		dbs_enable++;
