Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B261FFE;
	Thu,  2 Apr 2026 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099204; cv=none; b=Ft/6WRKfhkUG6NVDbus4PoyNJv9gD9QB3jFj0wlach8CE9oOYscsWbctIduiROLClAkvmYj6oRfZaNl5XOtk8ahiqFTXQhBSUK49+YNT2EXk8CPPRYWLqClDtlMBg2ben8B7c8QAg5mrtKcBWSVp5BdW/e0/Ezn3EAIsqiGUqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099204; c=relaxed/simple;
	bh=CpEHzZLxnYEWmCjwDlv+jP7qYxOZ2xwXd8y3d7WtSF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t53ofZwV9P280tYrJ/4+WAvDKIVsXg0rQ5HhXL2ejq6EbXmwQrDK5B0TSb56uspHJY5CiOIT0WlA4lsO0ZSjFF5hyfxNnKiKRHeoAWs1hVq9SdGLaKbYPJA5cgaTfdRCbX5yxzLA4F6RuDP8O/jmkPrgW5EfrH6P60cSt4hf78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fmRRr5Jnzz1cyV0;
	Thu,  2 Apr 2026 11:00:24 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 328524056C;
	Thu,  2 Apr 2026 11:06:34 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Apr
 2026 11:06:33 +0800
Message-ID: <b501f952-2e3c-4c05-b433-9d8b28ccc96e@hisilicon.com>
Date: Thu, 2 Apr 2026 11:06:33 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] PM / devfreq: Fix possible null pointer issue in
 devfreq_add_governor()
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>, <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <20260401033046.67482-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260401033046.67482-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 4/1/2026 11:30 AM, Yaxiong Tian wrote:
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
Yeah please do so.  That would be:
Co-developed-by: Jie Zhan <zhanjie9@hisilicon.com>
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>

The rest looks good to me.
