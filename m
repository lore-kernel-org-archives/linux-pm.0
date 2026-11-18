Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992332;
	b=HjE2c9WiJ/QaixnL7ha9YdfMSihIunefMIRwWno3AYUDcgZSYwxKicOnzWrVUKKTEdRj
	 Ip/q7Hg0TmdeLAHOK/HvkIB7Ds4whTjZqaI9Tar+7ZY6/6OMnUnaTWZdyMb31grpYkANG
	 bHbnyRoCWnqcNyHJ3siGfDzBaROyCwuE8GQfE7rIcDIHMfXcJxU2D/XynKzx0WhQfb9C6
	 nb+poH3vz7FPV5SquhqUTIH3mCifGoAC/8tlk/iXtmwufAqQIAvvOWNjbH6q4O4MUHT1U
	 5fth8+PJADBqqWBh6vR/FBIp6ZVDWjdirEgQM3u8M0W88pvD7gBGSWa574ibUk7cG7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992332;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:Message-ID:
	 References:X-Pmail-ID:From:To:Cc:Subject:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=jVVXS/jnDco2P/3gCjkpEAukeO5Fs2fg9YH9GXORFA4=;
	b=lyvVBq3ZPdpUY1vzuEw7ySenjCQcbTqr4zXtLWmDKWS6vofrEXxqVhTVqgayBjp8rvNh
	 jmXWG+a60dpIECCdx5BtcUFIZ2bqIGrpR/SLeEmGKj2yU+4h3WUZwtv3eTGBo7scQefVY
	 laMxrEzWCel9rsHetXoheVFkYTKfHLJylpwcmhSgp/XhcnWrLaBUHfW33uEQYa0m6W+gX
	 ygRwPtM0DqmQAkWTjMTDXoatA7N/KV1xzTc53xnGPOyt7qoWiRhE3n18AAWS4VWA7agvf
	 1YUZdwiTbDDBbmncbZmeG7j0ACJU4LZ8CFChDSXkuBwBlQ2RKh/vUWmFWCPWhaLyKpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=brar.si;
	spf=pass smtp.mailfrom=rsend.brar.si;
	dkim=pass header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=hjpjwlBm;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=V9PT4V0S;
	arc=none smtp.remote-ip=23.251.234.59
Received: from e234-59.smtp-out.ap-northeast-1.amazonses.com (e234-59.smtp-out.ap-northeast-1.amazonses.com [23.251.234.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C3606A336;
	Wed, 18 Nov 2026 08:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B80C3606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brar.si
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsend.brar.si
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=hjpjwlBm;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=V9PT4V0S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=brar.si; t=1794992330;
	h=In-Reply-To:Message-ID:References:From:To:Cc:Subject:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=97yb+XIW0xH5i2iuGi731NFZ8TW93don90Pf7fYJALw=;
	b=hjpjwlBmzHy2vy3M7hV2FvwX2hIiNGdIWg+iubTHkFn4I0zpytsYwEJwwxibpMuy
	R6p/L5eItZAZ+RUWsjLRhP7cZRP8OEIQ63sGFbC0S5UQGHYaff9vWCwECK3yxAR3cHq
	XUZi9idEm4H+ZNcD7oYN4X6r4PdoSgUPPidH6TXM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1794992330;
	h=In-Reply-To:Message-ID:References:From:To:Cc:Subject:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=97yb+XIW0xH5i2iuGi731NFZ8TW93don90Pf7fYJALw=;
	b=V9PT4V0SC74g8fWZ0KowtlTtnbORYLbuX2gE/b6VhOxHzkWnT6uG4JViDZ0/l/4O
	/798JE9ySI/q/gYAUrYSme+RZAdj+3lqAclXl29hsxEkgbqRHX/qNrZMjzK2UfPswe7
	RixYk5iVpJ5PjwueQ8VYD0H4GoFmjIt7oRGGTBeU=
In-Reply-To: <20261116-furious-powerful-nightingale-8adcad@quoll>
Message-ID: <010601a1ede155ce-82682568-1b1f-4897-8096-50a959f8a483-000000@ap-northeast-1.amazonses.com>
References: <20261116-icc-sm7250-v5-0-506be082a3c5@brar.si>
 <20261116-icc-sm7250-v5-1-506be082a3c5@brar.si>
 <20261116-furious-powerful-nightingale-8adcad@quoll>
X-Pmail-ID: <1794992329438.f8b425439611@brar.si>
From: Ishu Brar <patches@brar.si>
To: krzk@kernel.org
Cc: djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, konradybcio@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: interconnect: qcom: Add SM7250
 RPMh NoC
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:58:50 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.5YL5VvZ+qZ0e19wo5UdMspzrKjMAjMWs/SlfuwHJq77JVCQWpVGwyETo7FaXf+sztO4bYMxF6WHssrYHSY+K7X2T1EZhOskwm44pQQStdKG0Jdj3d5ybzIXFkMTcPBXllY63oWIrFhJN26LFqLzTuHiXuqj9UCHxIuFhxi7IM0GCfceBHtKocmWdFsR9dK9X:1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.11.18-23.251.234.59

On Mon, 16 Nov 2026 12:03:41 +0100, Krzysztof Kozlowski wrote:
> On Mon, Nov 16, 2026 at 11:58:00AM +0530, Ishu Brar wrote:
>  +
>> +  clocks:
>> +    items:
>> +      - description: aggre UFS PHY AXI =
clock
>> +      - description: aggre USB3 PRIM AXI clock
>> +
>> +  interconnect:
>> +    type: object
>> +    description:
>> +      The interconnect providers do not have a separate QoS register =
space,
>> +      but share parent's space.
>
> Sashiko claims these do not =
share address space.

Right, the description is wrong for two of the three =
children. Only
compute-noc (under aggre2-noc) has QoS registers, and they =
are inside
the aggre2-noc register space. mc-virt (under gem-noc) and =
qup-virt
(under system-noc) are virtual BCM voters with no registers at all=
.

v6 will describe it like that, allow each child only under its own
parent, and also add the IPA clock to aggre2-noc, which the second
Sashiko point is right about (the IPA port QoS registers need it).

Best regards,
Ishu
