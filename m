Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813563;
	b=ImHXBB9S9UEVmw9LWrjP1voeUNZ0n9O9OxutyEMIpAyf8iKnv+J1qigG9l6mt0HML+dz
	 D+D9L+xXFnBMbDRlsWWEcTkQv54ogEwvbJv3qxks8yWiCxghulPwwCLgUFslHlXDiudih
	 3u9BguGNqvk5pQlAs4poYyx4I+SYLOKxETHtQ6znXj7fA1JdhjDBMRj3GrrR3h79gPjv1
	 9l+IDfEWw2sYvAeH8Ue2zJxAqtJhh3L3iPinLL8qthg/J1zHdJLtHJUH0frNuspOuDHsO
	 7wKp2MCIl/v/vkDtpLvXBKTLf3VIuOihIBuFUkKKbcWmtA+Y4nGWfSuz4ktJPifJb8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813563;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Q0TFgv26jI4kGOfBKYI66cOd8gITLH4wiXMswdZiu18=;
	b=CaLiNcixVdc60icwdr5TAwAfh0JVWIhOifHACSbh78fIRH3tRFIHYZ2nIQqo7bsVvkhz
	 M1AZM/U75BB1NB8rdyO03a0JhfZsaIER7YjX4VVSNK3p9bqRmZK4ZmE0G0GKuULCs5yW3
	 6XDJ41wtMZ1XdfhutLV4vObhozA3x5QAi5W71F6LFt2IJ9xp7Qn6RNmgltjSWGvIeFP3C
	 TKolEgRpgm349qO7mPLTuyK2lZCksBQGrLi4DLXytBdI0MZqiOr6V98J9I3R20viXM+Lv
	 hJp/RDlYdwlN7YzA5DsExeJu478tqYoDxWQibXJWIuJFjr3nrp0RdE3HuZV+PH5gDuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=hJx7+72D;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XZGyKgtp;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87231606A323
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 07:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87231606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=hJx7+72D;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XZGyKgtp
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D2D777A0166
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 02:19:22 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 16 Nov 2026 02:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794813557;
	 x=1794899957; bh=Q0TFgv26jI4kGOfBKYI66cOd8gITLH4wiXMswdZiu18=; b=
	hJx7+72D2Zf0H2JFyTbqPHWwB9Frwq6YlREIej4YNKsfapqR3Tc10Pq2QDT/+OLC
	2uaqQvD/nLfQb0tmwoBHNvXDMGSAHzKRis075bn5b94T1G1/JTLUHqFGCQcNkNWb
	kw7Js7YiFvOuygIzeWzYwHgcr9g9Pbpb0FBUgnzEmIBCyeixtAi/2/dS+BXcTzaO
	ZsvXXFAVeLPVYw6oNKe5gNe6EqBqrM94rAwNnPt+ORyJrqtULEqZCa3wi9efbtBp
	NFWbo3RxLCwMLczQAh34OENmhCgGOjdeH/I08JMz7HKyyqnZ3uI+gZo+Hb37r+qz
	Rvvi90ZLk1jpNbhP2VNWuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794813557; x=
	1794899957; bh=Q0TFgv26jI4kGOfBKYI66cOd8gITLH4wiXMswdZiu18=; b=X
	ZGyKgtpwPfhn9+A4AZcIo7i4C75y4GIqQPGSQtzNHNs0k+GH+DBdCwFRU06vnJsc
	+08RafhxwU+l5m39nBHJ/V8nTDkt4iegcDEBAX8QS1ON+ukudNdlaLIrDNa/jTZN
	4QWvS0TVXTUdcTsjtpk4sjOWA5XfDsDPANpMxKzyTLZXQUM6Pg92hlYuervGVoNg
	eWuALRb3riq8FKHKL32fjye1TW9Hrchll4+xx+0Tgrj59Mzz6FSTfMUGFD8k/s2m
	OcJ7b3YW9pK4laWUgQefp+zb9XEVEFjn0PzCpH5BI2VhWxzG30qxOgpMgADHEYi6
	EX+ebWn51RnPOijWRAC+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794813557; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:JrKr37qmU7Mxaae9rYqE323gRsOE8EDVJIbS9LUSjBC6fRM
	K/4JB2Dmd1T5xbT9ZDeSZlPJAdXRvpWYnSgksCP+S2yQ5bu+VB3r4y0skh5yCaaM
	LKGxdV5sM0JbdFR9LVr1Vy0WPzauzDt4cxGGmiWIQMDqs7dvio7kelv/KKOMWyXy
	AI3UFeY0sMgmihaMbvlFlD3gAayiJJ7X+TlMWEWAZJLahClSMdWt6Hb8gp81cfBL
	krEASSfaHQdFYzAJZph2ivoQkxbhuJ0S+kGasxAWUeshjR9TAXmkhN2wDTytkb5e
	saphb9yUlhetufUk1QR82MlIB7Ec1f2KH/CPhWA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LM1Sb1tl1qynh80rn5D3cTs0lm/3agMt1ONentbmoa0=:Q0TFgv26jI4kGOfBKYI66cOd8gITLH4wiXMswdZiu18=;
