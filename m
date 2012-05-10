From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] ARM: DAVINCI: cpuidle - remove useless state
	count initialization
Date: Thu, 10 May 2012 10:44:44 +0200
Message-ID: <1336639485-26955-2-git-send-email-daniel.lezcano@linaro.org>
References: <1336639485-26955-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1336639485-26955-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nsekhar@ti.com, khilman@ti.com, lenb@kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, linaro-dev@lists.linaro.org, linux-pm@lists.linux-foundation.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

The state count is initialized in the driver structure, the cpuidle
core uses it to initialize the device state count.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-davinci/cpuidle.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 9107691..f0f179c 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -128,8 +128,6 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 		davinci_states[1].flags |= DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN;
 	cpuidle_set_statedata(&device->states_usage[1], &davinci_states[1]);
 
-	device->state_count = DAVINCI_CPUIDLE_MAX_STATES;
-
 	ret = cpuidle_register_driver(&davinci_idle_driver);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register driver\n");
-- 
1.7.5.4
