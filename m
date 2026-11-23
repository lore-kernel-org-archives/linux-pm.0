Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437293;
	b=NeaK3IMFGo9B6AOK9J5+eYXw3VGAjSZdEXb5AMBAXFV0P9XhsOt0z1lTpFPnHadiYwDx
	 fDGvbxoK1DtdSnvOxQpAFvvxpypJbRJNrRXOetrg5I3rSQdYioyy2C65R0/mJ9ZNIF/8r
	 SlxuC1wCSUpEySOy7aU2aoH2rxDPVgYOM/1eCQBad6+Caorsi3AXs3pgLWDJ6/9me2/48
	 UnbOC6CPDToeP72FTKtpaTrs/Y4nhQJ8DHsPeNI7V9BJ2GEiqV3MceNVqgkIcy+mz+LL5
	 vIYGKScaQFbhaYs4UhNXj+J3mR2JFZaUOwzglxaSb6QywnB5uFCYe3xilUVBWZSkyYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437293;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=eHnVdH3eygeNZ6mEwcCP89LSgWOPzbTMb7xVcTPFhqQ=;
	b=U+LoDWozvMksU84nwzSRX8IdF0b1G7chqtGbv19KiUDIDHmKL5oktyFQRlz3lViwK/CQ
	 EiJc6PpROWWZCYuIdeHA180s7JmELjYB2Ras1/uE/WKxnQoY2f13NImtowH2L9MXgjLRm
	 f/yVJ/uC+QMnVp1WYRsNGJNBfCoLNM+EqCRD2+QcORmGYff94Xfl6EsSxumCSP5QbFK58
	 oTN9T2s/vEsmeMZJNU9Iq1QvHlZJWvZ4+E9Irbyg+qj+NjN7OgKF45MahLwlJ6tdi6b+5
	 Sht1gtgqrn6l4L6InJqRoMS82DQEpujjT3MNphoXJ8DgzY4/IlncZjmTFnH6srbCtpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=glider.be;
	spf=pass smtp.mailfrom=glider.be;
	dkim=pass header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=lwhvrItP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UsLMaOp3;
	arc=none smtp.remote-ip=202.12.124.137
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65FB606A32A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 12:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A65FB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glider.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=lwhvrItP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UsLMaOp3
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id D4ED01302EE8
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 07:34:51 -0500 (EST)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Mon, 23 Nov 2026 07:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glider.be; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795437275;
	 x=1795440875; bh=eHnVdH3eygeNZ6mEwcCP89LSgWOPzbTMb7xVcTPFhqQ=; b=
	lwhvrItPrxrnWeg316nV1PuaExKq05uOnB7kdGOR+IJk3rFQ4890Jz9EcO31c0kk
	xI5+e5MQsZ0Yu/9Wf27fOSkUCHAHEv49K9IkC+q+zMAiV0fWxL6WVhEL0+7utY0A
	sMfoGyUVx5WNE7TkLtuFcn5bgseBGwR+2VyVL+Itg7Bp2cdvDppO16Gw3TVGIzFs
	+veTAsVcniGMCYUlt6/hAvIA3qTBC20vLfBumf1+HmZqvHv8q4hsNKIWQCGv9AIk
	kBIyqj9HN4qUmIGzSxUWBSlcFtdt4oVoz0eRwV++3xeZ2I5GDpbWpNk2sI5vSH5E
	XacBZeeCuSCzIGUDtDjXyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795437275; x=
	1795440875; bh=eHnVdH3eygeNZ6mEwcCP89LSgWOPzbTMb7xVcTPFhqQ=; b=U
	sLMaOp3ptN7qnKvIWkUvlnS7dH7+uzP+HriLKIrFXHLFQoGwOy+gn5VW7NtvjlTt
	ManvQiXA/yGJs2Qs6t1/vWVROdmRhLQH/8Hcwu1SoOc4SZMVpnelETNdusb/zknJ
	UmxWQ0dzev43r8pjIXIriUtoK8G+VORVCbl2FWAa9ww1T55Zk7Fli9ccMLHqkTRa
	728HmALwK06es2xy8VIwZ29dfV8WS8beUKPzAiEKfZ+k1pFpUdcWF5cXI8faDOsU
	AVE3P+q0ygfltJRFgOfUjOofusYqIx5b+2wM0O7GquksOL7nSHB2Odj/pNqvOcPx
	EDEeO1hAn3Zw6rwm8/1hA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=glider.be a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795437275; d=glider.be;
	mf=PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:KMQgMBjnIcxttTWbUKkk4LRsH1ieqlPOi0Sz4ygbozA6Jhp
	gcJrb2POMfrsMhBKkKWJIG+Feummu28g7QGM5/fTDsmRUpfwcTQIn1pV0UJwapsV
	oAcqF7vlbCg4QyVirkRe/eXW2BAJEqcYbzUwfp7IGB9wuhM/dkliecA7w3Vgkc4a
	4ENh+R7RFXWyMT8H3PTl7hpuGJ8uKtV2KfpNPt+gYyLKhy7OblTbvAj2xrxF+KYX
	hOFLQv/uSZ5KoLCtkv4YfaHCRbsYUjPBDr80p6EHvFjpToZeljaQJXGBVko1Uwir
	QzFmbUpHVtl9MiXXfG3+6EshMfUhhzaaHoWQIIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NqarG23xk+ubs76/imvVRMIVR9rWyW+HFno8706/BFM=:crBsktOEwz7H50H+P11uEpNa/OLN9cRsaNs9xh5MNQY=;
