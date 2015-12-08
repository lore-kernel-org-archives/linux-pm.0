From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v5 03/11] ARM: multi_v7_defconfig: Enable support for PWM
 Regulators
Date: Tue,  8 Dec 2015 14:31:56 +0000
Message-ID: <1449585124-15596-4-git-send-email-lee.jones@linaro.org>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, Lee Jones <lee.jones@linaro.org>, ajitpal.singh@st.com, maxime.coquelin@st.com
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f62dcb1..648ef57 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -434,7 +434,7 @@ CONFIG_REGULATOR_MAX77693=m
 CONFIG_REGULATOR_MAX77802=m
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PBIAS=y
-CONFIG_REGULATOR_PWM=m
+CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPM=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_S2MPS11=y
-- 
1.9.1
