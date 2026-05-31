Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B43655C0
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224086; cv=none; b=dGE6udjhCfa7+r0IxXyJpG5/iH4W5EpHccvKPVLD8i4jwAuFGCNb7V8ra++fyT9G+v1VP+3/uXIPuZzI01Iysil9O+mNyUTQ4fcRjLZ72vrjmF/ZmPUqmTbymMxb7QYlrCVsboU2oXPDILlm8JtnN3ZrIumSxGFMJbGaVZQrMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224086; c=relaxed/simple;
	bh=PsDeahGJxYrq2YnGy5j/bxDm7MFVSIU9tZE5IjxQkKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDdIGKs+/RLBErXNFVEC9e35GkeLzJ9ikwBhqWlfwhQSdSmMz55CZsXbtm0zmKYVy037LHLiYPqwLc1uscLZDYyYqSaZjy7vaSzxgbtcxir42lhie+G+I8bczNX6Tx+zeuyzvp/iIvYeMzL+bLDZdwRPo/UOjN4Fq6iBMQcO0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=A+Th4hDI; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="A+Th4hDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1780224070; x=1780828870; i=wahrenst@gmx.net;
	bh=HIpvufQis3WMBz+6BYiN6qKRud7wcllSfCDwRfn/m9Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A+Th4hDIdBQ+DZaJWcejzlF9cguTSW86jnjkL0MBue032OWcaW0yMPAOS04IEUFc
	 s0hw0+/kQYEfLvxYGVfU7dzGN0ZLieHWxe3vbHpm2lZRgxbTuWttPvsUbodhLg5ko
	 39eCCkporizVJ/BYD0hHnGi4QcdDPW+r7T5iph4dbnc+4BpQ7Rw7+VWMfj2fRwYFu
	 rTTlXTUZR3tuGvnxIGVmMASyd4WxU4PGuOFKzWb9w4jnaP6RgD5uWXH7cKxd18OoG
	 cnnig22o9gTBP9c5o3OVZtYAT2qEL4fwlein9SwW6GOMN1EdO9MS8enOdI/2yMu5h
	 oJt7kpz3XjOd8fOWdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mxm3Q-1xDUOe1MdS-0107uw; Sun, 31
 May 2026 12:41:10 +0200
Message-ID: <deecc409-02c1-4393-bc06-1852fc06e4d1@gmx.net>
Date: Sun, 31 May 2026 12:41:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: Raise ASB poll timeout to
 100us
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Ulf Hansson <ulfh@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
References: <20260530204636.1115120-1-mcanal@igalia.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260530204636.1115120-1-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SkXGQKCt/zzEkZYlWKNn29YUoF+waE+0aNl+PVFQABDnbDd/1y6
 7tyhwd6Gijxmnjbh5VS2gnAwvh0bi8I+oQC7nBqjt8UcdNknllW7dSXlR2enni5VZO0qxL6
 L+cYngdi/E/WA8JOd/mCp6JWcI689fZS62o+LYkU0zVHWdwFe3PicYUBAqjwMC+rxY0yb1x
 T8azdX0ou6D3I1uZ5I7uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Oxg23FJ7+Lk=;/du8J8sW/EML61kzG5l3UtPjjGs
 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
 SEPjk4Dbmpm52pyRWk0kam41exs=

Hi Ma=C3=ADra,

Am 30.05.26 um 22:46 schrieb Ma=C3=ADra Canal:
> Commit 18605b1b936b ("pmdomain: bcm: bcm2835-power: Increase ASB control
> timeout") raised the ASB handshake polling budget from 1us to 5us.
> Surveying the pmdomain subsystem, 5us is still one of the smallest polli=
ng
> budgets by a wide margin. Comparable handshakes in other drivers use:
>
>    - 100us : starfive jh71xx-pmu, apple pmgr-pwrstate
>    - 1ms   : renesas rcar-sysc, rmobile-sysc (power-on)
>    - 10ms  : renesas rcar-gen4-sysc, sunxi sun55i-pck600
>    - 1s    : mediatek mtk-pm-domains, mtk-scpsys
>
> Raise the BCM2835 timeout to 100us, matching analogous drivers. 100us is
> still negligible relative to a power-domain transition and gives the V3D
> master ASB substantially more headroom to drain under heavy workloads,
> assuring us that the timeout is enough for any scenario.
tbh I'm not convinced by this explanation. Starting with a timeout=20
comparison across different pmdomain driver looks strange to me.

My expectation that the reason for such a patch is that there is some=20
kind of scenario to trigger unexpected timeouts.
If this is the case, please provide more information about the scenario=20
(specific platform, scenario, link to the bug report).

I'm not against the change in general, but please start your commit=20
message with the problem and not with the solution.

A related question, does it make sense to add an error message here for=20
the timeout case just like in the rest of the driver?

Best regards

>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
>   drivers/pmdomain/bcm/bcm2835-power.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm=
/bcm2835-power.c
> index b76d74e3849b..d507bb675e29 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct bcm2835_power =
*power, u32 reg, bool enable
>   	writel(PM_PASSWORD | val, base + reg);
>  =20
>   	if (readl_poll_timeout_atomic(base + reg, val,
> -				      !!(val & ASB_ACK) !=3D enable, 0, 5))
> +				      !!(val & ASB_ACK) !=3D enable, 0, 100))
>   		return -ETIMEDOUT;
>  =20
>   	return 0;

