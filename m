Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439002;
	b=IwcElHc87moz+wlCFUu6MWxrEcrQNJpD2TUhdHMGBBPC3l14J97yi+b0mmK4tD2iMNQC
	 WDO/n8YLk1xWwoFdT/iIhQYlWn3apzivWEXw2cP7b+EDJ6+oAsrF9OcQjbk/W/wDOCTid
	 O1MsaFVqCY+25KuX9sgP8UrEtpr7uc5jqbNWFH70ugsxlhzIzssm5djMf6ETKrvGbiuo6
	 vDSiYYg0fLfuzs+NTVNSl0oHC+geSW896FV/xay4BMTFswN5REOROtoiqNBSTZbw7JABR
	 Tq41mdEdecIoAcnyDJgygGoQQqdqnGpGgOMuumIYICMkoshjY13A0Zxm7MsEgMBbGRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439002;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=X9AN5OVfTd15TEiHpz1sYzAM+wupJkMExyLyKUO7vJE=;
	b=ZskuUD8pAXgnx+RWdDmkW2e4fwDi2ILiyvSvfiBrYqBE3jKrJKHzVVfXwOjm4ZsH7Tmm
	 1QBMt9b5WAFANtA8zBdJ3cRh65MeM4nk644HUPpjokTj7C7mYJVQvPgI0ORPa1K3fEYZy
	 jG5RN81+eHLL6CM/kwsHc5n7972/ZfzslpwZcN8IZ/SlNu9ekchKuI3NIJeK9casnO0az
	 85yNEl8qcdYy1Awqb3R+27L3OEDq/DvBv8MHGGpY10/NwGl8Tw/KJ45kDeeJ42LwnP7Ze
	 QqQcXYzGP5tjtaVNSb+s2nVdRQ/URwZr/ikm7/X710vbRspFA9Yb2XmR3BZoM3p8J/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=glider.be;
	spf=pass smtp.mailfrom=glider.be;
	dkim=pass header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=KmNmIqhB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tpGcuN+e;
	arc=none smtp.remote-ip=202.12.124.137
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C3606A32D
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F9C3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glider.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=KmNmIqhB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tpGcuN+e
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id DE6B01302A9A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 08:03:20 -0500 (EST)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Mon, 23 Nov 2026 08:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glider.be; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795438984;
	 x=1795442584; bh=X9AN5OVfTd15TEiHpz1sYzAM+wupJkMExyLyKUO7vJE=; b=
	KmNmIqhBfUoWarllG1GjO6lKllwVP9vC5nTZjd/gToVFlseykhjdTlw67WYaqU0e
	LYbqVuqJZX0XrkPOe12LROiPx3GhTI4UYK8kH7iShFXvE22ccD8cG4M2pah0pjch
	7JFBcey9HWpMHYnxGGosKLhns95OnLLt9/ohNI2fKnHM5pURSmXZvW87iVMaBBao
	Ifed5nU0U0IrYotlKtgAHTCzMK8ZHe5QT652PZSSTW5VR9SOTDuCouq3014fHSqE
	YOVgP8sO+lh0/+giGxQHLlt/EjSM9+ocy5/tfl7cG6DTGlLIrAlFGNwWt9SphmHw
	MZXIqPhGuawuQ1m6/Ox0jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795438984; x=
	1795442584; bh=X9AN5OVfTd15TEiHpz1sYzAM+wupJkMExyLyKUO7vJE=; b=t
	pGcuN+eRVrer9DpT0Kjc/FeF8x78fbIM7z1KLK/L+wYVVUzQ/UW45+oqNC7JJa3t
	wrgaX78k7BUypEziibxiFmxFGJy6hDG2VVAQoNbhrheJhgCzgxCDcmbTClbWIgeH
	FH/PLUsvGLskTVVZBPphEIZO/VzRaNCDo0SHlv6ZspJbhqSxbneiAIv321Wtff5c
	mRFH0flLIlqXeHhN3OHIapXwTFSNyytfJUAQfVkPBk1Sqvn+isqSAJIKtLaFp3Hu
	nD+Try2CsDjNxYT0oZcFrTFAFYavtS0Tjrl6TSZ5gmcbf1ALqe5RavVA6eG3aABz
	A35OoKmMgZ3cxo5x23/Ng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=glider.be a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795438984; d=glider.be;
	mf=PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:bbQL/V+xF568rl2aYiJeaJSZVY8afnEWPwgLtMSLJDa8NGg
	ixcWDkBRyDLKBgmm2JHjZ8+I5R2kRuPH03ftiPxdqFbRk1JD8R7V7WWbvWmYmtay
	sGDJx4Oawr+D+3NfRXPRWJWMF/lb8hDAvszAnOrhqtOPENxqXB0ka6bwnfH/CWjc
	QlGyzUTEwHztC691Yx3HCtvSCyjsstXPG7vfSCQhUpD/E1VVXzhmf7rCap6mH1+H
	sJwZwveHqAZ++3iK91i18TuLvh3AlOeOJu3rBuPpXM3QW1Mj+4shjro/UmyxzZe2
	hiHhSKXeZ3y3VGqOrSmq1lFzFBCREbFytD4IGmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0YCg75p+MOblRwKwnlPT7R+r27/Nu0Q0f3SIIXJrPoU=:B09fes5LGgQC5htT3NtSEhy6JGXSYH/VGWW6BpL/Y1A=;