X-ME-Sender: <xms:0jIEa-kXHJSkHDBxBkbB-Rfk12hTluPPIO3BLiJ00t8HIPNy3Ml4xg>
    <xme:0jIEawpYzEGOcdmBH7VfOrQ3QrgvR7pCr3gof4I3Y8cveujyxtwEy4Wlp9OZfM0KZ
    6NIwSex1_RsXjNhe9UyR-zy65wJm5Tu98aBjnJFwfhWMy5aSsomJmxq>
X-ME-Proxy-Cause: dmFkZTGjXOFYrJRxiwHc7rFicL9MWrbJzVM+Gc43OT+4O8mbpHX/5MAATZsAInI6Irclg4
    HmBPr8P3wEx6H7B5dwsR/HHfQoqdBCUtEOiLxJS9mZIu4PwsE2PDUU94Q4jqfnzMI9Btwd
    XpAwuZscnIVSUJsF+0koA0iiwDsWZD37XBYDpPn7VmVqd2+XDkRmbJlf9eAMXdWpLtpQMN
    czFKZy8qBH04/Oxu9ZQMA8zOfPCNmVRws8jIRBNnncQG5Q6WPhVcUJAKcrqyeTM0Wsgfxf
    7khQAAS5dOfnNwzM5QvQ9pzjX/BkQ1CzMMp393inSIF78qd4yR0IFm8Ms0iqIjWovz6FpU
    CgFQgw/soK/tq/mFGhE7cmCgQ2BSc3IlcKqUnBArsu0BDneAWSEtDCvjKurDHAbPO6oPbX
    sF57QnbFAohTkunviWyVlbAtg2pDgFRklPonksWA69xQ0TXMBe/n4cgjmLBjnjnFOL+NIQ
    KG8IEHZU2UaWpcvWRx2fiUdHV9c6XRoVgAOrwaQm0/CLrqRT7skw2gfC9tF/v7PC1CmPph
    Hx52t6ORfO6Jkd49V45jcWX6CXK3RoCdKJg6vWEOHTfKxESaXeoFqhF0QwDn54eSftAZVO
    e2XmsNI60B6pmvsE0U09WBDT/LdtdFP602rgOxjdTpAl5xk+xpMyC10wzLkw
