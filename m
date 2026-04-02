Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4325F3CBE61;
	Thu,  2 Apr 2026 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170492; cv=none; b=tfS1pQWVeHhhhebkLlx63q9fDTXc+ypoF63YQVy+YI4yn7N/hhDn4L50I+7bdN3e3tqvmg2u1nfPVDoCGhkYZFOJHS3Q1Dhshf80nvAdVcFs/cnTc7uLJs+i+TTWVjanf79uHctDDo1YYbRqj6k460jkLYB97PH31Qr6c0bF+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170492; c=relaxed/simple;
	bh=gTJzfjLipQ7RVXKjNF0EoUEwnvSwwbF6J4IG1xgIxDA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VrSkdBinimfGCfontQ7uukZWeLxC1ywPFvF058BHKaZkMS1POnfyCoZGbldLKzkoEzLQ5GCn0tIguaR2IdYCcMtWmemrwO+bhLs4SeYqj0lqV9TgsMQ/59qdv9SESMHi7d1dzG2C4K2OaD745ZYU8ALAQh3/XelVCFtZo4zNx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41C3C2BCB0;
	Thu,  2 Apr 2026 22:54:51 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 4D9EC1812B8; Fri, 03 Apr 2026 00:54:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
In-Reply-To: <20260315-smb2-cherry-pick-v1-1-b2710e470490@ixit.cz>
References: <20260315-smb2-cherry-pick-v1-1-b2710e470490@ixit.cz>
Subject: Re: [PATCH] power: supply: qcom_smbx: allow disabling charging
Message-Id: <177517049029.464276.9815426789369592499.b4-ty@collabora.com>
Date: Fri, 03 Apr 2026 00:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 15 Mar 2026 20:40:16 +0100, David Heidelberg wrote:
> Hook up USBIN_CMD_IL so that writing "0" to the status register will
> disable charging, this is useful to let users limit charging
> automatically.
> 
> 

Applied, thanks!

[1/1] power: supply: qcom_smbx: allow disabling charging
      commit: 98d68b74ebb9d5f145960ff7d96ce8e7a39fb965

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