X-ME-Sender: <xms:gDkEa4VDQCFO4pjPABBg4wEOMrNozKaTd6cyTtpY9YJdNxOYI7IZ-Q>
    <xme:gDkEa3YRMVUKDUbpBSC7rd8qL8W33EiohAlScaCBGcFUBNhHguFB6MrTJl-AtG0Pr
    o8KeIgu-Hp69IIZdHx9nGwvBT48LjlNUpQjM5F8ZxFbg1lSu7iGfK4g>
X-ME-Proxy-Cause: dmFkZTFfp6oa0yJkYR9c2DqsrdzraZ9xSBuUCXNUZxpVR/nSg/eguKNOGwdFxjoPGLQv4K
    DDIEPiS/sHS22D2pjiX/3ZqizsPUelqNF0Rx6hCDB52+C3kUyeBn/HxxwDhHo4Y3Uf2APj
    U+sVegWnkTZ/zUEXVcUwxZNn6lOggYXLZ5yOzL/pyU5KgLyPmJdUKoSNYrROKJA6Z+mOWZ
    xmVikDYGpHh1V6ANUjUhIFmx4jUyjC20kImuOqX0fUPYFw2UMMQPpqpXR5MyvQPrCP3o8C
    wL8eM7lJYvO7NupF38Hbz7Byd1fhQd8sbQTG630RZMWRuzF+b6YH6Cm1LPtsepWGKnWusP
    8OBrj0nqvNVsCrFQhRG/PEGcKvFqjZa1ovoeZ9pTbnyMscNJl56onWk+Dil0gZ10GaDeaj
    5xp0VGCMlAjzEYy4aAd3LtXUBMhRy7IKqFMcQI3xSkkITol0+INexCTqnQMBmAJxyQG9qa
    yf5Okp3LwX59hSzZda/4SgmxYAY/to474RfcdEV7xW0LfgPg4RB5umANSg7M3i9j7hAd1Q
    UFBng6tPXoICTMzWw/9G2mMqpAgyeDqAoHtczVpi2LYVoUhBoKtCIbnLphdNmRuNPdE+g4
    3PsTU6jfEDGgt9bQKtpY4GtcdcxP2IZFW7t9WMGaqaUefDPuKp+E9mBFMfBw
X-ME-Proxy: <xmx:hDkEay_M3Tq62sjYkuK6t8x1YZXUdOXLf3yFn6xpyINHJuWpKlGYLg>
    <xmx:hDkEaz59WZDzuRKHztL33T1pBK2xLtAxbppUWlUWFPv0t3HuZeZlrA>
    <xmx:hDkEa4fxgvrQn5vFaRmeSgEjZpTSVFFmPPUsm8HuNc-NCLAMXZnmDg>
    <xmx:hDkEaz2kf4VDKKLldz4MZsa6_fn0xk4NoSzZN_TXgMyzN6Jk7USrgg>
    <xmx:iDkEaxUiwVPn4k97WPDh14OtFo5puwlqndpi11SGAKmXQ-dAOsc5o4sc>
