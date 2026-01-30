Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5108389DE1;
	Fri, 30 Jan 2026 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811873; cv=none; b=r3sh8uU8qJYrHMxq1IQEhu9jx/Pw92OiN+MjlAyb55qMlyx7PZtQdtU7Sb3Iiyeu1QdUbw1b4hNHbOVzMQh7iubC010XfdhDdGUUMulL6dMph2X/zMs6G5eSaA4Cf315mPbDR/g29Z7CzxjBhUEzRKnuhI8pjkWlZBUuEQdTf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811873; c=relaxed/simple;
	bh=zOEeZvG331TLVII7GGC285+IDytt3LTSdUm4LzedQHA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rQISVwgMFs+ld/pY+ztt10+uvZz5qFvWDvf4CXV/2b0/TF9aPQKCYsmVS72EdgSTPf8GPaDtXlhWS0a6i2kXmIu17f7KwnVRoXqosJkvtaNt8XvNCLsLpQ+0CbXMqvODNsASuPeW3FFwE3yszZHIkTE9SHTGNMPiMJCUdU97xXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B51C4CEF7;
	Fri, 30 Jan 2026 22:24:33 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id BFCD2180597; Fri, 30 Jan 2026 23:24:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Val Packett <val@packett.cool>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260120235831.479038-1-val@packett.cool>
References: <20260120235831.479038-1-val@packett.cool>
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: Recognize "LiP" as
 lithium-polymer
Message-Id: <176981186777.331784.9530093239041522669.b4-ty@collabora.com>
Date: Fri, 30 Jan 2026 23:24:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 20 Jan 2026 20:57:58 -0300, Val Packett wrote:
> On the Dell Latitude 7455, the firmware uses "LiP" with a lowercase 'i'
> for the battery chemistry type, but only all-uppercase "LIP" was being
> recognized. Add the CamelCase variant to the check to fix the "Unknown
> battery technology" warning.
> 
> 

Applied, thanks!

[1/1] power: supply: qcom_battmgr: Recognize "LiP" as lithium-polymer
      commit: c655f45480637aee326b5bd96488d35ab90db2b0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