X-ME-Proxy: <xmx:1jIEa9MdAPtePcO_m0xHaaHu0JEHLytb4ihDc7EMzSSAh4JomFv1WQ>
    <xmx:1jIEaxKYf69HkxcKUSVCWteMnRpFcoVEdsxp4onPUsO6FVxf2CWTFQ>
    <xmx:1jIEa8vVRg3M5Q1pMJ_4h2N16qOm3qOZcdRAwjDOgv9xHzpZR0A39A>
    <xmx:1jIEazHtrOgobv7i74yPIQ2hjQZ8bg54nM33N94XEWR69sFzIEwHvg>
    <xmx:2zIEa8npJ8YnsLCDqc6cvQGTXzw3RisQ_vkaFmsAS7VIUCAHgwtMzrMj>
Feedback-ID: ia0f84a9e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 935AEF80098; Mon, 23 Nov 2026 07:34:26 -0500 (EST)
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
Date: Mon, 23 Nov 2026 13:34:06 +0100
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
Message-Id: <23ab561a-c5c5-41ff-a0f4-87a3f5ca2e49@app.fastmail.com>
In-Reply-To: <20261123113619.GG3010398@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <e01baebc546ed6f1b71a0487a59cda73239ea7f1.1795029012.git.geert+renesas@glider.be>
 <20261123113619.GG3010398@killaraus.ideasonboard.com>
Subject: Re: [PATCH v5 05/15] clk: renesas: r8a78000: Add SCMI remapping support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Laurent,

On Mon, Nov 23, 2026, at 12:36, Laurent Pinchart wrote:
> On Wed, Nov 18, 2026 at 08:44:53PM +0100, Geert Uytterhoeven wrote:
>> Extend the Clock Pulse Generator driver for R-Car X5H with SCMI support,
>> to remap DT clock IDs to abstractions (clocks) offered by the SCMI
>> firmware when running on a system with SCMI, and SCMI support is
>> enabled.  Take into account some peculiarities of the current SCMI
>> firmware implementations, and fall-back to fixed-rate clocks as
>> replacements for SCMI clocks that are not available.
>> Support for bus clocks used by serial, I2C, and SPI devices is included.
>> 
>> This lets us avoid putting SCMI IDs in DT, and allows us to use the same
>> hardware description in SoC DTS for systems with and without SCMI
>> firmware.
>> 
>> For now, it is assumed SCMI clock IDs are stable, and match SCP FW
>> SDKv4.31.0 and later.
>> 
>> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

>> --- a/drivers/clk/renesas/r8a78000-cpg.c
>> +++ b/drivers/clk/renesas/r8a78000-cpg.c

>> @@ -140,7 +182,35 @@ static struct clk_hw **get_hws(struct r8a78000_cpg_priv *priv)
>>  
>>  	for (unsigned int i = 0; i < map->size; i++) {
>>  		fw_id = map->entries[i].fw_id;
>> -		hws[i] = fixed_hws[fw_id];
>> +		if (fw_id >= FIXED_CLK_OFFSET) {
>> +			hws[i] = fixed_hws[fw_id - FIXED_CLK_OFFSET];
>> +			continue;
>> +		}
>> +
>> +		scmi_spec.np = scmi_clk_np;
>> +		scmi_spec.args_count = 1;
>> +		scmi_spec.args[0] = fw_id;
>> +
>> +		clk = of_clk_get_from_provider(&scmi_spec);
>> +		if (IS_ERR(clk))
>> +			return dev_err_cast_probe(dev, clk,
>> +				"Failed to get SCMI clock %u\n", fw_id);
>> +
>> +		hw = __clk_get_hw(clk);
>> +		clk_put(clk);
>
> Doesn't that leave the hw pointer possibly dangling, shouldn't you keep
> the reference to the clock ?

Only struct clk is reference-counted; struct clk_hw is not, and exists as
long as the clock provider hasn't unregistered it.

Gr{oetje,eeting}s,

                                                Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                                            -- Linus Torvalds
