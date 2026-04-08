Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F63D5222
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659767; cv=none; b=eiQcmCHBB0dGmlVuKmfztwJuf93z0mwUu4d+0BExCGymDzEoHn7jBWUf0iefhglf9n7K+Xo5ZJS9fVKn9llBktskhfrzCwdwbT2MnFg1OmETiiihlaVb3mDDiGaQ/SS+AaGo1aw7AkOktGr5K1WGEC+eLAUheYpBmEXX6PT34WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659767; c=relaxed/simple;
	bh=8EQsRJiGkX5iRTB/AZVv6hwVd/Kx+flU2pF6ssQXU+8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=lqzqpJyqHae7RQ3YoMAnIMbDJlV/sfH3ALdDGvSQBIFSX5ggxtdVBjCZ3203pA7h1YXvpR3iZF8j2fB/73MJBu68THJs7EVdJyFTxl9YLqFdazxQ9mp71DEy+BNHG2Y6Qp3NwxIzHCayGUMllRSoVez0Vr6680nI2Bh1BrEWix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZBqGxwQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZBqGxwQ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d43e09de5so1597495f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775659764; x=1776264564; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EQsRJiGkX5iRTB/AZVv6hwVd/Kx+flU2pF6ssQXU+8=;
        b=NZBqGxwQa7Yi+HoWDlbHzdr8kfrEjy2wYzpIDKQsN5HRVoPjsOlu2cZc8JUh/RVHyO
         S153dvYOW7qj5l03qYuxav89jjBuphJwHpd5u5MD9XtDcqDKO3NklC9c5SRZzVoykN3p
         nZ28jiR28CutpJdpieCgPO6A1vsv+a0qz29eJl8EgGCZ6+mcoveySnzAZ73yDm8pqb+d
         T08qfHEHbab+TZKR6Bncnas/Z4Yi/LSSV7ajGhw7ry2/9rzdlnPLhHeFkzMR+46h99Er
         CLEG8CSlU8qtTJeNZ00DLEhH3zMOME68L7XrhFDgBkn69INy1pWnP+zUZBBysBaF5SG3
         4JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775659764; x=1776264564;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EQsRJiGkX5iRTB/AZVv6hwVd/Kx+flU2pF6ssQXU+8=;
        b=nrWD8DJSv3p8aVeO4nntTNcHBX7Z/7jqLFpTTw1Jltt8ca/CVO4hp7dQlStmpbZ0ba
         DiIqv61UStIrIHYtr2eQwvXbkNVOxX4mqmRvHux3XaKun4sOjFMbfEkgnRKUllio7Pzf
         25E5V8gL3rUsliRQimL5g+KxeCTJ2PmhYO8lS5GK/jZkiaK8vsi/OIaYL8iyhDEJPCe8
         GhvrU7gYgtBJNbLt1fmcqJaDS7/c7wtjGD3dzsIJxbsrM818N2Xiyjy87fabtpC3/Sfy
         3QJ/N3prsRlCmB/FVJMX2r65y+x1dRqj84KRW5kKrWtGHEZL+zU+Xk3lnxsVCO03Qs9f
         p4rA==
X-Forwarded-Encrypted: i=1; AJvYcCVgJt5xKxB0GbB83Psto0dEtspPYEu+zRTlL8+dBYT9idKiC+EPnjYBV/l2XVxlx5gmWV/n2+uopw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9XUHvfKm8jfnMTbSpsW02zqX6TniogpnZBQrn9Rw99RYfBYH
	4oyaY3Ot2Ihw3HIGVV4qMTPheVGsOLFVBe4GyPuz/oE1cNRzftG8/QVHvJp8oZU15W8=
X-Gm-Gg: AeBDievmVjcF2n3j4UpxG9dtq35HRYeaaJd7UAdb2EQCz/auiaT/9jO9l52xa5jCtLo
	5eWzpkcnuBPtrpd3wxR00cb9uyPLK7nOCgK+ZB2xNZWLVsE1MUyrVZ8kDB2YjO4EZ3AIi/VqME7
	w0cCjov/0DPAChVROI6J5xHXSrrKl8ROOrlb6pNtNpq5Dhw96p0P8nN9Jdr0S7sIm+/XEO2tR+B
	FWKo+UbasabN18GqoETWOJ2sheKP5i3RcrqFtReVfP57Bmok2rXIx/aRl1SWtXb9gTsKc6OBN5o
	kqj5qWpnA+SCydOAWaMSGMdMSpAJ+VRRYGfFEbayTIRGXVJm3JoK1JdFPYC8JGybN8T6Db0eczv
	dNUu2RqZi01gu5jlrLDvX9VJBUS8ArOxQNrINYtipzm7DEnfBocx6TrSAlj9WVwF9vam5slyQv3
	WAavcRHuFXQG30lwHfA6fEekdL+9t7ILw9s88lzwzcr2W2UNgoxa+VRw3Ixkv0Rq6MDueoFsauA
	52PQivLOIEtDV6fgw==
X-Received: by 2002:a05:6000:2885:b0:43d:1c21:ead4 with SMTP id ffacd0b85a97d-43d2927bc28mr30909918f8f.18.1775659764374;
        Wed, 08 Apr 2026 07:49:24 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:9775:58c0:569c:bd74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm57988952f8f.31.2026.04.08.07.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 07:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 15:49:22 +0100
Message-Id: <DHNUUPQPD5DR.18P18VV0LNTI8@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel Lezcano"
 <daniel.lezcano@linaro.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Bartlomiej Zolnierkiewicz"
 <bzolnier@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>,
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 <willmcvicker@google.com>, <jyescas@google.com>, <shin.son@samsung.com>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] thermal: samsung: Add support for Google GS101
 TMU
From: "Alexey Klimov" <alexey.klimov@linaro.org>
X-Mailer: aerc 0.20.0
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>

On Mon Jan 19, 2026 at 12:08 PM GMT, Tudor Ambarus wrote:
> Add support for the Thermal Management Unit (TMU) on the Google GS101
> SoC.
>
> The GS101 TMU implementation utilizes a hybrid architecture where
> management is shared between the kernel and the Alive Clock and
> Power Manager (ACPM) firmware.

Do you plan to update or work on this series? If, by some reason,
this series is postphoned I can rebase it and re-send, for example.
IIRC it needs a clean rebase as a minimial change.

I am constructing some code on top of it, so it will be nice to have
newer version that can be (re-)tested for Exynos850.

Thanks,
Alexey

[...]
