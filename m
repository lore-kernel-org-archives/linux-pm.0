From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] cpufreq: brcmstb-avs-cpufreq: remove unnecessary
 platform_set_drvdata()
Date: Tue,  7 Feb 2017 15:56:45 +0000
Message-ID: <20170207155645.5455-1-weiyj.lk@gmail.com>
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
To: Markus Mayer <mmayer@broadcom.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index c943606..7281a2c 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -878,7 +878,6 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
 	iounmap(priv->avs_intr_base);
 unmap_base:
 	iounmap(priv->base);
-	platform_set_drvdata(pdev, NULL);
 
 	return ret;
 }
@@ -1042,7 +1041,6 @@ static int brcm_avs_cpufreq_remove(struct platform_device *pdev)
 	priv = platform_get_drvdata(pdev);
 	iounmap(priv->base);
 	iounmap(priv->avs_intr_base);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
