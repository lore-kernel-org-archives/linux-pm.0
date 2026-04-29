Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8877B330649
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499353; cv=none; b=cr2sHVF6U13+O25WgHBOig16Nar1Hu4ZcktDVD+bvA/1g3cPBE/kTZWOQJTlde/myjuCLBzAaT2k0NyOK0mI7HH12I75hzJFDf72jUAicaZmsr0ykcL8A8V1CywX+kbdEuQfiFzX0iC8XtiQ4/qvZY2BSadxBs5xU9WFhgTN1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499353; c=relaxed/simple;
	bh=sxpoMQENbm/mrNXCZHU23pnzSF7EQ886NX5Ro1+KlR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3EDo5LjJwAsEGN52lBGopkR7NMtj3JcPmJHdZCZ4A/4h48YOYCl2fvHuMmvYLNihCWLmz5sxgXMgPgIiErjRXgC5bnFfgAvY8S/6slgJUzY4s8tS92cWSw2YWTYrcQCvY1IlUPOtlQeujwyXnlXVZ1iJFQ+gM42uil4pmwOIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv8+oxk1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv8+oxk1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab232cc803so1025795ad.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777499351; x=1778104151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFQFsEdE3UBmdH8kb6QnmUfDGvd+PW0laJUz1O9//bY=;
        b=Gv8+oxk1yJmBsTGE5ByvQXk2kWcwcmInmI5DumemL0+Q7HZDTjiY6CQKX4w94Mh2sH
         WvSE0DZsqOSxdVVDDmIFdJaH4ISsoPLAzTpAVRpbSXo7Waq9AdIpLQyugqYccXZAJNZw
         83UCE74EUNwo7bITuir0b8BYr/sqtLehmVNZjgOGflDSRgAM6Db4vf7TxjSijUv14EYS
         PzW1EM600lakcJPGJjnUmEX+O4zL2JGJUq1Vly+ythcLWiBKeTP8T8z5uWAkAU27TRYA
         boIA0zJKBlgeYh4qK+vfqGQ/jFh4J4fCpgk9Z3Cn305YIqSy9DDYDJE6FYmlIauI5fAb
         RvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777499351; x=1778104151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFQFsEdE3UBmdH8kb6QnmUfDGvd+PW0laJUz1O9//bY=;
        b=DjJvsUH+tcEDhxh/RgGfCxnp7tkLuLe9nCD0xLoGI3wSvdrS7ORd7G4oq3TFberVOq
         iZzC795kmt/e4YW24yQJNkzAUHiCNTb8SoSxAgikzg2kKxgDLf82HzNeCz3ro5pvv+Zb
         sSf1KQH98m2LDXUnjkODEBIEcRsyXRQTJOmUM2YVxHZnGlkbsvwAMLWjuT+u6s4il/Qj
         d2EVUk3rdYIkd7MCNpyNPT5fJBnJzWeAPnxF64ltl6ZTJ3fWkYWQoRm9BwwK5tv78Ri+
         3SmYm08b8WsDgofv3PRVGIcD6WUJqyO83S7zlRe8qVHhWawUCavkCO+ELp3j5nkMYoHx
         vu+A==
X-Gm-Message-State: AOJu0Yy+KMUYsfTL+S6Wboe0ofwKG0+uE/hb/Z4TnxvDLQXYcYI0lHVE
	0SKdkMAW5El9C1PVUqs9XM1srUahPnyWdwly8Y1oLWXnbdNs8G4Qd5kx
X-Gm-Gg: AeBDiesDNDSNYjy2BVbM7IbqZ8h+g0Z+OQ15YGaIaVnHpvg8PNZHYi0dGO03eGE0qrf
	w7d5CRpr9Fr/PCug9RNEcDJKWjrYZ8hXotfhge2s/D07/fpmSyiwn/BtAXYB8tI1RoSZjIjXI9L
	AMqWUhpZxKGXgSuS3W4tzeiaVJrprz7Trb9Whqv/GXOYReYCsCtJ4G/G9FPOkC6UbmYR8i/8nkx
	nzdDXKFTwuXGA/clwLQzhpk81sE/pxCl+WEagVrSwUKxlIwpDqA7AZcqP+FnUyo2VRy+j7F02Yo
	2r3mw9cfzUUb0oT9EdpBup3UnqsxLd+tGRYlH6GptL2rz5IOQMgdi6/NMcPQ5s1HrVhmpbRCv5S
	1eztgsxu8a0CA4B8Xi0l0DD9RMYSNRwUrnl2nD5SUEUAMV6+83Z0du/TymQDW/EIS+mAcwHvQr8
	jafdwPf8DYdcvJZG7vh9GNXeN9E8EbjHGerLnEGprtH0xw0erx28601g7g2DRZ
