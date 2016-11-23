From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 1/5] thermal: rockchip: improve conversion error messages
Date: Wed, 23 Nov 2016 22:29:30 +0800
Message-ID: <1479911374-22006-2-git-send-email-wxt@rock-chips.com>
References: <1479911374-22006-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1479911374-22006-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

These error messages don't give much information about what went wrong.
It would be nice, for one, to see what invalid temperature was being
requested when conversion fails. It's also good to return an error when
we can't handle a conversion properly.

While we're at it, fix the grammar too.

Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v2: None
Changes in v1:
- The original Brian posted on https://patchwork.kernel.org/patch/9437686
  Note: it'd probably be even nicer to know which sensor this was, but we've
  kinda abstracted that one away by this point...

 drivers/thermal/rockchip_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index b811b0f..26c247c 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -424,7 +424,8 @@ static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
 	}
 
 exit:
-	pr_err("Invalid the conversion, error=%d\n", error);
+	pr_err("%s: invalid temperature, temp=%d error=%d\n",
+	       __func__, temp, error);
 	return error;
 }
 
@@ -475,7 +476,9 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 		}
 		break;
 	default:
-		pr_err("Invalid the conversion table\n");
+		pr_err("%s: invalid conversion table, mode=%d\n",
+		       __func__, table.mode);
+		return -EINVAL;
 	}
 
 	/*
-- 
2.7.4
