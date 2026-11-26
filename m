Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700239;
	b=D7cVfgLgxbQzmJgyukFwepVTLW4OpKGBL+s8K66AGrkKkHJTkytUnCECyPAk5CS3RuE7
	 sR7N6xX5blFkRFg+4t/NeCsloRrrWnTkxwD8+SUbpf8eNME9htwfnX9dENRTwQZ825e8b
	 dD0XpXc/P6rR45XvvXJfdkXvrtZw5OWDjLRxK/ar6NIbTUzh0WJFm2y0kPbvdHdgwguy4
	 UZUBiMDoI2LDvuDqkNiwsdA16cUA7DlEIIczH2Z/dBVgVkIgw1ILuolLBYxtRdC+kdwjR
	 iL/sRPm7Q6mqClLIlqi+55lZjLek5euQo821+pWCkJ2cSohPxPX8whb2RfH8mCqBtWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700239;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=JMugssCcily/7wa694wDfnnBgfL202tVpzluRelC+Xs=;
	b=A21WHVwRGQXnD++XjCh7kXezHl0m9zoSo4imG+Y7IL5DhbvkbBYQt4moym5BFWhqeQQc
	 XSSk96a7dajqtdMizJKHeNa0+/nKWpyDwj3QgkPKYY+yEQPltrJjVWuVopT08hevxA98Q
	 H104V1vlHRlWMf38dTpV0bj8HMfmyknVgORpulk5RqQVcRkj5HNU9uI456x5cC57jPUl0
	 zV76jmw59xNov0A4LdvpcTcgZz/sgWrFLHngBzEB9Qo0qxXqH63Ixx8d7HzDSZSmtUZvP
	 vtUMLgd+nm9Ltas/pvB7VUYAk6kFgG6tpqsKa/iVd9cNWDRXic4bFqTwTxLORNP3lzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=glider.be;
	spf=pass smtp.mailfrom=glider.be;
	dkim=pass header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=Ru7CDrNI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=thUwDvQa;
	arc=none smtp.remote-ip=103.168.172.138
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B89606A32D
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87B89606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glider.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=Ru7CDrNI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=thUwDvQa
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.phl.internal (Postfix) with ESMTP id 881811380719
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 08:37:17 -0500 (EST)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Thu, 26 Nov 2026 08:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glider.be; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795700235;
	 x=1795703835; bh=JMugssCcily/7wa694wDfnnBgfL202tVpzluRelC+Xs=; b=
	Ru7CDrNIMYLGbjqcXniwkQQZGEz1z+hYmiW3IV6ICK6gOXNbKKftIV9c9RRDu30a
	hnlumkMH61KfllQOwIiiMmnhfNqG+HzMu/3yQc5fcRtk4IJNUuDUy5bYqpDxftan
	2GUJFVZxsFwRSIpDc8+m3ruJ5fb4S5nCTt5R65zJP0W2niJnpPTnMubcfu/g44M7
	Tz/qJvOvt7aY32RJq3H+4k9ESf+oXgZPo5ioRKStDaO7VZIkVfuuEBj/2C0mt27g
	sxhVN+WGWxqK4UD6+rYgUgclBRwq9h53xvmDfIAsbGBIldF5o9RLrzyIQCPIZEGJ
	l8yixWPJkC4pLeOV5W23+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795700235; x=
	1795703835; bh=JMugssCcily/7wa694wDfnnBgfL202tVpzluRelC+Xs=; b=t
	hUwDvQa4HoU2mjaj8GcCvlOHkRd7eAPlbjWf9tRSGVLjqq7tMxaVvsOaqokvJgIr
	+kyA8izVqh8oJyCmHYFsjLtV6a7FTmdObSl5LyBHbes0tGHoVW0kyaPQ0TiRYMJb
	gM8Taa0ixyxnxo1ToYHRaJ/CpuxcqFrBGjKwyovnDApw+OIomHJhRqPjEmyiVTg9
	cKlCgwVLu0OetojImSqScS53j27SKJ6YXedWIIp5HVRb7cuBsSrs692LfmYa+cxX
	/sEeeT9cwZunT9x1qmsEVnZ+hLDNJXg2dOzpFQHjuwuig2wQxMzijUCM743Xi7hx
	Qf9N6ASOGei5VXtWDfz9w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=glider.be a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795700235; d=glider.be;
	mf=PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:GLF0SGWLPagrpWGS+JK5+e7AV6cn2hIXUX8yw1Ph2g2UDKG
	P/7z5mJnlZZALjKDuDZN3vmjanA+vT86Nd04IM8KxJn0N+Rr9zWOwcldx7zneUob
	734IPTqY4Z2q7u/jkLAfu5RFJTireMkwNdanxSwpnp/yz3eayuuHfnp67CcaDxTK
	hrGKSHZvvxwCm/Xg7OxduOleafrmkWHhmDcFief0IeVrY8EKn5SppuX9wtuCOt44
	/Kgjh2qPWmBxXBuW3QQlV/4LOe/Q7TIP4IR4la5hqz58BH77EgsG5Ajzti2r4gVa
	fQTj7gxxMNyJzK8wLGPhx0vz7JdBJ9vV3eBl1yw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:42cS/u5GRwGS1MIqUEs68Rnpw8J8OQUCyWSrsVRG6tA=:Tv/37dhwHGiEPheMbeF/i/uv3mWlE33EsHblwdW4/rI=;
