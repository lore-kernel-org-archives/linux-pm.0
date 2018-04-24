From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/3] cpufreq: dt: Allow platforms to provide suspend/resume
 hooks
Date: Tue, 24 Apr 2018 15:09:44 +0530
Message-ID: <cover.1524561482.git.viresh.kumar@linaro.org>
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
To: Rafael Wysocki <rjw@rjwysocki.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

These patches are already tested by Miquel and are ready to get merged.
Please pick them as part of 4.18 stuff whenever you do that.

I have updated the cpufreq-dt driver to allow platform specific
suspend/resume hooks and done some minor cleanup in the driver. I have
updated Miquel's patch and applied that on top of all this.

Thanks.

V2->V3:
- Don't double put the clock.
- Fix commit log of 3/3.
- Add tested-by from Miquel.
- There was no V2 of 1-2/3 but only 3/3 on the lists. All are marked as
  V3 to clear things out.

--
viresh

[1] https://lkml.kernel.org/r/20180421141943.25705-1-miquel.raynal@bootlin.com

Miquel Raynal (1):
  cpufreq: add suspend/resume support in Armada 37xx DVFS driver

Viresh Kumar (2):
  cpufreq: dt: Allow platform specific suspend/resume callbacks
  cpufreq: armada: Free resources on error paths

 drivers/cpufreq/armada-37xx-cpufreq.c | 100 +++++++++++++++++++++++++++++-----
 drivers/cpufreq/cpufreq-dt.c          |  10 +++-
 drivers/cpufreq/cpufreq-dt.h          |   5 ++
 3 files changed, 100 insertions(+), 15 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
