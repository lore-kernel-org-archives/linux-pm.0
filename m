Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541A3D6462
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662128; cv=none; b=jEtRUhjSHFceM/Tz7FvIwziX9JXaMIlzT4uC6nTrx6L0PRqXJzYzajoQkQ7dPNd36yJ0kupeklHN04h/PKPcs/RCQjyEwC2FEC4moHAMOnNprF6glsujkQb93YpVM3QKbP99Hp6WpPT0O9RHuF9gfANI3gFI9rPAqaovxXjdC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662128; c=relaxed/simple;
	bh=HbCkXwfJZY9tD/wAVGkphDf2fJR9TOiyZzkM3KRVHFE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eSjKET5sqxvwDwZlCGRio0UlrIyYj6Z9+7tBeIkz4l+BZAuNCJhgFruiluq2pH/bTY3cHCZCdMkmrNhX6VcMwm/FlkU0DxKqVXY6rVid1D6fFnsE+8ssnQlg0jrLykm4mrjWqJ8RZfX4Fs9q8WbSK9qMUpkTfbfNV1bO5bHiUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=knIHjWbF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="knIHjWbF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1775662116; x=1776266916; i=wahrenst@gmx.net;
	bh=HbCkXwfJZY9tD/wAVGkphDf2fJR9TOiyZzkM3KRVHFE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=knIHjWbF8HaTDGhH0zMI7nplcWJLEdmCwo0vfTla2IMqZx8DpJebnCdRYaYmFh2/
	 Q0dOsjJfn2cdLPqsz6cPrz/C9m42aWyxX+tkBMUoboOLU6N77Gsv+2LyXXSBYa09J
	 9kScVSvZEkj/qbmBXJ/xETVVdig49KK/s+Rni+WDi403W5Qct9eHGoVXZgv3yxLIE
	 AbX8lrksdQYcGPkkqjmtCJHie2PaioJ8O+Tif9uR9kS07+Y4fyaCbrO3MpxnHax7f
	 W1WDMSxKITWol7vynOaPhUilRjGF1GAmL5l9SpHv06WhGlZ24X8XHtgBbvpfNp6fN
	 6AWvfCAEs6I+7N0mkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1vXZmf47NG-00aC0x; Wed, 08
 Apr 2026 17:28:36 +0200
Message-ID: <1ad05dc4-9eaa-4fc2-a665-e17521fd333c@gmx.net>
Date: Wed, 8 Apr 2026 17:28:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jacky Bai <ping.bai@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Frank Li <Frank.Li@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
From: Stefan Wahren <wahrenst@gmx.net>
Subject: Status of thermal support for i.MX93
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YNsJGKS4LLEUQ89ZQ3ngiITspIRCO4Oq29gz/Qi3nXAz9/LGqmr
 X9edet2wbaFqdybA0hV+PvDCARxU85c4eqVUkRjf+EII0kQMtpPOuZXDZdsX8ph8+JvL5WP
 RT+q7uYqJ34c8NLPhDYIvEeiORDAk6DMqkH87AL3wfsLVDlwGvSvshLzr+ri/UGk3G1QZwF
 xcyIktSiFD4AnD4ipf0uA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ONX3p/zv0CM=;4Y52PKYbLWXzQNCkdQfEQMh0JP5
 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

Hi,

AFAIK the thermal support for i.MX93 hasn't been mainlined yet. The last=
=20
version I can find is here [1].

Are there any plans to finish this work?

Thanks

[1] -=20
https://lore.kernel.org/linux-arm-kernel/d9392dbc-806a-41df-8992-28c3d6132=
309@linaro.org/#t=20

