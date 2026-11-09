Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.13.135.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208195;
	b=XFtWs8Ghks24H2DvV7Ls7ZzyQ3iuJfggt2XKLPCdg5QprhQrlGI5NyenxEFcy7D3E+iH
	 vOYG1drXjUOcFi+UUDKjbDoRJSJieYRAT5YKrPcYnVsECKMn5VG45Q4J14n0obKBznUs6
	 8abgjAphzH0US7HTprQdPuiiIJVSVyqoeucu4gHy7Y8a5u9ALRBPbRWOQ8K9sGglbIJhD
	 5Tbtq2b2snupOUjKiHdGYBoCFeadOELFqOoeOKtsgXDtFxQ8lmxNZuN4XnX+li0WGJ5cr
	 aRxs084IQibIBVJ+MQfUJcdOX4FaHI1q+/hZ+Ac/HoBtt3LfFcHSVVfdwsTlrCY8ckg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208195;
	h=DMARC-Filter:DKIM-Signature:X-KAS-Sym:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Bar;
	bh=WIcm00QviXN2rNTolIZmfmXUKosJ6HOgWPDQhqzg86w=;
	b=qi1vn5laRtDij2mBf2xbefVAeDF2NvsjtNrSbUGqkwXN4v8wbj7r5jKZmMC0WxHgE84x
	 ol2akxWDg6sWmU0bOdGny/XLtyvu+PVUgiHrPRy5WO5+Sw8wM4Y2CxW+6gOskwWcVDZfW
	 DJDQzpyKDUUBxjstVYG3blztv0IAeqJz38dMaeEXwghE30PunhKE2Z0W3s//XBrQntv0y
	 zAcQAY76vM6L0lI/brAwjFIijS8ziKgFBqQnBtIOrYvIE3F+VtmGXPWLHxVXix275nO0Z
	 Dp73xBgN8Si4BqSPSBnLJD5vhdFJBOIW77T8IZajwIjIQ1y2NrGNCUyrgk2b48wXqdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tsv-stahl-riesa.de;
	spf=pass smtp.mailfrom=tsv-stahl-riesa.de;
	dkim=pass header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=FEoM7VCN;
	arc=none smtp.remote-ip=85.13.135.14
