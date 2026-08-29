Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51541684B;
	Sat, 29 Aug 2026 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788035098; cv=fail; b=Ora5CIp8OdxS4VJJ2eemHc7Y1HP6JzSsZ3SJMVij7gkA4m/yX4rECAplCEqaqKBjQoxSEfN/5keDhXhlMUnz0TRxYmcGlTggrtrOE90B1EZdDUCKcX/u0IcqSgGfE4mPN3+gu5JfGf/0NwpSkzXM7AiocfWgbr/py/u3HKTHxDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788035098; c=relaxed/simple;
	bh=sGyndya9SMASZQaAi66S2y1MWACSkmNzmSSBym2NDfI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Pt0RqnZJFI6WunBeq4osyRxVPQilHrXmUv1Pe3NjgC1GIHtaE6wHjdwxVF17f6jKaIonZwkYbU+11jChfpJzbKHjf0X4XcEaNHliQ2/y/PlwRk1cV5JQ9CyvnEZYO/A5L0tpOX5Kq4Opa2n7K2aPg3ZQ5kwPrq1e0PsR3TlpJcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIx5uNonIvBMy6t1zMXcGWiZeKwI2pcE1O9OTVe2FDS4xbdcCCdyvRo4EdMVbUKzw5O7QjrZk5J0PBgu4aLe602ivhUceFufY+txe7LkSd9VMRF0nS9oZIilpEUVjAwYk0eJNlLHWBlq6SjmEYA0Bzf5WIAv0cIJySqBrKwz5+AFSPCAliUZDtaq0qoSGhyK+hIJm00kAokCq4EX4l6xRMV9DstDUiMmH78U/+0Fo3m1cuyE4tKxShoCijoeF2RzyLhMKzEDX0ygHjtM6aSxIiNPm/EoB2naOR/pyn8JegoIM7uiP1WnqbHdHRSD8wOShe3QyvktOLcsnSoxtFUxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCSxQ/okrGu6YAvKLTh0OZ0ATeXpQHCQb9QWx35tFWs=;
 b=oP1G6a8fS18ZBN0w+jNFBXvcR47v6pOxVVoFWDh4eHdaFZh4ULbxSnPOygt5csER9S6Znv2FGubDvzUlvE9g7motdlh4UikQ1LaR9I2q2sAcpy1nI6hwTCtGpbD6306ih4jSvuvroOkRc/cTPyzd5JAeqxbUxYjpKI+CKitHAQ5gfW9V+dKtGNQCiMFenNzgs76Wz8U1U6VkuHagCn/Y47HuoBeRWnvkoJqwObRDG4v3bSvQgVcERQbqUppswcg3TAzJyFCy+x7G/Oet1mc9uMHHGxc4zFZ5H2LYQ9Pdgy56jDE49VDYa7jsrpXtMbpMJw7MuoQ/HplxKNMs3fQ+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0568.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:13::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Sat, 29 Aug
 2026 19:51:37 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Sat, 29 Aug 2026 19:51:36 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Joshua Yeong <joshua.yeong@starfivetech.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: core: Honour pd_ignore_unused in the sync_state power-off
