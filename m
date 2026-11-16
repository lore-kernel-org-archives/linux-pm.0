Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839054;
	b=Vq0r9k8qjDnK+uflXCfAIYP1uo5lvw2vfoz1vkJCqzEamUeQdFAIu5KVGfmEQMj20Na3
	 ZR9hzXXXDntyGPs7mYPon+y2nkwmdCQ63RhhUheXdLbbGpnlW1V17jxy6bxwtxSu8ULVE
	 TrhKANc/mxd8dTKH0KMYFWb3Ml2ny3DzVpkg3qupTKDBsnhe36dbpVqXQ/Ajw/RGg0seX
	 fJwamRz569zp1xQbcFPkekfK3e9Bybk89oDCFIUExnfLIDUgGrZlGTRKIzWvnXg+QwLwx
	 BYOk6WcBttS55uLHkIZyBTe6J2MOFSdB2R0s2aDbAylKel0LcwtWJ3B8vDUdE05ASFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839054;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=eR1uMzWk87sdlr18ySoDXRPmlYlKL1zzSUHsdZpv0Rc=;
	b=jPV08IsBWOH4tEvWqeJ140XCv/nLqjINtdQxF/O+E3t1/74rbUucLEHU6+6mker/t/Qg
	 EZ6e2Y72MYPB+OZhMFLd2Lc14AvzFFB/adqVgOhdouAblInJLsE6jwrcExLxXy+hA1yWZ
	 B+or/wZwePensMUndvrdnSC62/3k/MRPSmEMXWm/8qEc9FiC3TD7DqmXiV//B+2dYpqfE
	 uw9MPuDb+a3cr6zunaDQrKeoCkNZCv0ta1l5ZLtQfSKX4nSsEiDMZCVI18dY2Xj5ZlSqd
	 VIDTK1GrQaX7Z6Ws3D2woNDaQn+YGKVpAzGig8qeDI0ZbEl7Xda6NdFngh/Sk/LKWSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="XrclSol/";
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE731606A31C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 14:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE731606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=XrclSol/
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id Spl6x4ZqDJFmFSxctx9uwA; Mon, 16 Nov 2026 14:24:07 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id SxcsxvQreGh2BSxcsxtZyA; Mon, 16 Nov 2026 14:24:07 +0000
X-Authority-Analysis: v=2.4 cv=Aszu3P9P c=1 sm=1 tr=0 ts=6afb1207
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=hhRZiPmDs0itODvUV34A:9 a=CjuIK1q_8ugA:10 a=3T6Gmkx0uuYA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eR1uMzWk87sdlr18ySoDXRPmlYlKL1zzSUHsdZpv0Rc=; b=XrclSol/tJyhgQ4WzTN29B21wF
	Ttdfgqpn87vsgCvE498ft5qcqXEkMpPfqnddxrUa7MLiZr2aSNsD1StNMwbAaubSCFX2T0fhkfklG
	lWJhtcvKRqBIQKicu9C2bi6VF3wEu33wZ4aeXaTSd5YUiODr2quYsjyGJd8Y9G+ldIwGsdbiNGiHx
	3M2LSSE4Ms4Of8pEYvrnS8d8tj7375A0SqHkZS9ZcuR0EDaN99+gD1hFq8EKlfptWg1cfgFhU5qum
	mD0b1ZYZ3TvXo1qp99GaeIugKK8ycJJwcLfRf2Yo4X7K6cQLyl0H2uhTDq8vpLsvzp9qm/SBSuA99
	6qABMVEA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:51630 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xSxcs-00000003mbz-1DYS;
	Mon, 16 Nov 2026 19:54:06 +0530
Date: Mon, 16 Nov 2026 06:24:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linusw@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: arm,twd-wdt: Allow power domains
Message-ID: <0a3783cc-cba0-41b6-a411-fd95beb1da6a@roeck-us.net>
References: <20261116-ux500-watchdog-twd-binding-v1-1-a26adc9cea5e@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-ux500-watchdog-twd-binding-v1-1-a26adc9cea5e@kernel.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xSxcs-00000003mbz-1DYS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:51630
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 14
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAbQuE1JmZl9upVVy9GGuNgLeD/e/wdI9u0drcysYANB07IMSvcrd+A6mOH90YAxMQ3uaO0oHMlTV4jB3jZwNtGykFnIU/CxO3F7YOKIH6XDhY4RLPaB
 jE6/8ALtb5o93evX8axU6j0BK6i39sFv+1slYVz4xBjiHbEy71E8QuxVBGNfXAYFTaD1xfHHE5455wR0PKQKcyl5/0od8X3YJmAYtBE8FiLoxg0ddQGZd42f

On Mon, Nov 16, 2026 at 10:49:58AM +0100, Linus Walleij wrote:
> Allow TWD watchdog nodes to reference their power domain.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Applied.

Thanks,
Guenter
