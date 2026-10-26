Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.195.17.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014644;
	b=WqXrf5SX/VsgyccsORRm8c2k7qba5S4uRrThlrFaU7/IM609sBseaxMAkPgzP6YWzZV9
	 i5G/fW6tLMZME8sdbB8wxh7WxEBS1sg24scll1L8pt59KNkddPP8Gto0Hw9tUx/SDrTZT
	 IHDFCMiAFLYYzm+0tN5avOexRBwcwY8LL2bNnyVHWd0g8DSkfuBQfBXM/oSulVH9CvJXU
	 2kClYZV7LRZkRg7rLio95GIrzPGCfLDtqR5j7TS+oMXy215wk6Y1yXXNZAYFw3BDvfpGK
	 48vJoCEpwM3v4SS5EaMKMLVa661B8FAmT3Fih9t8/uiVB+dLlyT5nSUDVlB2CudO6vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014644;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=HEKtYIbgkzruBNpb+DZV777xMRKUL99v7GeZyU05Q6o=;
	b=mfl+WRU7jF5FsHcebLuAAd0pQz1NdiVHnMA0AL9kruzOlFkgq+mTOM1PK8HgR3M+WnDG
	 d3TLWrALyaCPoCvwJFqGOzjFk5v5VfhdXRoKjR30C+FlKvkQj8eCoICLZhp+TPa9kay73
	 vyQsQiXIhZEgBqeYDoYj9c9fdmdXr+oGfbtR9k9vQ9s/keMnMt9K25zEe1HbJpgDBihn4
	 mD1azQsDkPYo/115GF9bAqleNAIpRv5Bqv9cf0dhwa5cAI8DXTvA7TVXr3DVzISpVWUXD
	 prFZM30FxN6ybyptGF7pDlOKVP7g0MH0Ag571lgxlINjkEjb7ds+eERGVgvsVZvzzSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=VNMfoH3W;
	arc=none smtp.remote-ip=45.195.17.204