Date: Sun, 30 Aug 2026 03:51:05 +0800
Message-ID: <20260829195105.4173953-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::11) To BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0838:EE_|BJXPR01MB0568:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e7c7ba-c285-4243-ba45-08df0606ef3b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|52116014|23010399003|1800799024|376014|6133799003|10067099003|38350700014|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 krmfXt/E6ZZ7fLhJUSygbqCH+XUvq4UOd3vqzJPAh7CgW2m7w9Vnce4zHXl8nrG2MtZBPtpCqn/mKaN8K1f8LDt1M4bd0Vjj9j3EWKSUBbGWaZyg3Wy0QwJH1QMMz5BvBuE9h+xUpOYxbuR8UrYq9YQxK63mPjNdoZuMdkPPRkg4en8WxktDk6Hx5iMkxLoEZ7TNdhDQao3I4WKcrGfdKvmYTQvHnD1eJakvP+JFkqh+DXDegj19/Gexr0t5qOIoaEp/AJnRwyJ+GGgCLxNOMq4RLQ9xmeH9iL4n9d1Gf1GWGDKRcH23YO3CQEk0YOZNsMWVG/C28/oIkogF5kshOJjkDcgqL7cCiPra6Dc+sBXW8dgTURQmI1YsTPB2pJGey7eonYF4UXrMLexRF0QJ+3JTJLfNmd/yF9xtcOtD5S9ZtKXLQWLbZ/y8JDxLQbcTKYSImn+qtrTx1z60Qwa19AsdHBCwHhnER5V5yIZVSohlBCTN1CH4WmN9BAcYjY+tfPla++tzulsbeCAfj7cgkt+/6VGD1O0JpY9Mu6S+aa5PFGTFnv3cHT+ZmIjiOy/C
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(38350700014)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?HUKfiPsXUCCOtLNLA2dap7xwckWcQwgwpkG759BClP3z6DDHOiRdc/+bwZOs?=
 =?us-ascii?Q?9ttJB1XYOvLjhbGSwMuCUACeRU/T49SEhc9UzI7BjAIfCOFC8a7jBK8mkISg?=
 =?us-ascii?Q?M7CgPHKEUdeqGZE4c6mGYUfx/R1LdhahoK055rIFJSiMd4nDIu3bizqQB0o7?=
 =?us-ascii?Q?pguyx2e3rOivOo9vXi7HZShm0Km/9hdwwm3f1Zh3fyqThvUfpenWcgCvhupP?=
 =?us-ascii?Q?BpWVgDpy2qToZ4wn/pQ7QCNPdIp6o2SkjbITP5F6PqdBnfLs0uSm1VHYx9Ne?=
 =?us-ascii?Q?Jpwfy9I5/mS/V35OCdKE2TZ7tBW6GnjPUYHD8RV49b0UA/jXl2wwhkr5mlLb?=
 =?us-ascii?Q?Q0p3BuPa6bCowsdIlz/vOP+1B26WC59adGA/3F1jW6kK61L7Ej4z8nnlTkAL?=
 =?us-ascii?Q?+uH3d/bXIWqEOvvqXvl5PzXUq13XwcVZv7SfRm5il3dzoWiFMeIhw5k1sRGu?=
 =?us-ascii?Q?ZNJBVYnCXFv8F9qW+5PD/FHR8kATc2t8xoHAhA6K2Y6yfhRJlqkxY1CaEJl0?=
 =?us-ascii?Q?2vQjR5/ebtZEY2gOkL1GU5EvtlWNraT326000DqQRbJi2olaaqxCdWc0fltG?=
 =?us-ascii?Q?p4LX5QN7Sh9v5UsIlpOYPNgddC6f/+17C2Lt/FO6fA31NQKon0OG5l++Y3JF?=
 =?us-ascii?Q?ntFr1tuYGfMSEZ7Ecis38Pn/FcsX0Rn83hp28/wutggZj6Q9o1NrbnrB7z8w?=
 =?us-ascii?Q?G8wIZAlKZSVBwnYas6coaPajeQ06ggZ7ofsCzHfFQ++Qzp385m4vbb5FQB8o?=
 =?us-ascii?Q?QpeoariUItK6OVBvNk0vU6J/1kpCuXL/ZW1srBigHVagvRFC0wV6NWRGjET/?=
 =?us-ascii?Q?BLAHJwP15sjtOjo+5rVvVix3/6VYww5NksbAVb2DZVylCzBDhWcClEaVOMUJ?=
 =?us-ascii?Q?s5GiDBrsZgGEdGg1XOTV7cDPcVkiwGG69CKqUqjOm0ujQT8QvbNYsA/0XS9t?=
 =?us-ascii?Q?A67TsqEHaNdrZuQ1SwzgAoYoFhlp8zRh7ca5/aDPcJnF2tGVfV43eRk+4G3J?=
 =?us-ascii?Q?6En/+OjqZu5LI2YZvpap3W6Iwd2CDmIcHtg0HjV6aLXM8I05Xytz55SaaJJQ?=
 =?us-ascii?Q?HS+KD+B86uTN1LW5qdimwwJNCAEf7DRRWoLweGoAsv/sEDLCw87Cm0nUcpDc?=
 =?us-ascii?Q?5BcEK2dyaRaa7Ct/77V+xeCuRyXR7F8IcEq7QYtWsQMJNCPZUKUrxw9smhVN?=
 =?us-ascii?Q?klMvyqazhUiXMOxrWDZhJDpMEdyEk4j6XoZHJZz1VYmrAynZKMjBeIZmU7eJ?=
 =?us-ascii?Q?nU8mB1be/Z6HdN0R1qqTJVqYlnqb3ecBFKjDK5ALkyq0qbk1z0MR8HZwt4oy?=
 =?us-ascii?Q?RDvfngxbu7k9RAt7Kr43nYsRACQg4wpVLqsAj3FCbklkOHG0NWmuu5KMVoh0?=
 =?us-ascii?Q?VPG57ovgmRLawOwOdIrNq4QsgVpAJoxZzTY4tU9xqsnZMthuIsG615mBVWKW?=
 =?us-ascii?Q?ULMXlU/MKcoCiEs12O92AiaqO/evkWaENX8fVBnt8Ic3vqrhU1r086GwakTk?=
 =?us-ascii?Q?S4tr/4kh9RkKWH63bCU/VB2L9wb2HuAVulbnZs0rhkUViC+UpemSpwzlwtl/?=
 =?us-ascii?Q?owek8hQZTrIX3aOE+/a/4fGCoIHBaaOCPTEolL62ZXhxG8g8dnw77Al7gvod?=
 =?us-ascii?Q?8gt1BUogK3bYMgqYBPVavCPghriT14CBw2tpWKExm581BTMX/Ka5sQdM8mgD?=
 =?us-ascii?Q?yaIz/VePFh9YoFkBb+1SzDSDKqYLvL9h+niYfuJD8hCZkKjAWnTaJ3eX8odi?=
 =?us-ascii?Q?5mgytdEIiW4Efbaokvl4M7iClFyZ88s=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e7c7ba-c285-4243-ba45-08df0606ef3b
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 19:51:36.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ec0c4sKTjlTSR5riJ/n4X6khUDVRYX1JwI6kMwRWzJzOgew4Hx+kf1h9kz7NXCmWUtp2VPzrrKRPjAl6KjBwo07nq2T22LV+lNVXA7/2r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0568

