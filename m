Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CC35AC0C;
	Thu,  2 Apr 2026 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099443; cv=none; b=tXCE8vDBhOXg5qShWOCi8mhzJbZhcpC8Vl/a0ERfzVK3TJT1tojiOmRiZ8geaiAEyyKR+XUqpcn5DhHZC9Wke/devDxTcTzPTS91gKsO6QVrMOtyVsotsYI2vSuZkNHJchcQxjUBuPjO6FaacidivP2u9IpAS5UIGi5dZml6MkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099443; c=relaxed/simple;
	bh=qmO7QNYMlvs5r0tyrRYTb4ZMAXIGgi0zvwS/iBvWysw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YJ0iJ96ilT8BoONDUzKJFroBVEtIJMlH7IZz8NzA/muoXUZvItjjROFV2DLUqDuSxYsPw0IKxJ4ftneqptFWtXgxKIaO6s3lC/1t312998gRXkEEWXP+2MZT+Lv5zkalF5lLuFymHJpslKcsGRHxh/vj/F75UONY/nJRzruS9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fmRXF37d2znTV5;
	Thu,  2 Apr 2026 11:04:13 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D6884056E;
	Thu,  2 Apr 2026 11:10:39 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Apr
 2026 11:10:38 +0800
Message-ID: <6a35e342-be2e-4400-9ff9-77117979da5b@hisilicon.com>
Date: Thu, 2 Apr 2026 11:10:37 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] PM / devfreq: Fix available_governors_show() when
 no governor is set
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, MyungJoo Ham
	<myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
	=?UTF-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>, <nm@ti.com>
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <20260401033055.67608-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260401033055.67608-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 4/1/2026 11:30 AM, Yaxiong Tian wrote:
> Since devfreq_remove_governor() may clear the device's current governor
> in certain situations, while governors actually exist independently of
> the device, directly returning EINVAL in this case is inaccurate.
> 
> To fix this issue, remove this check and use df->governor for validity
> verification in the following code.
> 
> Fixes: 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
Well, you should have picked up my RB.
https://lore.kernel.org/all/baee47c8-7b29-42dd-a64a-167c19c4593b@hisilicon.com/

Some tools like b4 may make that easier.

[...]