Received: from mail-m17204.xmail.ntesmail.com (mail-m17204.xmail.ntesmail.com [45.195.17.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD09606A31E;
	Mon, 26 Oct 2026 11:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADD09606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=VNMfoH3W
Received: from [172.16.12.11] (gyproxy-mailtls0-entmail-virt215.gy.ntes [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52608528f;
	Mon, 26 Oct 2026 19:37:06 +0800 (GMT+08:00)
Message-ID: <d4e92131-ceb8-4143-b8f8-21e7f9638bdb@rock-chips.com>
Date: Mon, 26 Oct 2026 19:37:06 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] pmdomain: rockchip: Add RK3572 boot peripheral
 domains
From: Finley Xiao <finley.xiao@rock-chips.com>
To: 1579567540@qq.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Elaine Zhang <zhangqing@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20261026-add-board-ok3572-c-pmdomain-v3-0-70d614d3d921@qq.com>
 <20261026-add-board-ok3572-c-pmdomain-v3-2-70d614d3d921@qq.com>
 <18fcfe7a-e25a-4516-810f-d787b779914d@rock-chips.com>
In-Reply-To: <18fcfe7a-e25a-4516-810f-d787b779914d@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa177fff99c09dakunm641cefa435c1f4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGRlMVh8ZSk1NSh9MS0kaTFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VNMfoH3WZzNqyxfs96Wvtr29zf904g8OgBBMSGVV/lJwvX3tAu37R/0E1Va2cuCJgP62iDleydznQ4XZK6Bn5bvttzZpMlO87TLYwu9v262EA/8iryJxR+yunfwtU73yA+5ycvptlrx8//L6vg6yVGStiEw8we++3446S5CjXHg=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=HEKtYIbgkzruBNpb+DZV777xMRKUL99v7GeZyU05Q6o=;
	h=date:mime-version:subject:message-id:from;


在 2026/10/26 16:47, Finley Xiao 写道:
>
> 在 2026/10/26 11:21, Cunhao Lu via B4 Relay 写道:
>> From: Finley Xiao <finley.xiao@rock-chips.com>
>>
>> Add support for the RK3572 NVM0, NVM1, PHP, and VOP power domains.
>>
>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

I have to point out that the changes (the shutdown/restore
rework, pending-state tracking, etc.) were not made by me, and I have
not reviewed them in detail. Therefore, I should not remain as the
author (From:) of this patch, nor should my Signed-off-by be kept on
it.


>>
>> - Returned firmware shift-ready wait errors to callers.
>> - Kept the domain pending after a firmware shift-ready wait failure.
>> - Retried power-on without repeating completed memory resets.
>> - Recorded low-level power-on and restoration stages before hardware
>>    operations so retries complete unfinished low-level work.
>> - Kept memory resets pending across failures, including when memory 
>> is off.
>> - Preserved QoS snapshots after a failed power-on and cleared progress
>>    after successful power-on or shutdown.
>> - Tracked incomplete shutdowns to preserve QoS and complete firmware 
>> updates.
>> - Preserved pending memory resets across shutdown and cancelled 
>> unfinished
>>    power-on requests.
>> - Attempt to restore the domain after power-off errors, while preserving
>>    the original error returned to genpd.
>>
>> Co-developed-by: Cunhao Lu <1579567540@qq.com>
>> Signed-off-by: Cunhao Lu <1579567540@qq.com>
>> ---
>> Changes in v3:
>> - Track incomplete shutdowns to preserve QoS and complete firmware 
>> updates.
>> - Preserve pending memory resets across shutdown and cancel unfinished
>>    power-on requests.
>> - Attempt to restore the domain after power-off errors, while preserving
>>    the original error returned to genpd.
>>
>> Changes in v2:
>> - Record low-level power-on and restoration stages before hardware
>>    operations, so a retry cannot skip unfinished low-level work.
>> - Retain pending memory resets even if memory is off on retry, and
>>    avoid repeating completed resets during restoration.
>> - Preserve QoS snapshots across failed power-on and shutdown; clear
>>    progress after successful power-on or shutdown.
>> ---
>>   drivers/pmdomain/rockchip/pm-domains.c | 187 
>> +++++++++++++++++++++++++++++----
>>   1 file changed, 167 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/pmdomain/rockchip/pm-domains.c 
>> b/drivers/pmdomain/rockchip/pm-domains.c
>> index e193f978d5f3..668d208dea55 100644
>> --- a/drivers/pmdomain/rockchip/pm-domains.c
>> +++ b/drivers/pmdomain/rockchip/pm-domains.c
>> @@ -39,6 +39,7 @@
>>   #include <dt-bindings/power/rockchip,rk3528-power.h>
>>   #include <dt-bindings/power/rockchip,rk3562-power.h>
>>   #include <dt-bindings/power/rk3568-power.h>
>> +#include <dt-bindings/power/rockchip,rk3572-power-controller.h>
>>   #include <dt-bindings/power/rockchip,rk3576-power.h>
>>   #include <dt-bindings/power/rk3588-power.h>
>>   @@ -59,6 +60,9 @@ struct rockchip_domain_info {
>>       u32 pwr_offset;
>>       u32 mem_offset;
>>       u32 req_offset;
>> +    u32 status_offset;
>> +    u32 firewall_mask;
>> +    u32 clk_ungate_offset;
>>   };
>>     struct rockchip_pmu_info {
>> @@ -72,6 +76,8 @@ struct rockchip_pmu_info {
>>       u32 mem_status_offset;
>>       u32 repair_status_offset;
>>       u32 clk_ungate_offset;
>> +    u32 firewall_status_offset;
>> +    bool chain_status_inverted;
> please keep the abbreviation consistent with the other struct
> members and use fw_mask / fw_status_offset instead of firewall_mask /
> firewall_status_offset.
>>       u32 core_pwrcnt_offset;
>>       u32 gpu_pwrcnt_offset;
>> @@ -90,6 +96,13 @@ struct rockchip_pmu_info {
>>   #define QOS_SATURATION        0x14
>>   #define QOS_EXTCONTROL        0x18
>>   +enum rockchip_pd_power_state {
>> +    ROCKCHIP_PD_IDLE,
>> +    ROCKCHIP_PD_ON_HW,
>> +    ROCKCHIP_PD_ON_RESTORE,
>> +    ROCKCHIP_PD_OFF,
>> +};
>> +
>>   struct rockchip_pm_domain {
>>       struct generic_pm_domain genpd;
>>       const struct rockchip_domain_info *info;
>> @@ -101,11 +114,14 @@ struct rockchip_pm_domain {
>>       struct clk_bulk_data *clks;
>>       struct device_node *node;
>>       struct regulator *supply;
>> +    enum rockchip_pd_power_state power_state;
>> +    bool mem_reset_pending;
>>   };
>>     struct rockchip_pmu {
>>       struct device *dev;
>>       struct regmap *regmap;
>> +    struct regmap *grf;
>>       const struct rockchip_pmu_info *info;
>>       struct mutex mutex; /* mutex lock for pmu */
>>       struct genpd_onecell_data genpd_data;
>> @@ -373,15 +389,16 @@ static bool rockchip_pmu_domain_is_idle(struct 
>> rockchip_pm_domain *pd)
>>       const struct rockchip_domain_info *pd_info = pd->info;
>>       unsigned int val;
>>   -    regmap_read(pmu->regmap, pmu->info->idle_offset, &val);
>> +    regmap_read(pmu->regmap, pmu->info->idle_offset + 
>> pd_info->status_offset, &val);
>>       return (val & pd_info->idle_mask) == pd_info->idle_mask;
>>   }
>>   -static unsigned int rockchip_pmu_read_ack(struct rockchip_pmu *pmu)
>> +static unsigned int rockchip_pmu_read_ack(struct rockchip_pm_domain 
>> *pd)
>>   {
>> +    struct rockchip_pmu *pmu = pd->pmu;
>>       unsigned int val;
>>   -    regmap_read(pmu->regmap, pmu->info->ack_offset, &val);
>> +    regmap_read(pmu->regmap, pmu->info->ack_offset + 
>> pd->info->status_offset, &val);
>>       return val;
>>   }
>>   @@ -400,7 +417,8 @@ static int rockchip_pmu_ungate_clk(struct 
>> rockchip_pm_domain *pd, bool ungate)
>>         val = ungate ? (pd_info->clk_ungate_mask | clk_ungate_w_mask) :
>>               clk_ungate_w_mask;
>> -    regmap_write(pmu->regmap, pmu->info->clk_ungate_offset, val);
>> +    regmap_write(pmu->regmap, pmu->info->clk_ungate_offset +
>> +             pd_info->clk_ungate_offset, val);
>>         return 0;
>>   }
>> @@ -431,7 +449,7 @@ static int rockchip_pmu_set_idle_request(struct 
>> rockchip_pm_domain *pd,
>>         /* Wait util idle_ack = 1 */
>>       target_ack = idle ? pd_info->ack_mask : 0;
>> -    ret = readx_poll_timeout_atomic(rockchip_pmu_read_ack, pmu, val,
>> +    ret = readx_poll_timeout_atomic(rockchip_pmu_read_ack, pd, val,
>>                       (val & pd_info->ack_mask) == target_ack,
>>                       0, 10000);
>>       if (ret) {
>> @@ -543,6 +561,9 @@ static bool 
>> rockchip_pmu_domain_is_chain_on(struct rockchip_pm_domain *pd)
>>       regmap_read(pmu->regmap,
>>               pmu->info->chain_status_offset + pd->info->mem_offset, 
>> &val);
>>   +    if (pmu->info->chain_status_inverted)
>> +        return !(val & pd->info->mem_status_mask);
>> +
>>       /* 1'b1: power on, 1'b0: power off */
>>       return val & pd->info->mem_status_mask;
>>   }
>> @@ -600,16 +621,13 @@ static int 
>> rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>>       struct rockchip_pmu *pmu = pd->pmu;
>>       struct generic_pm_domain *genpd = &pd->genpd;
>>       u32 pd_pwr_offset = pd->info->pwr_offset;
>> -    bool is_on, is_mem_on = false;
>> +    bool is_on;
>>       struct arm_smccc_res res;
>>       int ret;
>>         if (pd->info->pwr_mask == 0)
>>           return 0;
>>   -    if (on && pd->info->mem_status_mask)
>> -        is_mem_on = rockchip_pmu_domain_is_mem_on(pd);
>> -
>>       if (pd->info->pwr_w_mask)
>>           regmap_write(pmu->regmap, pmu->info->pwr_offset + 
>> pd_pwr_offset,
>>                    on ? pd->info->pwr_w_mask :
>> @@ -620,13 +638,13 @@ static int 
>> rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>>         wmb();
>>   -    if (is_mem_on) {
>> +    if (on && pd->mem_reset_pending) {
>>           ret = rockchip_pmu_domain_mem_reset(pd);
>>           if (ret)
>>               return ret;
>> +        pd->mem_reset_pending = false;
>>       }
>>   -
>>       ret = readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, 
>> is_on,
>>                       is_on == on, 0, 10000);
>>       if (ret) {
>> @@ -644,14 +662,29 @@ static int 
>> rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>>       return 0;
>>   }
>>   +static int rockchip_pmu_wait_firewall(struct rockchip_pm_domain *pd)
>> +{
>> +    struct rockchip_pmu *pmu = pd->pmu;
>> +    u32 mask = pd->info->firewall_mask;
>> +    u32 val;
>> +
>> +    if (!mask)
>> +        return 0;
>> +
>> +    return regmap_read_poll_timeout(pmu->grf, 
>> pmu->info->firewall_status_offset,
>> +                       val, (val & mask) == mask, 0, 10000);
>> +}
>> +
>>   static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool 
>> power_on)
>>   {
>>       struct rockchip_pmu *pmu = pd->pmu;
>> +    bool is_on;
>>       int ret;
>>         guard(mutex)(&pmu->mutex);
>>   -    if (rockchip_pmu_domain_is_on(pd) == power_on)
>> +    is_on = rockchip_pmu_domain_is_on(pd);
>> +    if (is_on == power_on && pd->power_state == ROCKCHIP_PD_IDLE)
>>           return 0;
>>         ret = clk_bulk_enable(pd->num_clks, pd->clks);
>> @@ -662,18 +695,38 @@ static int rockchip_pd_power(struct 
>> rockchip_pm_domain *pd, bool power_on)
>>         rockchip_pmu_ungate_clk(pd, true);
>>   -    if (!power_on) {
>> -        rockchip_pmu_save_qos(pd);
>> +    if (power_on) {
>> +        if (pd->power_state == ROCKCHIP_PD_IDLE ||
>> +            pd->power_state == ROCKCHIP_PD_OFF ||
>> +            (pd->power_state == ROCKCHIP_PD_ON_RESTORE && !is_on)) {
>> +            /* A failed reset may still be forcing memory off. */
>> +            pd->mem_reset_pending |= pd->info->mem_status_mask &&
>> +                rockchip_pmu_domain_is_mem_on(pd);
>> +            pd->power_state = ROCKCHIP_PD_ON_HW;
>> +        }
>> +
>> +        /* A status bit alone does not prove the low-level sequence 
>> finished. */
>> +        if (pd->power_state == ROCKCHIP_PD_ON_HW) {
>> +            ret = rockchip_do_pmu_set_power_domain(pd, true);
>> +            if (ret < 0)
>> +                goto out;
>> +            pd->power_state = ROCKCHIP_PD_ON_RESTORE;
>> +        }
>> +    } else {
>> +        if (pd->power_state == ROCKCHIP_PD_IDLE)
>> +            rockchip_pmu_save_qos(pd);
>> +        pd->power_state = ROCKCHIP_PD_OFF;
>>             /* if powering down, idle request to NIU first */
>>           ret = rockchip_pmu_set_idle_request(pd, true);
>>           if (ret < 0)
>>               goto out;
>> -    }
>>   -    ret = rockchip_do_pmu_set_power_domain(pd, power_on);
>> -    if (ret < 0)
>> -        goto out;
>> +        /* Cancel a pending power-on even if its status is still 
>> off. */
>> +        ret = rockchip_do_pmu_set_power_domain(pd, false);
>> +        if (ret < 0)
>> +            goto out;
>> +    }
>>         if (power_on) {
>>           /* if powering up, leave idle mode */
>> @@ -681,8 +734,14 @@ static int rockchip_pd_power(struct 
>> rockchip_pm_domain *pd, bool power_on)
>>           if (ret < 0)
>>               goto out;
>>   +        ret = rockchip_pmu_wait_firewall(pd);
>> +        if (ret)
>> +            goto out;
>> +
>>           rockchip_pmu_restore_qos(pd);
>> +        pd->mem_reset_pending = false;
>>       }
>> +    pd->power_state = ROCKCHIP_PD_IDLE;
>>     out:
>>       rockchip_pmu_ungate_clk(pd, false);
>> @@ -733,11 +792,18 @@ static int rockchip_pd_power_on(struct 
>> generic_pm_domain *domain)
>>   static int rockchip_pd_power_off(struct generic_pm_domain *domain)
>>   {
>>       struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
>> -    int ret;
>> +    int ret, err;
>>         ret = rockchip_pd_power(pd, false);
>> -    if (ret)
>> +    if (ret) {
>> +        /* genpd still considers the domain on after a failed 
>> power-off. */
>> +        err = rockchip_pd_power(pd, true);
>> +        if (err)
>> +            dev_err(pd->pmu->dev,
>> +                "failed to restore domain '%s' after power-off 
>> failure: %d\n",
>> +                domain->name, err);
>>           return ret;
>> +    }
>
> The changes to rockchip_pd_power()/rockchip_pd_power_off() (the
> power_state state machine, mem_reset_pending, and the restore after
> a failed power-off) are generic rework of the shared power path;
> they are not required for basic RK3572 support and they affect all
> the other SoCs. Please split them out of this series.
>
>
>>         rockchip_pd_regulator_disable(pd);
>>       return ret;
>> @@ -1064,6 +1130,11 @@ static int rockchip_pm_domain_probe(struct 
>> platform_device *pdev)
>>       mutex_init(&pmu->mutex);
>>         pmu->info = pmu_info;
>> +    if (pmu_info->firewall_status_offset) {
>> +        pmu->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
>> +        if (IS_ERR(pmu->grf))
>> +            return dev_err_probe(dev, PTR_ERR(pmu->grf), "failed to 
>> get system GRF\n");
>> +    }
>>         pmu->genpd_data.domains = pmu->domains;
>>       pmu->genpd_data.num_domains = pmu_info->num_domains;
>> @@ -1313,6 +1384,62 @@ static const struct rockchip_domain_info 
>> rk3568_pm_domains[] = {
>>       [RK3568_PD_PIPE]    = DOMAIN_RK3568("pipe", BIT(8), BIT(11), 
>> false, false),
>>   };
>>   +static const struct rockchip_domain_info rk3572_pm_domains[] = {
>> +    [RK3572_PD_NVM1] = {
>> +        .name = "nvm1",
>> +        .pwr_mask = BIT(4),
>> +        .pwr_w_mask = BIT(20),
>> +        .mem_status_mask = BIT(4),
>> +        .repair_status_mask = BIT(3),
>> +        .req_mask = BIT(6),
>> +        .req_w_mask = BIT(22),
>> +        .idle_mask = BIT(6),
>> +        .ack_mask = BIT(6),
>> +        .clk_ungate_mask = BIT(6),
>> +    },
>> +    [RK3572_PD_PHP] = {
>> +        .name = "php",
>> +        .pwr_mask = BIT(7),
>> +        .pwr_w_mask = BIT(23),
>> +        .mem_status_mask = BIT(7),
>> +        .repair_status_mask = BIT(5),
>> +        .req_mask = BIT(9),
>> +        .req_w_mask = BIT(25),
>> +        .idle_mask = BIT(9),
>> +        .ack_mask = BIT(9),
>> +        .clk_ungate_mask = BIT(9),
>> +        .firewall_mask = BIT(28),
>> +    },
>> +    [RK3572_PD_VOP] = {
>> +        .name = "vop",
>> +        .pwr_mask = BIT(12),
>> +        .pwr_w_mask = BIT(28),
>> +        .mem_status_mask = BIT(12),
>> +        .repair_status_mask = BIT(10),
>> +        .req_mask = BIT(14),
>> +        .req_w_mask = BIT(30),
>> +        .idle_mask = BIT(14),
>> +        .ack_mask = BIT(14),
>> +        .clk_ungate_mask = BIT(14),
>> +        .firewall_mask = BIT(23),
>> +    },
>> +    [RK3572_PD_NVM0] = {
>> +        .name = "nvm0",
>> +        .pwr_mask = BIT(15),
>> +        .pwr_w_mask = BIT(31),
>> +        .mem_status_mask = BIT(15),
>> +        .repair_status_mask = BIT(13),
>> +        .req_mask = BIT(0),
>> +        .req_w_mask = BIT(16),
>> +        .idle_mask = BIT(0),
>> +        .ack_mask = BIT(0),
>> +        .clk_ungate_mask = BIT(0),
>> +        .req_offset = 4,
>> +        .status_offset = 4,
>> +        .clk_ungate_offset = 4,
>> +    },
>> +};
> 1. Only 4 of the 14 domains are added here. The internal implementation
>    covers npu, gpu, nvm0, nvm1, dsmc, php, audio, img, vdec, vi, venc,
>    vo, vop and vop_pre. Please add the remaining domains.
>
>    Note that the npu domain also needs the voltage-domain handshake from
>    the internal code (vd_offset = 0x220, per-domain vd_en and a
>    rockchip_pmu_vd_on() call before powering on the domain), so either
>    include that support as well, or leave out npu until it is ready.
>
> 2. Please use a DOMAIN_RK3572 macro like the other SoCs in this
>    driver (see DOMAIN_RK3576).
>> +
>>   static const struct rockchip_domain_info rk3576_pm_domains[] = {
>>       [RK3576_PD_NPU]        = DOMAIN_RK3576("npu",    0x0, BIT(0),  
>> BIT(0), 0,       0x0, 0,       0,       0, false),
>>       [RK3576_PD_NVM]        = DOMAIN_RK3576("nvm",    0x0, BIT(6),  
>> 0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2), false),
>> @@ -1536,6 +1663,23 @@ static const struct rockchip_pmu_info 
>> rk3568_pmu = {
>>       .domain_info = rk3568_pm_domains,
>>   };
>>   +static const struct rockchip_pmu_info rk3572_pmu = {
>> +    .pwr_offset = 0x210,
>> +    .status_offset = 0x230,
>> +    .chain_status_offset = 0x250,
>> +    .chain_status_inverted = true,
>> +    .mem_status_offset = 0x260,
>> +    .mem_pwr_offset = 0x300,
>> +    .req_offset = 0x110,
>> +    .idle_offset = 0x130,
>> +    .ack_offset = 0x120,
>> +    .repair_status_offset = 0x570,
>> +    .clk_ungate_offset = 0x150,
>> +    .firewall_status_offset = 0x140,
>> +    .num_domains = ARRAY_SIZE(rk3572_pm_domains),
>> +    .domain_info = rk3572_pm_domains,
>> +};
>> +
>>   static const struct rockchip_pmu_info rk3576_pmu = {
>>       .pwr_offset = 0x210,
>>       .status_offset = 0x230,
>> @@ -1648,6 +1792,9 @@ static const struct of_device_id 
>> rockchip_pm_domain_dt_match[] = {
>>           .data = (void *)&rk3568_pmu,
>>       },
>>       {
>> +        .compatible = "rockchip,rk3572-power-controller",
>> +        .data = &rk3572_pmu,
>> +    }, {
>>           .compatible = "rockchip,rk3576-power-controller",
>>           .data = (void *)&rk3576_pmu,
>>       },
>>
-- 
Best regards,

底层平台中心 肖锋（Finley Xiao）
************************************************************************************
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.
福建省福州市铜盘路软件大道89号软件园A区21号楼 350003
No.21 Building, A District, Fuzhou Software Park, Fuzhou, Fujian 350003, P.R. China
Tel: 0591-83991906-8602 Mobile: 18506057603
************************************************************************************

