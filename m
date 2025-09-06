Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66A296BC4;
	Sat,  6 Sep 2025 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757195110; cv=none; b=MQbjC1h9sCHTVztKpV4bnOUE6/e9YPsbQwmQXGskH0+wFAn+nkweuufWNEmKBo+yoRTJh+VH7WENL4xiuJ9UhOSuaA6lLZmIXe5Y6J8LEfl2qicKyzv3tNdr4TeLf/fDPOJdc+bScOolwX2CDgmOnSKJLefXjx3vMTBbS2eX+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757195110; c=relaxed/simple;
	bh=VzK0XPr7AXZsyOn2Cqhxf8005HZCUF9KNfskUhyV5Ms=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uBXQD0GRPbTjrK7N2fF9L7XjDfKvg2yLgYtgGGtWofju1iNd7guba5Tu2CkBJz/DZfri/rBki37K8MNirwhrGvJtPyaEj1q4p9m/ZvVSL/h/ItklNikJxxVSSz6KZZaWtPrIJ5MtZtQKz2znQC+4B1vwy7p5CYLCjHfhRnfdGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE2EC4CEF9;
	Sat,  6 Sep 2025 21:45:09 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id CEEE9180B2F; Sat, 06 Sep 2025 23:45:07 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, chris.ruehl@gtsys.com.hk
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ruehlchr@gmail.com, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250811152209.37131-1-chris.ruehl@gtsys.com.hk>
References: <20250811152209.37131-1-chris.ruehl@gtsys.com.hk>
Subject: Re: [PATCH v1] power: supply: qcom_battmgr: add OOI chemistry
Message-Id: <175719510784.45380.14398122215810434964.b4-ty@collabora.com>
Date: Sat, 06 Sep 2025 23:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 11 Aug 2025 17:22:09 +0200, chris.ruehl@gtsys.com.hk wrote:
> The ASUS S15 xElite model report the Li-ion battery with an OOI, hence this
> update the detection and return the appropriate type.
> 
> 

Applied, thanks!

[1/1] power: supply: qcom_battmgr: add OOI chemistry
      commit: fee0904441325d83e7578ca457ec65a9d3f21264

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

