From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/2] cpufreq: Stop validating cpufreq table in drivers
Date: Tue,  3 Apr 2018 15:37:37 +0530
Message-ID: <cover.1522749887.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

Most of the patches from the previous series are already applied but we
didn't remove the cpufreq_table_validate_and_show() helper yet as the
scmi driver came from a different tree than PM.

These can be applied over 4.17-rc1 (that would come out after a week),
currently based off linux next.

Viresh Kumar (2):
  cpufreq: scmi: Don't validate the frequency table twice
  cpufreq: Drop cpufreq_table_validate_and_show()

 Documentation/cpu-freq/core.txt        | 12 +++++-------
 Documentation/cpu-freq/cpu-drivers.txt |  6 ++----
 drivers/cpufreq/freq_table.c           | 14 --------------
 drivers/cpufreq/scmi-cpufreq.c         | 10 +---------
 include/linux/cpufreq.h                |  2 --
 5 files changed, 8 insertions(+), 36 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
