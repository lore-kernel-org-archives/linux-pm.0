Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793162656;
	b=eAr+2qsEh0B45xRE5LDkWzHQVGgrKupNn9wOO3a1IrbynkGa4LJHhJ/mIOpsDWwLCNgT
	 mkGEQYOaET8EMtWlS2sV+Ec5e8V6sf/DQF8HdMBzGAWt6qPm662Tt3XwkAYRsZtL4YK8+
	 32MlOH3IWv4cLc5NZTBt9zDw5gj7PgQQP+NMclW8DlJXWHbBKKrWuRIWgsQLdhQfDKfc3
	 7hT1STxeB4Kpr1S70QlDcxRvGW/GQK3b8OEshkudEcUaO61lPjAsAajhZEnlIpU8v2AAT
	 ZcaA0OwqxSCjWzW+QYSG2swBOl0ubCfviKSGplIhZFmTCt4vNLcecz0Cu/BlybQVn1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793162656;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:Message-ID:
	 References:X-Pmail-ID:From:To:Cc:Subject:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=INKO3SiRV2KiLXLhHOgnnW2mnAbTSrFHoaWGvNMg/W8=;
	b=mvhoHqeQyYxxAWVyRPD8PmAoZOCe67AQOm9oLxW3+Sc8SoyE1Etm0msuvVSmpzItmScH
	 OhiJfocOGDy6E/JQu+vW/XVs16ObX3E/XTmSbPVlu/J8JhXTSpiXUg0F69nJqR0nO3Zpu
	 sNptAT+o9MiwtuWDdc6qzyqKPJJAEx4VUR911bRnRrEDWz9RtL4FDU4HI/1nZAstBnDsM
	 qTnRWLOApoS4Nw29KYk83x/0UkftUeCweT7njVFQG7pFp+l2Laa58aUS1v+E7oww4vLuh
	 z8z+eI3ZombC3lqnKXi1Kw+4w0poxCx4I6EJy3gAk9Wb8BQtVd+2Oooc79O6q7kQX6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=brar.si;
	spf=pass smtp.mailfrom=rsend.brar.si;
	dkim=pass header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=kdC6GVlt;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=Y5Zbddrt;
	arc=none smtp.remote-ip=23.251.234.61
Received: from e234-61.smtp-out.ap-northeast-1.amazonses.com (e234-61.smtp-out.ap-northeast-1.amazonses.com [23.251.234.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2D606A31A;
	Wed, 28 Oct 2026 04:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DB2D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brar.si
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsend.brar.si
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=kdC6GVlt;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=Y5Zbddrt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=brar.si; t=1793162654;
	h=In-Reply-To:Message-ID:References:From:To:Cc:Subject:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=INKO3SiRV2KiLXLhHOgnnW2mnAbTSrFHoaWGvNMg/W8=;
	b=kdC6GVltO0nKqK9WNToOI59+phheT2qf31oTxyPe9/yShX0T3czUTGutpRmTRyj3
	2qtnhxptuoSE0U7otke1HU/8h5jmpDLjIOwUvo8OmWwIEZsVCQboqsLVxC1f3QJOheq
	hMynls/hwirpmfqEtatDmfGflhmZBHJ0GT/QmC7s=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793162654;
	h=In-Reply-To:Message-ID:References:From:To:Cc:Subject:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=INKO3SiRV2KiLXLhHOgnnW2mnAbTSrFHoaWGvNMg/W8=;
	b=Y5Zbddrts3lZilrY6mM/RRQjDXJSu8Y9pEvK1NUrKbOteS/ZahGFoWmNDKrO6bXR
	GICpEbXEpYfqmEkL1TS+3GDVM3UXptas2aBumK0hCfKUP5yETddW3pJ1Rk4+Jt+t4tN
	ip07nTauKwTYHHf4ljtSeDtp8wZFLJe0T1xFCdxU=
In-Reply-To: <20261027-married-jasmine-hummingbird-dadc1d@quoll>
Message-ID: <010601a180d2b177-f7b0d42f-908c-4d36-8aab-bdabb6a2a1b9-000000@ap-northeast-1.amazonses.com>
References: <20261027-icc-sm7250-v4-0-f9bdaa3c1c7b@brar.si>
 <010601a17d6212dc-ed028a84-ea72-48e7-a4d8-fea315dc42cc-000000@ap-northeast-1.amazonses.com>
 <20261027-married-jasmine-hummingbird-dadc1d@quoll>
X-Pmail-ID: <1793162653048.f55bc3470704@brar.si>
From: Ishu Brar <patches@brar.si>
To: krzk@kernel.org
Cc: djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, konradybcio@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: qcom: Add SM7250
 RPMh NoC
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 04:44:14 +0000
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
X-SES-Outgoing: 2026.10.28-23.251.234.61

On Tue, 27 Oct 2026 19:38:34 +0100, Krzysztof Kozlowski wrote:
To: krzk@kernel.org
Cc: djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.=
org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.=
kernel.org, konradybcio@kernel.org, devicetree@vger.kernel.org, =
linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: =
interconnect: qcom: Add SM7250 RPMh NoC

On Tue, 27 Oct 2026 19:38:34 +0100=
, Krzysztof Kozlowski wrote:
> Cover letter is missing,

Sorry, my mail setup rewrote the Message-IDs, so the patches lost the
link to the cover. I will fix that and resend.

> but you also never =
responded what is the actual hardware here - why
> sometimes you have =
children, sometimes not. How is it supposed to work?

compute-noc has no register block of its own: its QoS registers sit
inside the aggre2 NoC region (0x1700000, at offset 0x9000). mc-virt
and qup-virt are virtual providers with no registers at all, only BCM
votes; they belong to gem-noc and system-noc. So all three depend on
the parent's register space, which is why they are child nodes.
v1 and v2 had them as children; v3 flattened them because I misread
your comment, and v4 restores that.

Ishu Brar
