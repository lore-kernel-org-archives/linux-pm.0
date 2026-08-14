Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501B43DA38;
	Fri, 14 Aug 2026 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695733; cv=none; b=Ff6cs+6m6qJeWfJdUzZJw+7mo/4Vw7ClczEA4PuH1ouTAecV1ewtwr8AwA9sOWFRHDFJIDn106t7fZVAP0Pc2qh04EajDbIaE9WmvnI8bQ1V7gKd50LPXDDfF9PWFgEMccWpBNMQw42r1Wel21dZ0fzfysH+O7Dh9ZHQfHsUg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695733; c=relaxed/simple;
	bh=tYbMsjsVclywWT4pqdNdVvgEUPkc32oE3bvrFaDx+p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm+H1utiwfczhEIMU6C2pvj2UD95KgdAX8aDbe/m86LxR9JLH0aO9zNdY1plgItiOVZqQcJoq0cyyyS+kmzxBgmxxZgE8bf9XFjK3FN9XWE9Rl611UK7WBy3FhAJlXNdLnWeXabfSZ+4Rndy6ZUIg1WNmUDyDYCGe2A9hQP0Goc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=qcQ3s3l0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qtto3IC1; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="qcQ3s3l0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qtto3IC1"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id CC9221380234;
	Fri, 14 Aug 2026 04:22:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 14 Aug 2026 04:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786695726; x=
	1786699326; bh=tYbMsjsVclywWT4pqdNdVvgEUPkc32oE3bvrFaDx+p8=; b=q
	cQ3s3l0LQ19OGpr5qYNO/r4yT0f21MjSi8LdnV4IKLjy/Uel2+CuFUkSO/ZfIvah
	x5Zomvts4h7qeLy+0tyXRTFEp/uV6ruwIBSn00gzeA4WdtiS8QQ2hs0lIXMQePtZ
	CgXRmsEjDze/HRZzSAXToBIVSzlind8dovZz70nwGBHVHAAZu1sdOhi321znXNVS
	yQgv9bv5l59m1W57CXHmnUtI2rIIFqhV9OIVuxK1jHnSkfz3fdxul8ftYarQc1wp
	7zRWaHtHV16db/9kY96X/mWCw/LVH83rTYJIXdbHUf/U3edZHZvKXyGeDcJLMJOA
	QQmjYEFNAp/dBhotLgz0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786695726; x=1786699326; bh=t
	YbMsjsVclywWT4pqdNdVvgEUPkc32oE3bvrFaDx+p8=; b=Qtto3IC1Xc6+/iUYo
	162Qn5KNnllkP26KVmf0UXDaF3qNg81XxDy+1GVH571iYboPq9aromumVTgDUsk6
	bR1mm9iPVKHwPK8zyqwSEdTOeU6rdjp3iduFbinLtpMq49897PmgelfZ2yg0AeJi
	wQ/YtUaoawWW1T6Lt1K39way7WZrcQWYqesdJGDuS5BBkETNnA4pgNt1m/JkA0v+
	1M4XmZ02rYLkCMAAvUWbUTxW6ZeB2IQ7zfZna01DfOCkbDJQFqiFyzWHUBntBZVK
	a2wfVg/HFdO3BcRXzNmgWLIeB305ruycsDPw05Zm1YM8wu16s5HJTgCDzMFqn41A
	Bofcw==
X-ME-Sender: <xms:LdB-alNfGkSoIMmXfAWOdT0VN3wLWkeh7v6AsrWYsUfPGiVRXKHDSQ>
    <xme:LdB-ahV0yVwNm8E8jTi1I3VSXeb7POAbbbBh203tietHYifiZsDxT7mu3nTekI-Yu
    0Cj-0Pcg7ysfC65Qto5OB-xmPu3LtDSnEHoLbDcjKyqD3y-Cv5uqghC>
