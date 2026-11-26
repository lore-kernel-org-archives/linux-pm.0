Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700196;
	b=NYU1ebwj/l0K3hcy81LTvSh8fAD/BHG4PcxS4g+IjSh1hhFW7zkgwyt6zYtJVKOCF3uO
	 FXFyOObmrzut15cz/54b5MmyeDxSQdI6Ow5GWYJ8IQ+e8Ly2Vg1/7kfuWAYCqcDpZ409i
	 dJIWmw46vAnb8NtcJDsrEF0aYm7+nFl1Ew7RInQXKymn5hw10PbI59yAVey0JZMKOYq16
	 RgijQmn6QCF8qq6QNY9M6kkGzR0jx+DM16yZ/HeX9TrdJgNtEKWO4ATT1TZGGdKtnfc+v
	 rVysax/hxgJCYMiE/i+yoTCcg/uHogefrXOyDn3TTgNcS2gNMtlJ6aXxOa8TTywekVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700196;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:From:To:
	 Subject:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=H7KUPIMQTQxlieuvSYIhpe8VSF9yrzbbI9C5IKtg8XE=;
	b=cn3VdAn1SAgvaJ14S1G0JsPenfgMxYWQPk+Cwndx7n3C+XFvYQoJCcZmLGSZnD1+kEdK
	 fg9w2NY/s1+k73C6rCrmKz8OBqBDxEMVM7Rx0545Te1a2/IhG3zHVNXUTSQPFDNYVR5Gq
	 8S+nz2mzcZVQdN6vPVWeIVSo+e74of1qCHyfyv4TghNAk8tyLEINblWKxXRH53l7em3RX
	 MipeW2AgwrRWgkIo+NAPhBV8zX8m+frfUmPFHkZVYwO4LmJXhSWFrWdIogg34Apv7IoYk
	 p+EP45w3CbBJxPsTWHJJdKOQFs4pI406TvZxJ08H3nhCYwpxbm/dd7c5sENWzFWcm1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="Z/fjWoYP";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86535606A31C;
	Thu, 26 Nov 2026 13:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86535606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Z/fjWoYP
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 83757C2B9CF;
	Thu, 26 Nov 2026 13:36:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 28BAF604ED;
	Thu, 26 Nov 2026 13:36:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2CF111E68014;
	Thu, 26 Nov 2026 14:36:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795700188; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H7KUPIMQTQxlieuvSYIhpe8VSF9yrzbbI9C5IKtg8XE=;
	b=Z/fjWoYP2LAGa6bLi7P4Z6A4oK6uLAlsKjy48jTevgNt+gcBdaiS/FKo+vhiGy+hKVEc7P
	hsoWpo8RFP+x+WsvWrwlEAcZmGZJ2Nu0iy3cdui/YjiibfHWSVQpVaws1OB/jgY/0OPcU6
	wm2/OajYv86qWJIRnX0A8+9k9ToLwDtnSUVXQBigX3zX/Jv6NmiRhvCPn1e0/5OJ1JmONI
	GEHs51lEiQJDhUA9RsvuY2YXr/OTwCdzIt3v3CUwy4SZ+BEGLiwGUOYHZBP8mTXDVcdiZT
	u8TpQSKG38lCq1gopF2sTB71m3HQFLu6lYP8Vqmzrn7Qqsf2NewQu6a/xRxpOg==
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 14:36:23 +0100
Message-Id: <DN56L7R8OJ70.3FZ8Y1LD57SO@bootlin.com>
Cc: "Ulf Hansson" <ulfh@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>,
 "Sebastian Reichel" <sebastian.reichel@collabora.com>, "Shawn Lin"
 <shawn.lin@rock-chips.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-pm@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ulf Hansson" <ulf.hansson@oss.qualcomm.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH] pmdomain: rockchip: fix warning when deferring probe
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261122-rockchip-pm-defer-v1-1-5b41635e3410@bootlin.com>
 <CAPx+jO8+WAK+W8BVOSJVHoLEvQUUr0-d7gEEK+yNwhJH5skYUw@mail.gmail.com>
In-Reply-To: <CAPx+jO8+WAK+W8BVOSJVHoLEvQUUr0-d7gEEK+yNwhJH5skYUw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ulf,

On Thu Nov 26, 2026 at 1:43 PM CET, Ulf Hansson wrote:
> On Sun, Nov 22, 2026 at 2:38=E2=80=AFPM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:

[...]

>> Fixes: d8b384777066 ("pmdomain: rockchip: fix clock leak on domain probe=
 failure")
>> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
>
> I have already queued a patch for this at my fixes branch:
> c671660ea0af pmdomain: rockchip: Only put clocks that have been
> successfully obtained
>
> If that isn't sufficient, please re-spin the $subject patch.

I've searched lore before posting my patch, but not well enough
apparently ;) Sorry for the noise then.

Alexis


>
> Kind regards
> Uffe
>
>> ---
>>  drivers/pmdomain/rockchip/pm-domains.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/r=
ockchip/pm-domains.c
>> index e193f978d5f3..adc3bebcd928 100644
>> --- a/drivers/pmdomain/rockchip/pm-domains.c
>> +++ b/drivers/pmdomain/rockchip/pm-domains.c
>> @@ -854,6 +854,7 @@ static int rockchip_pm_add_one_domain(struct rockchi=
p_pmu *pmu,
>>                         dev_err(pmu->dev,
>>                                 "%pOFn: failed to get clk at index %d: %=
d\n",
>>                                 node, i, error);
>> +                       pd->num_clks =3D i;
>>                         goto err_put_clocks;
>>                 }
>>         }
>>
>> ---
>> base-commit: 988117cc1bb17338c586a4e21ade88b5397eac33
>> change-id: 20261122-rockchip-pm-defer-adb33313f110
>>
>> Best regards,
>> --
>> Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
>>





--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