X-ME-Sender: <xms:ca76anB4AUw1DqI-WHDD8ksYHlu8PP2Ly63YtDi6aNsL4g_WMpsnTQ>
    <xme:ca76aoW7o7FUUtwVrarqlAjdlVAUvQW00EpoAwIsCwCdK7JcpBwsWhcIQ2TTONHOO
    pKgvBnxign5OmmnY-cE5eB4OIoE8A5N_WL2jBTJCM_9hXrKMnBPssw>
X-ME-Proxy-Cause: dmFkZTF123o0lc1ZNONC6IHTRcYRdmv5B6bDrX1s571Mq6u7KreO6C3RvwaRcwjUgMnto7
    C0bP7r0rrVpIOYSuaPpEud91ELs3Ye1XlrmhJ6U74AeVmo3/hSdnUprF1ab4qsKYNeDq+o
    wu6Q5zGahlNpkbuyh2WMUkxbaGZ2r5UC5nOQAB82UprzUyo/TAF+o1H3MI9FUjy3hIYsmJ
    6ihpOrK2uS3AjVzXT6KBHyzSMPpCQotKSEo5FmZ3wOpVTeZtWhcAmxRr52XZAKQzF0QGVv
    kcWd3ti6HL2z4Rej96Om9z+PQEw74V97Od+rNW7uwbOPYGwOzDlGcDNaCdW9ACkbHBuic6
    FbOUaRiR4n3529j3UFaQB4M5JUDn9VvwAuai1gL2DnkwqX8T6YhKvAdmL96nvS6oUE+LS/
    bQggH9ePMCJddMsPYuQQ7cHQgde7VdVX8vegD1SNuRWP2NWf258wdb++v856dUkHK70QS+
    aqHeiKHK3u0Hg7PIYQBePQnejqjByPwjkNReVqVt8eaIGN4D6xgSeJpKpjrpe9JP/0ka52
    XTXOinJAGuzBYLM+gwhQJ2n7wGaGbsSoDVnD/CV6DBjX0rZ/d5HjiYQ1Le7Se8t+enk7WD
    gKh4ooagE0M22L9bEcaIN+Ws8kiNpgyomcFBbwwrDdbnBzfObUWg3V/Qw22Q
X-ME-Proxy: <xmx:c676ahyjZlVApz-K4fJ9vDRxXa2dM3Z92nwPSxbJc2Bq5jVzymLApw>
    <xmx:c676aj17wmuvv9nKuAEfAyxgpFWLHzG4ZLlp7RdCU2jvIUHlFItnLw>
    <xmx:c676au8b4aWGY7hE7U5Wg11YKsLCBj-yRg6Qs29sbtW8qngdd_l9eA>
    <xmx:c676ajpU0u-oxkDPovkmYyAHj2eprwvOmGuYZs15L6BPc2VGT-W_9A>
    <xmx:da76avR1A4_tbvlN4y4MgmTxZTF4WWKRvmW5GxwE98gEBnstDnE96w6z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B774C32A0099; Mon, 16 Nov 2026 02:19:13 -0500 (EST)
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
X-ThreadId: AIwPeY0WxeBs
Date: Mon, 16 Nov 2026 08:18:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linusw@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Ulf Hansson" <ulfh@kernel.org>, "Frank Li" <Frank.Li@nxp.com>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-Id: <e16f2781-af6e-46df-82ea-c584a8d9777a@app.fastmail.com>
In-Reply-To: <20261116-ux500-sram-runtime-pm-v1-1-c554831d6b12@kernel.org>
References: <20261116-ux500-sram-runtime-pm-v1-1-c554831d6b12@kernel.org>
Subject: Re: [PATCH] misc: sram: Enable runtime PM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 16, 2026, at 00:02, Linus Walleij wrote:
> Enable runtime PM for generic SRAM devices after probe has initialized
> the SRAM mappings and partitions.
>
> This lets SRAM devices with attached power domains be managed through
> runtime PM references from their consumers.
>
> Keep sysfs-exported SRAM and SRAM requiring platform initialization
> powered while the driver is bound. This preserves exported contents
> and avoids unpowered sysfs accesses or an unsupported resume sequence.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