X-Received: by 2002:a17:903:390f:b0:2b2:67ca:5ff1 with SMTP id d9443c01a7336-2b9a24ff5a6mr1573315ad.31.1777499350816;
        Wed, 29 Apr 2026 14:49:10 -0700 (PDT)
Received: from [172.30.1.27] ([222.106.243.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98898c7cbsm30535635ad.77.2026.04.29.14.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 14:49:10 -0700 (PDT)
Message-ID: <267c9317-0cf3-44d5-b442-2bd713163312@gmail.com>
Date: Thu, 30 Apr 2026 06:49:07 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] PM / devfreq: Fix possible null pointer issue in
 devfreq_add_governor()
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, zhanjie9@hisilicon.com,
 nm@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <20260401033046.67482-1-tianyaxiong@kylinos.cn>
Content-Language: ko
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260401033046.67482-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



2026-04-01 PM 12:30에 Yaxiong Tian 이(가) 쓴 글:
> When a user removes a governor using devfreq_remove_governor(), if
> the current device is using this governor, devfreq->governor will
> be set to NULL. When the user registers any governor
> using devfreq_add_governor(), since devfreq->governor is NULL, a
> null pointer error occurs in strncmp().
> 
> For example: A user loads the userspace gov through a module, then
> a device selects userspace. When unloading the userspace module and
> then loading it again, the null pointer error occurs:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000010
> Mem abort info:
> ESR = 0x0000000096000004
> EC = 0x25: DABT (current EL), IL = 32 bits
> *******************skip *********************
> Call trace:
> __pi_strncmp+0x20/0x1b8
> devfreq_userspace_init+0x1c/0xff8 [governor_userspace]
> do_one_initcall+0x4c/0x278
> do_init_module+0x5c/0x218
> load_module+0x1f1c/0x1fc8
> init_module_from_file+0x8c/0xd0
> __arm64_sys_finit_module+0x220/0x3d8
> invoke_syscall+0x48/0x110
> el0_svc_common.constprop.0+0xbc/0xe8
> do_el0_svc+0x20/0x30
> el0_svc+0x24/0xb8
> el0t_64_sync_handler+0xb8/0xc0
> el0t_64_sync+0x14c/0x150
> 
> To fix this issue, remove the list_for_each_entry() logic, as
> find_devfreq_governor() has already checked for the existence of
> governor with the same name. This makes it impossible to find a
> duplicate governor in the list, so the subsequent logic is
> unreachable and can be removed.
> 
> Fixes: 1b5c1be2c88e ("PM / devfreq: map devfreq drivers to governor using name")
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/devfreq/devfreq.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)
> 
> Hi Jie Zhan: 
> 	If you're willing, I'd like to add your Co-developed-by tag.
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 82dd9a43dc62..994984f7b6e1 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1261,7 +1261,6 @@ void devfreq_resume(void)
>  int devfreq_add_governor(struct devfreq_governor *governor)
>  {
>  	struct devfreq_governor *g;
> -	struct devfreq *devfreq;
>  	int err = 0;
>  
>  	if (!governor) {
> @@ -1280,38 +1279,6 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>  
>  	list_add(&governor->node, &devfreq_governor_list);
>  
> -	list_for_each_entry(devfreq, &devfreq_list, node) {
> -		int ret = 0;
> -		struct device *dev = devfreq->dev.parent;
> -
> -		if (!strncmp(devfreq->governor->name, governor->name,
> -			     DEVFREQ_NAME_LEN)) {
> -			/* The following should never occur */
> -			if (devfreq->governor) {
> -				dev_warn(dev,
> -					 "%s: Governor %s already present\n",
> -					 __func__, devfreq->governor->name);
> -				ret = devfreq->governor->event_handler(devfreq,
> -							DEVFREQ_GOV_STOP, NULL);
> -				if (ret) {
> -					dev_warn(dev,
> -						 "%s: Governor %s stop = %d\n",
> -						 __func__,
> -						 devfreq->governor->name, ret);
> -				}
> -				/* Fall through */
> -			}
> -			devfreq->governor = governor;
> -			ret = devfreq->governor->event_handler(devfreq,
> -						DEVFREQ_GOV_START, NULL);
> -			if (ret) {
> -				dev_warn(dev, "%s: Governor %s start=%d\n",
> -					 __func__, devfreq->governor->name,
> -					 ret);
> -			}
> -		}
> -	}
> -
>  err_out:
>  	mutex_unlock(&devfreq_list_lock);
>  


Hi,

Applied it. Thanks for fixing it.

Thanks,
Chanwoo Choi


