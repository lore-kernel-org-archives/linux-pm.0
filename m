Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903131;
	b=iA6jpk3ecRYd3o9XflNIF5+/mZvFAvXJnow2QmqoNW1i6rztc+2n1rZechxQzeNpfeIy
	 m0cxFD+gxq9KvOfJ0YFeJ92fAhxdwFpf7UohM0AwwaiikjWiFsGd2n4cLPzTDbP+HtUdf
	 M1720akB7pfjFkt52EwwbDBIBD9gNVJpflcwAkalSIGtZeAaDpz+h1frKGhS5vMrrz9Tc
	 /xVQL+AgSfNMzHpgETqFPpJUw6WbnBwMtYQHzOLHyOzd50FQwIlo9P79midLq59Fw5Qo/
	 xolZSXfs+ziDeFygam9HBp7b0Kfn4fdkV3CYk7Mu4lyOPS7QMcHCTfrxfoRP1MZkXgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903131;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kRFmKBJ1bTsk0r4k62R1tR6K48M0BUczLV02WnOFo08=;
	b=fW0pQsDR7RLxGC7AWWRYq3UvQSmdfVewcFCWK+/F1WbLxfJUyqdV4dt4alIUnI3Fza2p
	 o7BeGT8taavPR/VS2qAEZrK6ECbxPJgguc76tI0zbc06PXat+tyusg54LS85PAURFLLfd
	 pfvMY8qyD79Opxr7UysDLWuN3TR7ozan9vUQl/dztQUrxm61EwgDbx2JCGjJJzAZDsW8N
	 lXGlX3RXHmvYosX03ygo9ILdZZXbQSWXn6MPJ7ZjGVZPAd6gg3QnihCRnJCRE+52o5EPu
	 WogXgGGn5vG9xIXdQSqx4fnKsAr0BpiblGf0qIZZk03io9fIGNnepFqdqKDoslmXziw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=otZSp2qt;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b="t/G+WT5S";
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6920606A326;
	Thu,  5 Nov 2026 18:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6920606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=otZSp2qt;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=t/G+WT5S
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793903127; bh=kRFmKBJ1bTsk0r4k62R1tR6
	K48M0BUczLV02WnOFo08=; b=otZSp2qtxJG37B/ApQTfBnhkp2XGFFU/z+4qbEbJkhy3OStcbq
	RGof9IeEBw6N/qHY3Yu6r0uoEiqO67zc7qxUmyjbhUsUxBJ7qN2wdhpavhK/BZ7zgAxAGshZ6rT
	v6i2Dxa+J/fpWw7e6U0t1vlkHDWh7xI8Z+DSwmHXj3OZK7ys8nfoSJ7vLuftMaVda8z2hSvp6bx
	zJvLYqh19IBxxaKu+U/kNE9dyTNIrC6g+dNzzYOI6psdlh7PfzGYBwyO5JH0xwcC8aI273V30C2
	uSiIuQJ4MkcJuIocSFzbgldpwfxcZJqgpOuw4FfhVNJNbig7vnN0vtyJG3DeGVL2yhQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793903127; bh=kRFmKBJ1bTsk0r4k62R1tR6
	K48M0BUczLV02WnOFo08=; b=t/G+WT5SdK1eYG0AuecJ0JuXuDjbTUb88Wr5cK0QcM/zMNPhHJ
	NWzlDczieM7G/L/IhldS6YQWyVDnWMI/sIAA==;
Date: Thu, 05 Nov 2026 18:25:29 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
CC: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 avaneesh.dwivedi@oss.qualcomm.com,
 Umang Chheda <umang.chheda@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 kernel test robot <lkp@intel.com>, Francesco Valla <francesco@valla.it>,
 akpm@linux-foundation.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v17_0/6=5D_power?=
 =?US-ASCII?Q?=3A_reset=3A_Introduce_the_Pow?=
 =?US-ASCII?Q?er_State_Change_Reasons_Recording_=28PSCRR=29_framework?=
In-Reply-To: <85e8effa-dc1d-441e-a721-e4078388c9ef@oss.qualcomm.com>
References: <20261019-pscrr-framework-v17-0-69ea6cdf4731@oss.qualcomm.com> <85e8effa-dc1d-441e-a721-e4078388c9ef@oss.qualcomm.com>
Message-ID: <A12AE726-6439-438B-B9E8-721179C47710@mainlining.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 November 2026 18:22:07 GMT, Faruque Ansari
<faruque.ansari@oss.qualcomm.com> wrote:
>Hi everyone,
>
>I believe I took into account all the comments and got the different
>reviewed-by tags from the different maintainers for the changes touching
>the files out of the scope of the 'reset' area. Is it possible to consider
>this series for merging ?

This series looks sane enough to me. I recommend this for merging too.

Let's give akpm a try because he does loads of merging. 


>
>Thanks,
>Faruque Ansari

--- Thanks!
