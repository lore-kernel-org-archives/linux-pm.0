From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 14/17] ata: ahci_tegra: remove power sequence from
 driver
Date: Thu, 12 Mar 2015 20:23:18 +0800
Message-ID: <55018536.2050904@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com> <1426162518-7405-15-git-send-email-vinceh@nvidia.com> <20150312121912.GJ25944@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------090109030103030308020303"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150312121912.GJ25944-piEFEHQLUPpN0TnZuCh8vA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--------------090109030103030308020303
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

Cc'd Hans.

Thanks,
Vince

On 03/12/2015 08:19 PM, Tejun Heo wrote:
> On Thu, Mar 12, 2015 at 08:15:15PM +0800, Vince Hsu wrote:
>> We have the generic PM domain support for Tegra SoCs now. So remove the
>> duplicated sequence here.
>>
>> Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Can you please repost this patch w/ Hans de Goede
> <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> cc'd?  Just reposting the patch as a reply to
> itself w/ the cc added should do.
>
> Thanks.
>


--------------090109030103030308020303
Content-Type: text/x-patch;
	name="0014-ata-ahci_tegra-remove-power-sequence-from-driver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0014-ata-ahci_tegra-remove-power-sequence-from-driver.patch"

>From afff7ff2011f2c3f159726ffddeaeec8f62f013e Mon Sep 17 00:00:00 2001
From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Wed, 14 Jan 2015 11:01:06 +0800
Subject: [PATCH v2 14/17] ata: ahci_tegra: remove power sequence from driver
X-NVConfidentiality: public

We have the generic PM domain support for Tegra SoCs now. So remove the
duplicated sequence here.

Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_tegra.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 3a62eb246d80..8151587ddb70 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -120,12 +120,6 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	if (ret)
 		return ret;
 
-	ret = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_SATA,
-						tegra->sata_clk,
-						tegra->sata_rst);
-	if (ret)
-		goto disable_regulators;
-
 	reset_control_assert(tegra->sata_oob_rst);
 	reset_control_assert(tegra->sata_cold_rst);
 
@@ -140,10 +134,6 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 
 disable_power:
 	clk_disable_unprepare(tegra->sata_clk);
-
-	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
-
-disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
 
 	return ret;
@@ -160,7 +150,6 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
 	reset_control_assert(tegra->sata_cold_rst);
 
 	clk_disable_unprepare(tegra->sata_clk);
-	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
 
 	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
 }
-- 
2.1.4


--------------090109030103030308020303--