Feedback-ID: ia0f84a9e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 130E9F8009D; Mon, 23 Nov 2026 08:02:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A9C68vVDcqlZ
Date: Mon, 23 Nov 2026 14:02:35 +0100
From: "Geert Uytterhoeven" <geert+renesas@glider.be>
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
Cc: "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>,
 "Brian Masney" <bmasney+clk@redhat.com>,
 "Jerome Brunet" <jbrunet+clk@baylibre.com>, "Ulf Hansson" <ulfh@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>,
 "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>,
 "Kevin Hilman" <khilman@baylibre.com>, "Vinod Koul" <vkoul@kernel.org>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
 "Paul Elder" <paul.elder+renesas@ideasonboard.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Cristian Marussi" <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Message-Id: <066fcf7c-e1f6-4186-9874-622dbce18f92@app.fastmail.com>
In-Reply-To: <20261123125410.GK3010398@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <e01baebc546ed6f1b71a0487a59cda73239ea7f1.1795029012.git.geert+renesas@glider.be>
 <20261123113619.GG3010398@killaraus.ideasonboard.com>
 <23ab561a-c5c5-41ff-a0f4-87a3f5ca2e49@app.fastmail.com>
 <20261123125410.GK3010398@killaraus.ideasonboard.com>
Subject: Re: [PATCH v5 05/15] clk: renesas: r8a78000: Add SCMI remapping support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Laurent,

On Mon, Nov 23, 2026, at 13:54, Laurent Pinchart wrote:
> On Mon, Nov 23, 2026 at 01:34:06PM +0100, Geert Uytterhoeven wrote:
>> On Mon, Nov 23, 2026, at 12:36, Laurent Pinchart wrote:
>> > On Wed, Nov 18, 2026 at 08:44:53PM +0100, Geert Uytterhoeven wrote:
>> >> Extend the Clock Pulse Generator driver for R-Car X5H with SCMI support,
>> >> to remap DT clock IDs to abstractions (clocks) offered by the SCMI
>> >> firmware when running on a system with SCMI, and SCMI support is
>> >> enabled.  Take into account some peculiarities of the current SCMI
>> >> firmware implementations, and fall-back to fixed-rate clocks as
>> >> replacements for SCMI clocks that are not available.
>> >> Support for bus clocks used by serial, I2C, and SPI devices is included.
>> >> 
>> >> This lets us avoid putting SCMI IDs in DT, and allows us to use the same
>> >> hardware description in SoC DTS for systems with and without SCMI
>> >> firmware.
>> >> 
>> >> For now, it is assumed SCMI clock IDs are stable, and match SCP FW
>> >> SDKv4.31.0 and later.
>> >> 
>> >> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> 
>> >> --- a/drivers/clk/renesas/r8a78000-cpg.c
>> >> +++ b/drivers/clk/renesas/r8a78000-cpg.c
>> 
>> >> @@ -140,7 +182,35 @@ static struct clk_hw **get_hws(struct r8a78000_cpg_priv *priv)
>> >>  
>> >>  	for (unsigned int i = 0; i < map->size; i++) {
>> >>  		fw_id = map->entries[i].fw_id;
>> >> -		hws[i] = fixed_hws[fw_id];
>> >> +		if (fw_id >= FIXED_CLK_OFFSET) {
>> >> +			hws[i] = fixed_hws[fw_id - FIXED_CLK_OFFSET];
>> >> +			continue;
>> >> +		}
>> >> +
>> >> +		scmi_spec.np = scmi_clk_np;
>> >> +		scmi_spec.args_count = 1;
>> >> +		scmi_spec.args[0] = fw_id;
>> >> +
>> >> +		clk = of_clk_get_from_provider(&scmi_spec);
>> >> +		if (IS_ERR(clk))
>> >> +			return dev_err_cast_probe(dev, clk,
>> >> +				"Failed to get SCMI clock %u\n", fw_id);
>> >> +
>> >> +		hw = __clk_get_hw(clk);
>> >> +		clk_put(clk);
>> >
>> > Doesn't that leave the hw pointer possibly dangling, shouldn't you keep
>> > the reference to the clock ?
>> 
>> Only struct clk is reference-counted; struct clk_hw is not, and exists as
>> long as the clock provider hasn't unregistered it.
>
> That's what I meant, what prevents clk_hw from being destroyed while you
> still hold a pointer ?

If the SCMI clock provider goes away, we're indeed dead...

Note that __clk_get_hw() + clk_put() is a common pattern to avoid
leaking the struct clk reference, and fixes were CCed to stable.

"git grep -A1 __clk_get_hw | grep clk_put"

Gr{oetje,eeting}s,

                                                Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                                            -- Linus Torvalds
