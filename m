Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679080;
	b=acnyH5uUW1XimjyceFzXED+WlKocmC2D5gGxmj/VXaJVFT3DmB0EgZOYCrL9sWgh8dTU
	 Ot5ksaUgqJw6Fl2nPPIrGNNwA+wBxf/irusoYdwidtvu0BFZK+WzxNXZHxrf+sJC7Gub5
	 LXrXzNmmZGilh5NWTTzQ7K0TSWz/I5JzQxebnh5OLvulwbFvDFvvKUeA9hulfsz8QIPSG
	 g67eAQILqehgydvlY3xXJG6K7WDn3RDGoHr6T77mqBkN5u6vN1g8yDbz0xzWilVNkQ7xs
	 ZT69UbB+W0dzosvWTI8gZic4PRyIAlHvoDAd3zzdBxsqlzLXO1SeL9NvvY5ghYbuoVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679080;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CI3BCrrM6S0a2tk2nkE8USBufOr5oglVDVMGzlb/u8Y=;
	b=yQqcdXCo8OIjIzNOhguLCyTpJOHfC42QWReS+M6i3SYkNJW2vc1bBoIbQmF0Zej77dkp
	 PInqss1VdEvzL1YEPsgawuU4g3jhS4UDRPI7l61wlIa03eM72f9sj/DO58YW9BANObQO7
	 IdUyKBAv8yFTak+Ym78HGWkw1/YL01a0rHad0Is6teWAbjK+UbEuNvqpdtMQAJXb7rbjZ
	 WSW0YTdJqWM+2S57sWG1AD4uWwhfAakf2ERWEmnhNsueYhpa8+rt5DIt8A/9zoVH6o4pi
	 A7vZAkBjO7bfROJPHv59kAlzrVO0glBa3CvuFThvgTTnh45+pZjDJXXRuTTWoawFJ9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jaseg.de;
	spf=pass smtp.mailfrom=jaseg.de;
	dkim=pass header.d=jaseg.de header.i=@jaseg.de header.a=rsa-sha256 header.s=fm3 header.b=vfgK+1SH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=H7H2Yym+;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF9606A33D
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 17:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBFF9606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaseg.de header.i=@jaseg.de header.a=rsa-sha256 header.s=fm3 header.b=vfgK+1SH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=H7H2Yym+
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ABE4F140003E
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 12:57:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 14 Nov 2026 12:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794679077;
	 x=1794765477; bh=CI3BCrrM6S0a2tk2nkE8USBufOr5oglVDVMGzlb/u8Y=; b=
	vfgK+1SHr9oiV/4fkfj4w5rPn5LPF0RzZaCYEKTaRdFA+ASeCIWTT2xFGxKoj+8j
	MR47G8foJ0qc8f5KfdAIeWf7wAAqdjDkrLFHfPW2ygSIp2kfj8D3U3z8mgGFpUOG
	FvdDLYURXhAHTkGRZboY4gTLzffF3DlJTk9jNXJQe93+Ja+ayHOIOhEeXFZDmPfm
	HZgRS/99rP22FKMdNpv5jCiK5kj7iNwC6ofJmK+it/kxojXlhaU+AWyWHSwGWol8
	PBOyUUkK6WNyxBMQjIoHEOuCou+jUMutryNMCEr7KphI5mm7JYrCeS3hN3VFNEAV
	SeRIZdfqYz9G5g2yvaHYQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794679077; x=
	1794765477; bh=CI3BCrrM6S0a2tk2nkE8USBufOr5oglVDVMGzlb/u8Y=; b=H
	7H2Yym+xKk/bZedSTt+LxKY4x4H7agPWlt+FeKxnGBd8rIYNkHJKDMcvF3ZMCiHH
	1jWor4fgrGyO5vqFtOQRAUKg3S+wa84bzr16wqbixTLqbZ5E74oAJc/imu+1JsEb
	plpsJ0W2nOXmsPz9UV9zcSZ077cKSgIuPZZV6BcXWbRpRW+P8uRJH9Ie1jQ5XkvU
	b/D6J+umSaK518NMBwj3daRV7sv5B+INBBLK2Z6LATkwFnPseTR4KUXUwMMyH640
	gvumqO3ocbvEs9U7DdT/H5Lmv/UFDIgtAOLcaOe4+BGlexn1zEF67kZFHhbMTqlR
	Aywvw+LB3eQgS2z/jxIWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jaseg.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794679077; d=jaseg.de;
	mf=PGxpbnV4QGphc2VnLmRlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm3:rsa-sha256:w6kY2dtn1Kju96a+eVF/xWlRelA/fuBkdNLl/WAoQfqW4M1
	j+x/g4mxuxqwzKXHf1/U5uCG6Jos0bXtxcZH0nQxo9FdTRSSSDZEHfwcUZ76Fs5G
	8zzt/lLLtepm8zNf+9tRcdKdynn+C2OPSocKL2D88sq/GoIVd47m9M1341kE4gGp
	5cIIWMOflxwqMlPJW4tBSiX7SycOxaGxuzduP8YdA+ZDl2Gg73tC/AQtoEnUBbam
	uQyOIWDC+S6dVtFAnlNzJozgaxrANDnbL3X3qXf7ZSgcbz4vUgivV9+gCb40lQ+Z
	+cuJx4537lOzkBFPqLarKj/VSJdMNy6iivrrOGA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:fY7X0z7LldTHt79gxHxiZCmzIZljlhzw73fCozI9lZ8=:nt/UwJpbWE72ZU0e93SnePpLVAMG8C5iQifbZ66MrbM=;
