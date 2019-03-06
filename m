From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH 0/2] PM / Domains: Support enter deepest state during suspend
 and probe failure
Date: Wed, 6 Mar 2019 13:35:16 +0000
Message-ID: <1551878926-8455-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Currently the generic power domain will power off the domain if all
devices in it have been stopped during system suspend.

It is done by checking if the domain is active in genpd_sync_power_off,
then disable it. However, for power domains supporting multiple low power
states, it may have already entered an intermediate low power state by
runtime PM before system suspend and the status is already
GPD_STATE_POWER_OFF which results in then the power domain stay at an
intermediate low power state during system suspend.
Then genpd_sync_power_off will keep it at the low power state instead
of completely gate off it.

And for the probe failture case, if there's no devices using it, we can
fully gate off the domain instead of enter an intermediate state.

Dong Aisheng (2):
  PM / Domains: Support enter deepest state for multiple states domains
  PM / Domains: Choose the deepest state to enter if no devices using it

 drivers/base/power/domain.c | 22 +++++++++++++++++++++-
 include/linux/pm_domain.h   |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.7.4
