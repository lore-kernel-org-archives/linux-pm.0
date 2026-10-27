Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063454;
	b=XQ8xqbtElma5oiE476JjIYfty4+bAjT0w4FzJbWdlnXFYrO2P6OEegBe/yg53b68x+Fj
	 El4IRLWE4ljiK/SuPUvhhdu8haAvbA+bOzz20jt6VULbhWiAH1fTMLvDr494qXjH+5RjX
	 D88rG4wEKg6yH212yc470nqUJV9naICJaPJPnS+8KS7tFZe/uRTJIJXXtH1GINAHVgSBp
	 SM7BV3Hjpi7Lxh/aM4z4e6f5QvqN9C9ShIBKSNcz9vR2HDk6fN6rkSGXHEBGvcRFxw72t
	 1cOCebPmdWRzLgMLKsz1Ar05H/2oABXld22omi5AuQn/TwXds+bN5bqce7XU32TnR0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063454;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=BLytvqSWYrBr7L9UFKswaQyVlCa3Rxe50pFv8VUZDS4=;
	b=iZTil5XuEGOwet08OhIFOZhPb/Z9nH4yVIXBlhG3FObFuDKergj7hxMoPk6fTZh5mG1W
	 44mbYX2j9D87lHCNfaF2QtbKlIXlRL2JhOsVC2ZjIgx01qg7kmeYxo4llkRI5e6gml0Sh
	 /yaw4dcMN3fRGQEhnbCQ1AU0d5osCuQJNONiLdshi/fU62BsMUOC+m4k8fkgcDHVWqOIy
	 H1EjX0WeRfCCtRLYTzPqxxFBhTbefmXi9QPndxUVOB4QNmuZjmt71UNyCvS/bO7hsx1lh
	 +HHcWhNvKMiTJqVeSPf6ZGwzVjVQ/ewfvwbxehpFXNjWRriyqZX4Tw8+dT1XNV+lixQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b="ge7N/YRv";
	arc=none smtp.remote-ip=210.79.60.46
Received: from mail-m6046.netease.com (mail-m6046.netease.com [210.79.60.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9249606A31E;
	Tue, 27 Oct 2026 01:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9249606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=ge7N/YRv
Received: from [172.16.12.11] (gyproxy-mailtls0-entmail-virt215.gy.ntes [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 526f37367;
	Tue, 27 Oct 2026 09:10:37 +0800 (GMT+08:00)
Message-ID: <080cffd7-05e6-458d-a00a-b757b0f44aa5@rock-chips.com>
Date: Tue, 27 Oct 2026 09:10:37 +0800
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
To: Heiko Stuebner <heiko@sntech.de>, 1579567540@qq.com,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Elaine Zhang <zhangqing@rock-chips.com>,
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20261026-add-board-ok3572-c-pmdomain-v3-0-70d614d3d921@qq.com>
 <18fcfe7a-e25a-4516-810f-d787b779914d@rock-chips.com>
 <d4e92131-ceb8-4143-b8f8-21e7f9638bdb@rock-chips.com>
 <3329883.fEcJ0Lxnt5@phil>
From: Finley Xiao <finley.xiao@rock-chips.com>
In-Reply-To: <3329883.fEcJ0Lxnt5@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa17ae8c54403a8kunm924ab6b13756aa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTU9JVk9PTEpJS0tKHkxOHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ge7N/YRv32U28Nwb4OcpHegrzM3yN4taMwOhX154ZZfvgCLbC/59Dy+jBHoNCN4aZRuWMU6xP31hcCM06/Q6kvWr4kjlclrKMl6OYR6h0L4Un6JhNlzizXNtQVkTp1rNW/B4MoldNvGfKJ7v6ugcamg/VxO/6JxWOr0ugEPLnGg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=BLytvqSWYrBr7L9UFKswaQyVlCa3Rxe50pFv8VUZDS4=;
	h=date:mime-version:subject:message-id:from;


在 2026/10/26 19:53, Heiko Stuebner 写道:
> Hi Finley,
>
> Am Montag, 26. Oktober 2026, 12:37:06 Mitteleuropäische Normalzeit schrieb Finley Xiao:
>> 在 2026/10/26 16:47, Finley Xiao 写道:
>>> 在 2026/10/26 11:21, Cunhao Lu via B4 Relay 写道:
>>>> From: Finley Xiao <finley.xiao@rock-chips.com>
>>>>
>>>> Add support for the RK3572 NVM0, NVM1, PHP, and VOP power domains.
>>>>
>>>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>> I have to point out that the changes (the shutdown/restore
>> rework, pending-state tracking, etc.) were not made by me, and I have
>> not reviewed them in detail. Therefore, I should not remain as the
>> author (From:) of this patch, nor should my Signed-off-by be kept on
>> it.
> As this seemingly comes from the vendor-tree, _some_ Rockchip authorship
> should be kept I think?
>
> Do you have a suggestion who that should be other than you? :-)
We have never carried code like this, and the other parts also
differ significantly from the Rockchip kernel. It does not appear
to be our original code.
>
> I guess as you suggested splitting this anyway, that authorship
> could also be split.
>
>
> Thanks
> Heiko

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

