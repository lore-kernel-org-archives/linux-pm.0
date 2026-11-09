Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187379;
	b=COCvI7OVIBxRAyhmRx3PQqca8yarm29GWB4GvedJDp248XDo2lF0qkwREishBCl9z1zH
	 /DKVB0bLxd9PRbA6GjlpOvcI+HGkInI3Kj0x27TIq5yd0tIhuPbPapJtW7+/GkHkvpPHN
	 H0SrjtcGcWXBQfSvlyqbm1A80u/Cd1fEvMBGkh8TixOPfDrSYMIUD0ZuSpr3h5V684ewH
	 EVX6P3UWBU2f7ETqJOXCj1txnjwjjknricG+Gsuz/3n1OiWVe5WP7lzsabLEyUTZSTd+U
	 dzM2vgMy8XcDCJysVi/cHVTydas2XA9mTIl5DOkk87N2E8q4qcbmprlQuD2x8gXVRBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187379;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=y1VVlfYVEXPOIy9ebvo45/kjNstUtjwITbL43gazSMs=;
	b=WO9mjfHwjlaOZTNNaYJ1vGmvBThjQakGFLQh6jQQ1hUXZ9kDQ7+OcGWXCTv42+19rCxn
	 QjmeB2PWkgWVxlMOHhEKFTZcwhPi3z/Qgxs3COORE7DSp7edBlRRuCihEDsenN4KBR8rb
	 mtla2iPLFyTsZWiDeN8jsgvtXpN5JXVhmKRTOPwnIJDt2BL1s6InJJjTjqwHvwn1eExLM
	 CyX9EYucvpGAbN1yumwHeoq0qTLujs3s6DKgulPMUQBW60ObYUc1cvPHlK9RfNqoujF94
	 Y+2GWCMH67TSJMRetu0vhaLO6m6xGQ7uqB9UV8biPnhsnNHd1EUjhOkHwQS7zvCxL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD14606D830;
	Mon,  9 Nov 2026 01:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05EA1F00903;
	Mon,  9 Nov 2026 01:22:58 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E841918248B; Mon, 09 Nov 2026 02:22:59 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Joonhoe Kim <26rote@gmail.com>
Cc: konrad.dybcio@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261007123939.1679-1-26rote@gmail.com>
References: <20261007123939.1679-1-26rote@gmail.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: Allow setting the USB
 input current limit
Message-Id: <179418737994.1255445.2650014859528547732.b4-ty@b4>
Date: Mon, 09 Nov 2026 02:22:59 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Wed, 07 Oct 2026 21:39:39 +0900, Joonhoe Kim wrote:
> The SM8350 class USB power supply reports input_current_limit, but does
> not allow writing it, although the firmware accepts
> BATTMGR_USB_PROPERTY_SET for USB_INPUT_CURR_LIMIT (in uA).
> 
> On a Kaanapali tablet connected to a PC port, the firmware keeps the
> input limit at 500 mA, which is less than the system draws with the
> display on, so the battery discharges while the supply reports
> "Charging". The vendor kernel sets 900 mA on the same port.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: Allow setting the USB input current limit
      commit: be5e7367bcebc6f51c5ab809e1898eb716ff4409

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

