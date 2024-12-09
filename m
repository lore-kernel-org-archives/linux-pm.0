Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0251B425A
	for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756062; cv=none; b=s1TKnZ/qBJ3x+aAOqN5Q2K0AYIXiaSVRovRUkO0Srlrlk3eJ2KgYaTAOc6E9yTjttpppQg9qxn8pbkRnKimcaBs5mbVL3Itt6YrAEpZe2BRgJC+hPoELox0jokkJZrmuD8tByOrGCnKTSTm2wZuAfXmgN5jAI3/sKev9tDzOqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756062; c=relaxed/simple;
	bh=L3uPqYvqbgHQKbRYysjnG8NJRJoMHAJpo1X5a/nsGbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXY6+22pHvxahYu8PNKEiZ5DDm/1okU2QldbsHjLsBnMAi0TeFs2F3GjX7G8ZaR5DpqjQCD/0zxG53AGPBp/AHAu2d1dsf7Q/Af4BJIp7iWqKCXyIsqnz6i2VSozIrbCGXvS2w5e42SN1PU5z4J2i1l+8ipT9JNisJPLIWhw2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vWxH0/h+; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vWxH0/h+"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so797250e87.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2024 06:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733756057; x=1734360857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3uPqYvqbgHQKbRYysjnG8NJRJoMHAJpo1X5a/nsGbw=;
        b=vWxH0/h+qrNQJBz4YdxyKiuKZte7A0qFI+1Js97zehJPYd4oKZoCWjMGIfJ6gB1PnF
         n/jDM81eeDWT6XzeGAIEWi2dOef+8L6VnveKxrtK2FB8SG9ATFLuAlquW3Et5+e54cEY
         1d6rAvEzT/EJrSAwrhAu6qgv0Ah5bDw4cwW0PQvqI/TTbdHUJ/vGOyzE2mjjXDUeUgp0
         L3TpyaZpz22PvnnnZHDgjTsAmgTulnKC7RygtmKnD0XJd/jMbg+abLJNridYhbONFOTZ
         qLFRUUp7xtIJBAjKrUTy2TIuPB1g5zj6HON2vKgZmQY73hENXpk9K4wdJHa24lSMFXMS
         lqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756057; x=1734360857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3uPqYvqbgHQKbRYysjnG8NJRJoMHAJpo1X5a/nsGbw=;
        b=cHEYDBav2PnlfTmBqvR+yEzDr0HKtILqIh6aLHdrVjeOJSpGa4PT2qjeYlQWn72RW5
         bSkre2rneK+e8mjvVG0OMd05PalAkeAABnL8IFqrsEEy6QKMllXL4yFoPCNL9MK8u5p2
         sAFJRu1X376m5mWNBtelEIpENhhNrsJo7vl1Yttu5N1EiTR86J4ahIo7Ros703wOuGBr
         n2ypPYbgCqEkWGuV23MafaYLoJyP2FyheFI0otcafqFWhbstm9thGCqbQLUlnvqVHHlB
         QzpbovAVYC90PB8JqbK8x7HzlovVKWFdZsizgAi1G0jSisTMTqDLPdcD7N4QfPbwodrk
         fGjw==
X-Forwarded-Encrypted: i=1; AJvYcCVKRDEuLAgW8SpqEWdp5Syn+nC33WQukMBEmqJK8OEGHaq84ImCfOQZNO1aB0jOMkBiKMQN8jKV/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYli7ZLmNduua8B1ghRaTm+dK16x1lBBJQspmkgisRvuj1GV5q
	esOhg9uF15n+aUgIKi/Y8KPZW7RKd+peH9QV6qGHjyHr7ZXlrUF9mum3ZUig1PcgfIKxFPlg4Ue
	tYrHTewrChU71zRGsSZgiJa4O8rCehqgFHF+hTA==
X-Gm-Gg: ASbGnctAXIS0dcRtj5KIWXfDIPwYvTW0WmQLWkuYVt70RlJQqdq6AAcjMp+Z8dawUV4
	pO2Al5uks/6yyFeYtUKQe5w7hQVUiSx139qnjA50z21x5k9oggrWMm7Z1m1XJONA=
X-Google-Smtp-Source: AGHT+IEznO0uqtPL1COzvxGwq+VZpn4uiLON1EYzg8NJIKAdwzxMATkws3UccavvSGGamvwnW6zKLVEwbVjxpooMKJo=
X-Received: by 2002:a05:6512:6d2:b0:53e:16eb:d845 with SMTP id
 2adb3069b0e04-53e2b7328d9mr4535052e87.18.1733756057474; Mon, 09 Dec 2024
 06:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209103455.9675-1-quic_janathot@quicinc.com> <20241209103455.9675-2-quic_janathot@quicinc.com>
In-Reply-To: <20241209103455.9675-2-quic_janathot@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 9 Dec 2024 15:54:06 +0100
Message-ID: <CAMRc=MeA7vFiWFN6RExmiBFhrcRwfVdz07YdQJ=c0trTbeztNQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NSAxLzRdIHJlZ3VsYXRvcjrCt2R0LWJpbmRpbmdzOsK3cWNvbSxxYw==?=
	=?UTF-8?B?YTYzOTAtcG11OsK3ZG9jdW1lbnQgd2NuNjc1MC1wbXU=?=
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:35=E2=80=AFAM Janaki Ramaiah Thota
<quic_janathot@quicinc.com> wrote:
>
> Add description of the PMU node for the WCN6750B module.
>
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
