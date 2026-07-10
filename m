Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37825B0BB
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691921; cv=none; b=EUOMSGg8noNMVVrIwTAZNIRU4qI2m3/8JBbRkKzCTUrmVx6Y8fniTMqKq4VJd16t87Z3X1eMb8er2AW5Nl0uBRxTszBPnJ5T82IdcDzepR4/s2tKkuvqnN7c/5cigbz7zsXFYocxK+j11j6joZxtIT5BWvHM4JBvTDL7l2N+5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691921; c=relaxed/simple;
	bh=oDMFkzxjs/KXUSaVb8duhkY5CEnHTeJPvE9VzQ6FDQc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ktkavrIyIgHT0kGjaS9bLvTaqwbe/qMHKM+kWy86nqnfnlG8+4kbDmObDu/QbzivQcxXX16S7ulqEXnYpCC9agoj79kMLvVjTlqbwukAWUZZYH6hD7Q59eaTF+MEhBicuYP6KnZ4jy4ueQDgJmbmPCil2QaimvoOAhn8SYMn5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=HHVfu76P; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="HHVfu76P"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so1619110a12.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1783691917; x=1784296717; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oDMFkzxjs/KXUSaVb8duhkY5CEnHTeJPvE9VzQ6FDQc=;
        b=HHVfu76PljNItpbRCBn4egmQy6/B4UiN8P92zrc5eGS0B0Q65poEDe3B2DnA7Z6Omj
         TRLYt4zjm7+5inPC/IUfNvo//2eI5r69qMPEjguJsqgWCz0/oqUm0c3NrdqfYuX/ULk2
         KkBgXb/3Fk+qsAEF0xXvZ/6cpluqpHOdwJ8/jxUa5Aa6t3zw/F/7mgJSHK+gLGs/IUfZ
         2hF+DhfL9i5fU3Tf6lYwSsn0vroM86DXkbciETq8JhqFW/45D6CbeC7wAEUTIKuNktYd
         6V6IHuCITuCDgPxye6L4kDBBwpgQRO07k3FXBQCVSbaPCAoPvg1aNvS/tNygqakVAKXv
         yHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691917; x=1784296717;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDMFkzxjs/KXUSaVb8duhkY5CEnHTeJPvE9VzQ6FDQc=;
        b=XULxD/94TypAD76x7E+fR0I3S/1+3Gv//eeg0hdIQhLyPjNUCjkiVO0ufl4CrAkvSD
         Emo8aZ27SCWfHPnKBv5gHQ9hnT1Jc2l8aN08vP33N97/Nm7HDv6M5WEQJY/PkdzwABHL
         UINtA+L4FXIZ+ev2rm/aptn7p74eNxE6bYyyD703RZD5bIsxK25xtNQLciRg0Lz4eKt4
         4SUwPkkBN7awqW42sIGO5WLBr85KUAQvZXGDf2dprKbQ94Dq/FSg8kNjOGHb4D0QpnZ8
         r2laxOagGU3PIWrQi9vfKftaDvQxup3gVsBRUqtsIrlotDXr2zesnYdolrCpaFxah8NT
         q4Dw==
X-Forwarded-Encrypted: i=1; AHgh+Rom9kSJgOjKMsJEcwSfxATsiSN8B6M11P1lrJun3nWqXvboKItJ5I4O+e1k+EiCe3jks2rWJ/N8dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUe7rzEN8d5uvRe0J52kKfOIDDs1vUBeKN7nQf+VWkrKsH0IJ7
	AhA4sjMK7/tl3I4Ar1NdKlQEAxv27hWUHvj5Cv0UvIcOAvZiQXGPrElUM5j1cBaQvgw=
X-Gm-Gg: AfdE7clzeO2oG1S7S1lhVYVkgY6xB5SyR8+H0f8pMM5uXfDNauX8F0gzqy9hq0hK3no
	VNCENhppNHDeje4jS2UYplR5nwU+W9hqPK1ocbVt+lbDLf/KT2QG2xEMqBlgJ+YtgNE/q2PblxT
	JXG6DkHIJ5V2y+G5w2OWdJx1PIZ8BHtUtzf0IzP24t1KMF/Pb/jrR9ArXYouyOvfrdF7Vw8yf4m
	NeST9EnWkSHDlOusJaEvYhnqUA7BjcMsAXOg67s/LNumNmQhj7GTTafRLk12p8Fk2KuPWg4EGyH
	ZGSUVlbBo8SD7j/3S9cF4j426CjdOnATUg9gOFFC9ct3FRoNKDvxCwT7xAzrRYFTevRd3zc+xEN
	ifuFPgclcjWhtwwYzC5zr13YlLMtKdFvKIVR1WC57nJxl6BmS08WvRI5GiQphUiFG1oC/oWYUTL
	meA96VHIjwnN6iuqYOSorkpCjPAb6Zjx1XqSmOUBz1/QbfpKhPdmxCAHPs4w==
X-Received: by 2002:a17:907:990f:b0:c12:695b:8876 with SMTP id a640c23a62f3a-c15cded1355mr392545366b.5.1783691917105;
        Fri, 10 Jul 2026 06:58:37 -0700 (PDT)
Received: from localhost (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d3859f69sm407039066b.27.2026.07.10.06.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 06:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 15:58:35 +0200
Message-Id: <DJUY0I0R3DGG.1YC9D7H4AAI0J@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] arm64: dts: qcom: milos: add OSM L3 node
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Georgi Djakov" <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Sibi Sankar"
 <sibi.sankar@oss.qualcomm.com>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Alexander Koskovich"
 <akoskovich@pm.me>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260710-milos-cpu-opp-v1-0-ae7f4b09bc77@fairphone.com>
 <20260710-milos-cpu-opp-v1-2-ae7f4b09bc77@fairphone.com>
 <bf766035-54fa-4e98-8abe-22cf0a229ffa@oss.qualcomm.com>
In-Reply-To: <bf766035-54fa-4e98-8abe-22cf0a229ffa@oss.qualcomm.com>

Hi Konrad,

On Fri Jul 10, 2026 at 3:44 PM CEST, Konrad Dybcio wrote:
> On 7/10/26 11:22 AM, Luca Weiss wrote:
>> Add the OSC L3 Cache controller node.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> I'd suggest to squash this series into 1 big patch, without patch
> 3 applied the OSM driver will engage and perform sync_state (with
> 0 requests, so it will vote for 0/lowest) and the system
> performance will be tragic

Fair point I think, I took the structure of the patches from sm8650
which had it split this way but yes, it doesn't make too much sense in
terms of keeping system performance alive through bisection.

Will do so in v2.

Regards
Luca

>
> Konrad