X-ME-Sender: <xms:CDYIa4nF98PxlGb14V6pqX4qtwGMSMfsRo-J4IeoWFKScXJYm8yUZg>
    <xme:CDYIayoF089wjlb9VIu-eVWOCSw1GnRHgglE-o5Ez9dUZgm-UjtQshB8LWhTUD0R5
    fIa9BJAdxoyHqln6xRYDMSqT_Md-hWINhkBxKw3COLb4yPBogNpVR91>
X-ME-Proxy-Cause: dmFkZTErsaaucJjYq/x+6V2mCCXBrJA3xek8KYWqXgKZNN9IFx6iUHi2/PpW1dzrLefW6Q
    GLHalkwlOBSs/MsCjgh1wT+SNniTnkE/oU+REiRyOwTCL/ugTHXDip+KVAvegPcl8V5QAf
    UTWH5/GWxy3iNfpZ7xE8DBd2e/SAAl0VMEN7VlARs78KtmMZDeXwEfIbm7zuPByl0tZQp3
    LfrkfplXFbAN0y9sryCubVqu9yUdw4wwe4sUrHcep0ykM8fRn1YjayJmFNWJcm60e4hbX0
    isuE8t6Vxqu67mDR4fH67HzmJfiKRMTbBYjZFhhcutPHbQhMrP89Kn78qQ/tqh7YgNttsT
    5Vfg4/jlpV+7+m5rJKJLERcY92vxQBDS8d/1oY/LixBfKEtsiJhAt3RonCo5g3zIR7nSkL
    sqQY6WnOUNA+PTPtS/P3l1ktRe88wWSj0OTLFjB8pzOWfm4l9swQb/Ok88bgvFCMbE+51I
    2Ch15Erkjr03P3bOFUBrg83QYFgk9MHKU/MONMTKc1t3o30N5WxoVQ3C1ZmuvplmAzA5Jr
    H9xTqM/HutCAXLwbckISFgxYgu4+k/QvlN/a4Y/S5BDP4lgtu5TLlqleRNhzJ78GOZXxV5
    PQ5Hnbc8UHLH3pXp5V02rW4O4uHR3cf1ljOH6/Wv/UYi58X7fAq/A6OSoP8Q
X-ME-Proxy: <xmx:CjYIa0IAbLSn7U_Nu-wkcANmrlIicuUH5B_4PRBMJkpGnaGAtiRAdA>
    <xmx:CjYIa2Zs3VEdRRNcVYrlKShiYaWbRGm-SZo540zd9QPBTtQitxd9Xw>
    <xmx:CjYIa2-n9hfOuvwlzv5JS4VG3EFBW-V3yQrNoimvIWDR4aEtKez4ng>
    <xmx:CjYIa3ZydvmxheEv0bGg6auow_TXJ7xQ4lFT4yttlQ4gCF-_9k_VcQ>
    <xmx:CzYIa_o4ZIK-gm8mEUWKmIwc7qwcNBhAm5KSAUpCilMIyuYGh0exuY_H>
Feedback-ID: ia0f84a9e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id BDBE2F800A1; Thu, 26 Nov 2026 08:37:12 -0500 (EST)
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
X-ThreadId: ASQztn6YUXh7
Date: Thu, 26 Nov 2026 14:36:52 +0100
From: "Geert Uytterhoeven" <geert+renesas@glider.be>
To: "Yuho Choi" <oss.patchbox@gmail.com>, "Ulf Hansson" <ulfh@kernel.org>
Cc: "Magnus Damm" <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1ad06f20-621d-4dc3-8978-4c22dcd476dc@app.fastmail.com>
In-Reply-To: <20261124153811.338437-2-oss.patchbox@gmail.com>
References: <20261124153811.338437-2-oss.patchbox@gmail.com>
Subject: Re: [PATCH] pmdomain: renesas: rcar-sysc: Fix CPG/MSTP node reference leak
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 24, 2026, at 16:38, Yuho Choi wrote:
> rcar_sysc_pd_init() checks whether the device tree has a
> "renesas,cpg-mstp-clocks" node by storing the result of
> of_find_compatible_node() in the bool has_cpg_mstp. The returned node
> has its reference count raised, and the reference is lost when the
> pointer is converted to a bool. rcar_sysc_pd_init() runs once as an
> early initcall, so this leaks a single reference at boot.
>
> Keep the node in a local variable and put it after the check.
>
> Fixes: 1c8c77f52d10 ("soc: renesas: rcar-sysc: Enable Clock Domain for 
> I/O devices")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                                                Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                                            -- Linus Torvalds