X-ME-Received: <xmr:LdB-asyIbIkA37gu-j9Hz8SF9FgGbJ1JHTemCFwr-MDX6ZkFiD8jDAqx4ks9TSPVZyMYRMDGiA>
X-ME-Proxy-Cause: dmFkZTFVlanrXEW8K19TWP1UI6tsJJsG6MwxDm1iiLMNJuK90FsZo1caHlyjFdEE11j5nY
    CZC2CGq3A+Ut1sUKen/cWewPEce9+IQKVa7Jy61Kup4KPTbB9ytN5SjRQkhnWJYgLQhIPm
    VRyS/7i0pELo446ufviXofoH9RHcuKkfBOsMxlOavi3G9MW9mePPnvEPD9buRe0GO+pQ8n
    CRFJuOPmKLfzQl9eYDWKZZm6eHC+LYAtQE8pAJ6wQnzXEUKAqnpJqs3kuWClGGY9Gjp5wm
    yaI30idSZ5MW+ZHe7Cnj2u03U5r7qw+yBOsncREJtTNrfwrQV8V/ItB/Wrwu64dBL+lPQX
    3cjLzuzT4miXsEVIGPYdeiK6MJeeHYXuW3yqd5lweMQaa5ZzXeRN34uvf+VIZbFzAqObhS
    2CU/xO4IT9M7Avntq1oNj1obA29lr+mhu5z+UrO/DDR3RlMNjQmm1Sc739FAZWCpjSHA6U
    pAKr8ePu3vrTizvTXScxzQgU+6vgr94MlX89l1rAsgeyoNmfnerdZraYmibQsGxaSBubI6
    eQhdD5FAbSO17gVDFZUqGFqD7zRwVpONbP9L5Wk7NpCNwEUe7SQM1P8ohpUftjhe8Tk4PG
    Z30OIi1lHZ3DaGcTkK2abWPicZU3fr7vY/d8p6TQjUY+dAq2fvxVjwb3KLyw
X-ME-Proxy: <xmx:LdB-ahMFZkY8YCwYaCiccxhPRCyzjq2uN1SWt9ijCxqbvvyz233hMg>
    <xmx:LdB-aupAMKiOjdFOgFLSMZOq8I3qUiYq53JfloN4XezOV0pFqLGy0A>
    <xmx:LdB-ao-pF2irN6diRDlC9TJQZ3KED7VYps2h0AL5vHQavT7_aETntA>
    <xmx:LdB-ak1OM6AFIg1T0vwZlcj8HX0I5x9Gl5eBKq6wYX6K9V62BYhZ6g>
    <xmx:LtB-arbFxQ4kACEdvM790iEBHB7-hvcExhrKbM7F3GHF19N6LcfIrFSW>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 04:21:59 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: krzk@kernel.org
Cc: heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	tomeu@tomeuvizoso.net,
	royalnet026@gmail.com,
	diederik@cknow-tech.com,
	chaoyi.chen@rock-chips.com,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v7 03/10] dt-bindings: power: rockchip: allow resets in a power domain node
Date: Fri, 14 Aug 2026 20:21:57 +1200
Message-ID: <20260814082158.3851740-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813-squid-of-splendid-hail-d968bf@quoll>
References: <20260812094106.1391698-1-gahing@gahingwoo.com> <20260812094106.1391698-4-gahing@gahingwoo.com> <20260813-squid-of-splendid-hail-d968bf@quoll>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

> This paragraph is redundant. Why are you explaining correct syntax?

No good reason. v8 drops it.

> 30 resets per one power domain? and none got to the example in this
> file?

One. Both RK3576 NPU domains carry exactly one, SRST_A_RKNN0_BIU and
SRST_A_RKNN1_BIU, and 30 came from the clocks property above it, copied
without asking what it would mean here. v8 has maxItems: 1, which is
what this series actually needs, and it can be widened by whoever turns
up with a domain that needs more.

And no, nothing got to the example, which it should have. v8 adds one.

> Do not need '|' unless you need to preserve formatting.

v8 drops it.

Nothing above is fixed yet, only decided. I told another reviewer on v6
that something was fixed for v7 and then sent v7 without it, so I would
rather say what v8 will contain than describe it as done.

Thanks for the review.

Jiaxing