Received: from dd13108.kasserver.com (dd13108.kasserver.com [85.13.135.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040CC606A323;
	Mon,  9 Nov 2026 07:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 040CC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=FEoM7VCN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsv-stahl-riesa.de;
	s=kas202608160020; t=1794208185;
	bh=WIcm00QviXN2rNTolIZmfmXUKosJ6HOgWPDQhqzg86w=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=FEoM7VCNH2YoqXlEnfoGBAY5Vi6OleT9YSEzr6w3tfQAA73irlffttHm0hmdcfYQW
	 Bkw4tcOUFy4oTMFpuWhZeJulh4NLfjd1Vp+XDt8MS/BOePPuoJLgyvDnigbTjQc9K7
	 rjo46IntC+1Nhz53Rh0BQl0Qku9FiM92j12erBCUuF13gPXDZoWuYwH/lXJvmRXdfv
	 BjVuuqXpDz9pkiIpzFYSP4uv48+w6RjAJ2a1RquCinkNZULAFGAFxHSoR/C6fkl/h+
	 MVUlx2iS6I+du4OCP962d8ScOxM198uachDVpoWRW4a1gzsa2eherofaqTLtgxzAqj
	 d4XUAAE+XHtPQ==
X-KAS-Sym: v3:f51bdf72230551df:lm+kJ516X/vXvgW5UsIIwQ+AHHFNVUKD+7Vv7dsrSsBco
	NsPVQ/9+7hwD7YbJbBgXB6kUTXlJPuG0llkl3AZcSV2LiA/TpbBhYO+hh7PGemKDSrtQ/DoeuvG
	/jq4ixEZ9qvRBxwige5OMr4HIAOC7YCdsL/oyAA4EaWOehSym3yButKt0e0HZpd+85IJs4nyGJO
	AHHMYqRlKYJaU6WgIZP7bl/9mKlzFDLOaTSSrSJ1EN2RcwM1IsmsW6YlTVa3apYoDSo5aAFB7dQ
	7hK9xfiJ5GzM1M6SzQf/OjBuaTzSOwUKTZ33HEZDYhfBFn/nZoaqa9MeEkZ9Xbi4++uMxfhg==:
	72YJeMoxJbw15IPXYrVE+Oc0B3tn6bjuWJZbggJMIEtGEzRDoYEQYtdzJSNFs5P85ThIkVqHbT1
	cIk13H3tFWTDnJs1Z0/x/ebcTYkrkbRKC8DXLJGIP9016KniDXUYS94rtFhPFTiyIMSbTqePwbf
	LEaKizW6e8Y7Fv98vxrlKe5R8PT82Z8A6Yg7seT1jgFlqb1cudYzTuDudwP/jurTfTc0gIJ7fby
	hEnsjn0lw092gj4kP8OxKS2Zu7IVcc8CnUESgYedfm/QJ4uJDUgBSpXvHZIjJH2aoaLTYgdWLsm
	IosQC329EbRfWag6BQJDhVPDwS0sBWBojAy8AA0ThbJcXNDXS7k3UJaCVWP+S1eRJv0mPER0I53
	JltrklaAl4TBSQPowVtd2u0s6pXZ1AIVRsmuFzLrNQ8Ui8v+4pEoVBsSZH838EDyJ0zVysvBlOw
	CN8iUDhuHOZrVNedF+2eEftSMOfNJpoEGZghDHI4bu8rkxzIH3xgRKKNUKG/nb8ltiJFLMV2TD0
	eIcH7595Y5fRYkkKWTQT9NsizUtF8KJOIjRyqS8aC3MROtDDFuG5cIYITFqi4oHS0q5bJi2+x2P
	vQ3OYQ==
Received: from [192.168.2.174] (dslb-188-098-199-015.188.098.pools.vodafone-ip.de [188.98.199.15])
	by dd13108.kasserver.com (Postfix) with ESMTPSA id 14006782709E;
	Mon,  9 Nov 2026 08:09:45 +0100 (CET)
Message-ID: <669e55df-e86c-45ac-a898-f28fec8b3e41@tsv-stahl-riesa.de>
Date: Mon, 9 Nov 2026 08:09:44 +0100
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
Subject: Re: [PATCH] power: supply: bq24190: Fix NTC status decoding for
 BQ24193
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Aaron Kling <webgeek1234@gmail.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261026-upstream-bq24190-ntc-v1-1-fdc12d795a99@tsv-stahl-riesa.de>
 <avEObsi3nkr_-kaf@venus>
Content-Language: en-US
From: Patrick Fischer <admin@tsv-stahl-riesa.de>
In-Reply-To: <avEObsi3nkr_-kaf@venus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: --

Hi Sebastian,

On Mon, Nov 09, 2026 at 01:08:13AM +0100, Sebastian Reichel wrote:
> Looks like bq24190_charger_get_ntc_status can just be updated to
> handle a single temperature sensor as warm/cool and dual-sensor as
> overheat/cold?

Thanks for looking at this. If I understand you correctly, codes 1-4
(one sensor out of range) would become warm/cool and codes 5/6 (both
sensors) cold/overheat, for all chips.

I don't think that is right for the BQ24190, BQ24192 and BQ24192I. Their
datasheet (SLUSAW5B) says for both TS pins "Charge suspends when either
TS pin is out of range", so a single hot or cold sensor stops charging
there. Reporting that as Warm or Cool would understate it.

The BQ24193 is different in that its TS1 and TS2 must be connected
together and its codes are a JEITA profile (SLUSBG7A): 010 is Warm and
011 is Cool, and charging continues in both states.

That is why I used the per-chip .get_ntc_status hook, like the BQ24296.
I can make it smaller, though, by handling only the two JEITA states and
falling back to the existing function for everything else:

static int bq24193_charger_get_ntc_status(u8 value)
{
	switch (value >> BQ24190_REG_F_NTC_FAULT_SHIFT & 0x7) {
	case 0x2: /* Warm */
		return POWER_SUPPLY_HEALTH_WARM;
	case 0x3: /* Cool */
		return POWER_SUPPLY_HEALTH_COOL;
	default:
		return bq24190_charger_get_ntc_status(value);
	}
}

Would that work for you, or did you have something else in mind? I'll
send a v2 once I know which way you prefer.

Greetings,

Patrick
