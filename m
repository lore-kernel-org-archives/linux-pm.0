Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAE3BBFB4;
	Mon, 13 Jul 2026 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932237; cv=none; b=hOenjhkcSvSnDEJeGuLy5fflQp0/3ApDyScJoINcWRXIVPTyuaDF3w8r2HEsAi2NAdnEhHbn3Ygm5L//boCdz9IL35Lh4/N19W8eE8//R4S5qR6luD6qNfHTlS5fUUyAYFESaj9Eiw1upzd1ISJvZhITAULfie/VxsggvxXyCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932237; c=relaxed/simple;
	bh=NOvme/gxOhYOsUbQ8tXsECjcSWDvwomrNOupf0x3PkQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=PBJ8opcc+ZOAnDG982zAm4voy5H8VhUB85xsxNGg5Dr4we0lRdEwNmHcBJzp1heaDdy7XKdkGtsSMD2eiuvRQp6KRv6gD4uhrYefdxhDyuzJIgkpQjXy8/7U8nS5ENDiOPvixB32tz/hA7/sQNWCnL8XTeYVdp2t18ZL4IY/mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=njVQDLef; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="njVQDLef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1783932218;
	bh=sISlYduipxhIC/8+YFu6P/2Jp470bAA+Um+6jp0F3VM=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=njVQDLefy6wNiQ96jim1g2ea9TixvPsg9C09iSSPnEnbDp8h5+uBScsgBZ8e5jQTf
	 LhPCvOsxX55YZqmrBm115KAoMdOVPdq6l/r1CJu8vXnvzJ4QZrDl6mLTEF3ahAIt97
	 6ZTb6QRtGe8cVs6w6c4PrXElbczCsIZLTAbjpMU0=
X-QQ-mid: zesmtpsz8t1783932042t6c01fbcf
X-QQ-Originating-IP: Ui0SBaoneSNF3lggyErwuB3eBcdpG+Je/wL+ND5KZrM=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 16:40:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 444654458287415658
EX-QQ-RecipientCnt: 9
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 01:40:39 -0700
Message-Id: <DJXB4PDMYX0G.1TC9VBR96MHMA@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Pei Xiao" <xiaopei01@kylinos.cn>, <dlan@kernel.org>,
 <rafael@kernel.org>, <troy.mitchell@linux.spacemit.com>,
 <shuwei.wu@mailbox.org>, <linux-pm@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: spacemit: k1: disable hardware on driver
 remove
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <1db7d94eeaced9a92e3670d28e0c97c22f15f108.1783931396.git.xiaopei01@kylinos.cn>
In-Reply-To: <1db7d94eeaced9a92e3670d28e0c97c22f15f108.1783931396.git.xiaopei01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mom5ezI3X1cDfY0uIQhSG49fJZziPSxdeYY+c8xo4Y+Ss9GCOugQI8sz
	LrebgkzOvoNYMdpzT5D9UvRf7lzE81bUiXvEkYKdwHz006oKGMXceeU+/Ddxg/u9PiJeMCK
	UqOYiU0A2SYSxfJJ+1b6pxXp122okd9h/OmaGoOobO9GcD8KbQpz6ykrn20tsnLIiQ9Whxw
	I1qgwTqeiOzRmvqDtqszAagImWTTN2LwUIKnFCpmitPHJw4pHL25tw2hfUQ1Kyca9yG2eY9
	8Qr/FixoY74UHiQJvQKdIsWlCFr8IZD86/Eni+cCk3TqjAQFHeoL/HAKYGoB/MtH8gEVOWF
	wxnl/3jYUAVpxaxg5oyMV2BXNIkuDENk0Bv7Now82vqCyzwjUPeNvQ8VWadp4QB1D57bHxL
	tKhlbcHoCpEjj/lRpFqCSjPlSSwREsvMo++9RkRZuEZqXy2L/CFhOphIuTOkhvjI9NoM5aF
	6aIRgh2tQW1lo4mK9xH4vfYqVGo0cDfcKId+GK5H2+3Ix+orUnRIyRYxPYjmknlAMZA/s0u
	iG9l0aVyn+dQpQrmTlCX/w3Jfs8oquK3x2k9zM59bH6ZiDyxh/d26fh4JV79C0hRvEoHm5J
	ai0ch1fMfHP1NMnRTzAnmxAe12VWvq1RPy+cl9HIZqHqgMUAJpmnhZpJ/AfZHQlWhB4tI7Q
	Y2X8wxgVZ1s81YSN1liu65RmG5q7PjHPH/wDfXjNruIi88vy9mnYDplhC0WC4t9pYKPT4yh
	mv63qBoQMx793lWPXCJu9sCaOMVnxySRTu73vVs4ONflrm7gtLjFdgqzxC+gu2+RrtaL9tC
	bW2uMZ/gGwfbXwMhu9xO5HDcal6w62RBU1u51gql65WoU+SzIq2jVQTLtwIyiND7kIf9RTz
	AVC36xDb3k+4pGxe6Q/n/upaKgl3JA3kxJjUYccohKzqwga/Ic1xOoffIRhQ11u6TE/NTWs
	aSyIzhryH1H4jYGclPaflZriqtoldQoDNWL2ESD60IIFl9Ehr4LWOL3dHMNdEcLX2VHAB6e
	hgKlfZbK42A/Ugi4X+aYjLyEm3sEFsleWUScUyAzNw6ZWQV2zI
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

On Mon Jul 13, 2026 at 1:32 AM PDT, Pei Xiao wrote:
> The driver uses devm_request_threaded_irq() but never disables the
> hardware interrupt enable, sensor enable, or sensor power bits when
> the driver is unbound.
>
> Add a devm action that clears K1_TSENSOR_INT_EN_REG,
> K1_TSENSOR_EN_ALL, and K1_TSENSOR_PCTRL_ENABLE on remove, mirroring
> what k1_tsensor_init() sets up.
>
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/thermal/spacemit/k1_tsensor.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spac=
emit/k1_tsensor.c
> index 79222d233129..cf79dc7d403f 100644
> --- a/drivers/thermal/spacemit/k1_tsensor.c
> +++ b/drivers/thermal/spacemit/k1_tsensor.c
> @@ -199,6 +199,29 @@ static irqreturn_t k1_tsensor_irq_thread(int irq, vo=
id *data)
>  	return IRQ_HANDLED;
>  }
> =20
> +static void k1_tsensor_shutdown(struct k1_tsensor *ts)
> +{
> +	u32 val;
> +
> +	/* Disable all interrupts */
> +	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
> +
> +	/* Disable all sensor */
> +	val =3D readl(ts->base + K1_TSENSOR_EN_REG);
> +	val &=3D ~K1_TSENSOR_EN_ALL;
> +	writel(val, ts->base + K1_TSENSOR_EN_REG);
> +
> +	/* Power down the sensor module */
> +	val =3D readl(ts->base + K1_TSENSOR_PCTRL_REG);
> +	val &=3D ~K1_TSENSOR_PCTRL_ENABLE;
Why is only the ENABLE bit cleared here?
At init time the driver also sets:
    val |=3D K1_TSENSOR_PCTRL_RAW_SEL |
    K1_TSENSOR_PCTRL_TEMP_MODE |
    K1_TSENSOR_PCTRL_HW_AUTO_MODE |
    K1_TSENSOR_PCTRL_ENABLE;

Should the other bits be cleared in shutdown as well, or is clearing ENABLE
alone?

                            - Troy
