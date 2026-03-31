Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CD3E3159;
	Tue, 31 Mar 2026 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946556; cv=none; b=orxnlsfhe54sfYyCeKZEd1PM/OoqhReXyIgeVVqlrvHTzI88d7WKD/PWahzFQHVWlC8vzJQYLl4XMRrqKACAZV7DwjVwbsAOhfa3yYQlSSzUdoCW6ec409J+9H/Tmtb3WxsdxgA/vf1Q5FAfxuYgewlodNnGkTWvZhh+bs6emWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946556; c=relaxed/simple;
	bh=D1t+yE6fkk+j/umS+HiY9l7Qw9QTYPXCdmvu8dfRMAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnyAnKxCbu3muRfBDGN+//CqdUCywQDO7ZbI3mfP5B8S8In9VlOPiMR6RClKXT6iD6e4KvDzz5WjwYBQKiNFI4MoVUIvSeCygMPOfQw55R2gZQKxu6p7Cjh7rN8Wdj681/I3/IQNGKYLsGEW38LAlFozSdDAnSxVZ5z9iM6PbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoZBvLrs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoZBvLrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4E7C2BCB1;
	Tue, 31 Mar 2026 08:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774946556;
	bh=D1t+yE6fkk+j/umS+HiY9l7Qw9QTYPXCdmvu8dfRMAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GoZBvLrsv9/2n9+nM/AE23Uf4LFzQQY0NYpbUUjHchNAzD6DJRTuMUXuCh/WqlhsW
	 yD8EdYl6sX3yxxc3iI+FcIq6Jf8ZOx3Eyw3kSuCIKwmgYfi30SnzbJJHhLgeUtpqmw
	 9ZPxReN//C/26HWkZ500HQj6y1/79htA5oSDJgpJmOhg4OEI1FlPxdNGINVZvMIZKk
	 bAESiyi+/NnYvt645+Hixvglo/MSa4Sdl0leo8i7CH3mgDuDKV1wxnGDFdAnXsirhj
	 OgpdsXF147hkpsfsIGfBED61hsFDtFGIF+1cUy6YHTX/STKfCPXhmh2KKzFktoxN/x
	 Q9Osy/Mm+ncCQ==
Date: Tue, 31 Mar 2026 10:42:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Hawi SoC
Message-ID: <20260331-shark-of-exotic-discourse-7b9d19@quoll>
References: <20260330-icc-hawi-v1-0-4b54a9e7d38c@oss.qualcomm.com>
 <20260330-icc-hawi-v1-1-4b54a9e7d38c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330-icc-hawi-v1-1-4b54a9e7d38c@oss.qualcomm.com>

On Mon, Mar 30, 2026 at 05:40:00PM -0700, Vivek Aknurwar wrote:
> Document the RPMh Network-On-Chip Interconnect of the Hawi platform.

Test your patches before you send, not after. I am not reviewing this.

Best regards,
Krzysztof