The pd_ignore_unused command line option is documented to "keep all
power-domains already enabled by bootloader on, even if no driver has
claimed them". On an OF platform it no longer does.

Powering off unclaimed PM domains used to be the job of
genpd_power_off_unused(), which bails out on the option.
Commit 002ebddd695a ("pmdomain: core: Restore behaviour for disabling
unused PM domains") stopped that late_initcall_sync from clearing
stay_on, so it can no longer power off a PM domain that was found
powered-on at initialization. The only remaining path that clears
stay_on is ->sync_state(), and it never looked at the option, so an
unclaimed PM domain that the bootloader left on is powered off there
regardless.

Honour the option in the sync_state paths, for the PM domains that have
no consumer attached. Those are the ones the option describes, and once
genpd_power_off_unused() has bailed out they have no other power-off
trigger, so they stay on as documented.

The stay_on constraint is dropped either way, leaving the lifetime of
the constraint unchanged. The PM domains that do have a consumer
attached therefore stay under the control of runtime PM, which the
option has never covered, and a PM domain that gains a consumer after
->sync_state() is not left pinned.

Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/pmdomain/core.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 842c4169e290..c49d13b3068d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3673,6 +3673,29 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
+/*
+ * Drop the stay-on constraint that kept a genpd, found powered-on at
+ * initialization, from being powered-off during boot, then try a power-off.
+ *
+ * The pd_ignore_unused command line option asks for PM domains that no driver
+ * has claimed to be left on, so skip the power-off for those. Such a PM domain
+ * has no other power-off trigger either, as genpd_power_off_unused() bails out
+ * on the same option.
+ *
+ * The constraint itself is always dropped, so that the PM domains that do have
+ * a consumer attached stay under the control of runtime PM - the option has
+ * never covered those - and so that a PM domain gaining a consumer after this
+ * point is not left pinned.
+ */
+static void genpd_sync_state_power_off(struct generic_pm_domain *genpd)
+{
+	genpd_lock(genpd);
+	genpd->stay_on = false;
+	if (!pd_ignore_unused || genpd->device_count)
+		genpd_power_off(genpd, false, 0);
+	genpd_unlock(genpd);
+}
+
 /**
  * of_genpd_sync_state() - A common sync_state function for genpd providers
  * @np: The device node the genpd provider is associated with.
@@ -3690,12 +3713,8 @@ void of_genpd_sync_state(struct device_node *np)
 
 	mutex_lock(&gpd_list_lock);
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
-		if (genpd->provider == of_fwnode_handle(np)) {
-			genpd_lock(genpd);
-			genpd->stay_on = false;
-			genpd_power_off(genpd, false, 0);
-			genpd_unlock(genpd);
-		}
+		if (genpd->provider == of_fwnode_handle(np))
+			genpd_sync_state_power_off(genpd);
 	}
 	mutex_unlock(&gpd_list_lock);
 }
@@ -3719,10 +3738,7 @@ static void genpd_provider_sync_state(struct device *dev)
 		break;
 
 	case GENPD_SYNC_STATE_SIMPLE:
-		genpd_lock(genpd);
-		genpd->stay_on = false;
-		genpd_power_off(genpd, false, 0);
-		genpd_unlock(genpd);
+		genpd_sync_state_power_off(genpd);
 		break;
 
 	default:
-- 
2.43.0