X-ME-Sender: <xms:JaH4ak6YMCHRarwrthSeaLFa9bBUIbTJ-8DBLvgy1EfuZxt8Ylgb0g>
    <xme:JaH4ahtYoJOflPYz5UW8TXXeGDmAG7PtmS2sb-96ZUGSUad9fryv28GtlWCmQFnvu
    73QxFQz1vl2t15AVu7i7k5kSqwRRMA3ttNHSgB0Jq7rP3jQdvZ_uA>
X-ME-Received: <xmr:JaH4au3-olXUsQpTUXRM4L2q9sRsP34ZTSwhi5FHT9iUGDrbZTVK0FNEOCT3sgX_5j8N24yHJ46In9Sj2ULe_GtU8BikwhmxyooH1Ns>
X-ME-Proxy-Cause: dmFkZTEhm5E7Z6ZRBlBV9g4Ry/msUZzJ0LiKeTMEFVUrdxGjSFt2m64gXlT3aTVC6dPQTm
    ZfSUA+D9IBMj2GWSt9GdG/VSDb9cxDNJjG3uSarSdzLqxo9hhySslKaEf5HIuKHgwP5wz9
    Z9xboVdHmRusbbANNl8Dxx9TO5uv7nInEQ6u3rDubRcrReTC9VP9sQ19qx259xWy0kE6tG
    UaAYUz8mH2LBvGQ5hyqMpcp4BSdYV1hJs1zwRgFFFWthGQKut5S6my2FAR0l0VubWlDYCq
    88wxMwOrNat82x+QX4IeDz34FHRuQsC2DQDyteYdaPMpp/yNuikKlq0p8RZErYOB0ImrCv
    fXg9Ly4QkZVbGdjiaEjkAhfXlLGh4jUuv6BZQu6KR/uEIc/uy5RpncCI71r7EC7YBJ99U6
    ZSe3hrtkv8YiWdKfd9+zBlHourlhiZle4dMd7Qt6RN3FrWmCvio31l40vLKaAwsV4lSprs
    JHFBW1CY+ZDwDiIGGAQCsW+SHeCXBpck3TkitzKCS8dXCGrIiS8bdbBHCmY3Y+yXTDcVIJ
    lo+npnorKIuY3O8nzpjroIsN60ssIIJEfXGKcpJwEFe8/VTq3JeVjW9IKFgvEqKYUSGXNl
    uV8Hxe6jME8GfR1BXyvKOIxktYNHVZLpsFWem31zwK9eQ07YSm6lyjW1Bjnw
X-ME-Proxy: <xmx:JaH4aiq2maLzwQqOQHPE8Lz1IgLZ4oPbHP_NLfGfmBJc-6WrggbUkw>
    <xmx:JaH4amLiXvaWUUNc1lrv0rEkBLt62kZsDeUs_YwigsG7eycjPLie9A>
    <xmx:JaH4amRBIf_YBrcS_H40ZRm01RIaelC-wxTLQzCiD-VqLFGlB7kLXw>
    <xmx:JaH4amO9sUtogLsb29weYAMkVW-Ar8j4WpcXo0OZfSkMIym2iSeZ3A>
    <xmx:JaH4as3N9mg23iF1WTWgpPMNcHSLxWCtPL3sPsEU6swnyDMCYVB4h7cs>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 12:57:55 -0500 (EST)
Message-ID: <f6d30c90-05cd-48ad-a278-3277eaafd207@jaseg.de>
Date: Sat, 14 Nov 2026 18:57:52 +0100
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
Subject: Re: [PATCH v2] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 stable@vger.kernel.org, Saravana Kannan <saravanak@kernel.org>
References: <ivkwuomer5vsajf2lq6otpgxwqljkwooh3p7e5ne23j37pv22t@iluamo6gxmq3>
 <20260731131002.142671-1-linux@jaseg.de>
 <CAPx+jO8DKyuNMEKCHyKzw5DS62U2Xu6mcL3BtitRwrYP0gad0A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
In-Reply-To: <CAPx+jO8DKyuNMEKCHyKzw5DS62U2Xu6mcL3BtitRwrYP0gad0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/13/26 18:47, Ulf Hansson wrote:
> On Fri, Jul 31, 2026 at 3:10 PM Jan Sebastian Götte <linux@jaseg.de> wrote:
 >> [...]>> Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to 
the genpd provider bus")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
> 
> I decided to apply this patch as is, for fixes! Apologize for the delay!
> 
> Let's try to come back to this and see if there is a better long term
> solution, along the lines of what Saravana suggested.
Please feel free to CC me when you find the time to write a more long 
term fix, I'm happy to test over here.
