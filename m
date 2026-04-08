Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2173358CA
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642598; cv=pass; b=I+EVVN5sXpDVLaM/kl7askaM5Go579yF0eAh5CTmwFJcDtM8qwNZcnDKTPFYfLwZy09LSolwbZCUX52Tq9pIoFH/+Si5FowJrmjLs4n8EzA9SSksXCdjhVtHF9klRm3IMgYLqJgf7glHItw/sM3QhJ3jUzvVaa6hmvd6S7K8knQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642598; c=relaxed/simple;
	bh=CBr4/JXzyveZ9gUjyhTdPsUF3GY3HDOAxtnHRkj3OQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzlqfEOWkzsDDCma3st1AJzSFHu64XUqUdXo84jNBvkH0zXuQ+CKnyKxO7NZIbeSjkh1lb3C1bOc+LyuQNRNzDbYPyWpA2F/Jh5cK9KlhZnVStGnxB8r7QuXUZq8MXE9hUR9IzR3qdxqAuqLIX6+QP1rrB8/bO4Ka4CZBRo4b2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCfMcKL9; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCfMcKL9"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so5897181e87.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 03:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775642589; cv=none;
        d=google.com; s=arc-20240605;
        b=AU6rvI+0LgIJV4BcxftHWAKc8NlCPFSxM7zIQqm8CLnA3+CLy4RCj9tT6g7KUv/4cQ
         gpLxs+XIsrT2yfOmdJN4bozhmK0Y5Tl7r5ufCk5GvvWWIPheHnSFWojARBtqiAS3QpXl
         1iAQKSznBN/XN7YRVEnCDU7pVbyYlYaYzaVrHsL2S76SlghpUkso+Aeu7mwQC8VIWd+T
         3wzmid1b8+AgsGEsuKEszxYoGyaqxuQVctlv6glWwkLNl6fxBpPx+B5GmZpuo4G00Fxb
         h3O2LdcvdvRKXPm/HsLnR1abUy7UQmgKbsXPPq1enP6PExLCxVaQ+KX+gerk2yK4Z7ju
         hdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PEyrayE2kYN1hY65mdTstp1ag2rGZYENgFQhfxeU98A=;
        fh=OHkpiPJ1u5GUdJU/TV6ueZmBFnm1sWgwsZMPGVlV8CM=;
        b=YwCTaZyMBWXqgsTXfoRKzLvGxw9QngttbbPwEpI8+IjJd6rncwVdjpfO8RjHWrCnBU
         5kJIi6VClTGhxJUwlCD6MFjigr8axWL6p4XFUVn282m7akykfgPPOstSlne8Z+4AlZ3h
         e0AcNaeMq3spr6jRNhGPJ7DH2YCbZy877FMYqvKNOyO2ZQqios8forHXe+rPRgZidGyg
         0ZsELEbLyw3XmPZO0GidB3prO0G8EdJTe6GA9d4/XrQsI2KG5j8ILK5WRYXvpnSHM8Gs
         qKpPBtHYjaREk/VWhuLB/a6WkiAbSNPscVrIt32ANWHLTtIpuIcEu01X0FKWWAz3v/BA
         8q4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775642589; x=1776247389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PEyrayE2kYN1hY65mdTstp1ag2rGZYENgFQhfxeU98A=;
        b=pCfMcKL9Y0KCWzgHWUFZx3POM7nyiVv2I6dXSphZpQYejwzQKz7nSAO21dgvv/9qtZ
         B4/Bihpgl+9v7dJDQBTog7kt10I77hHBlwVwMGTu8O9RY3kzjM1vPq29Yt0oQb/HmItK
         7zcHlo/YW7MfDKD1DGbK3ivQKdoDIjUv/5Rh1zDx64xt6WDAeVs7KjcobL5LJE+AiCrb
         rzp/3PT4kHOq6rzAk0SC/Fzque5OIT4K5jVqI677q2Lr+8XJlv2ejQgMrhsjoT2e19fs
         oB8xpbMuN7BpLFf2SN+87lPt0cCSIfJSFF4aICosp+RZz6FElsToU5SE9reh2Ntx6Ptb
         oA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775642589; x=1776247389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEyrayE2kYN1hY65mdTstp1ag2rGZYENgFQhfxeU98A=;
        b=mTUdLIT6eyJMgilnM/JteEm3hhH+DEH3lGeWnNOQEu+VFS3hg0BvLGPNzMhcPJ6V2A
         B+Vtrx1oQtVsVLV5HFSxDUw5gboYUFCQP2Awxp92SIP18AqnJObySQdNMCc4ETaMR/A2
         h0kRxlzosnsCCrhDaT90z4QvotxlLgrYhxOeTRP7OzD9h4ubaulLI0fWYMtBNx6Pnn8y
         VFqKFXunKiq6aJjz4qI1+NAjUna1I0TuMDwd/HOA6jdztuvOgbVLWHZy3nO56hUJy4iy
         ak91CFJmBYgS8fn6DAD4z+Vo7L9HfelMZX8uKbMNhATgELX0ED5IVODa4ESFMcviMw95
         9oyA==
X-Gm-Message-State: AOJu0YzISGRjALwoqOKT08fQl5mtKi0EI3MDjmn1n6L0iqfquqML0+Ke
	MT/Sevri7M01HHZjf3UI95OxftNC1G9A7x6VCgG8L07KUO++XK+P3/GW7XEH9aIlickcH2e5Xky
	efnkDAvTt0THYoq3hJiXiPs7Pq5AhFsNBUPO5JrOoIA==
X-Gm-Gg: AeBDiesxc7iX11Qt0TXSDCjIQuXUOJ1JJzqgEdqSKd7hhxrEj+fgtqm3oMbfKwCPKp4
	0pKrnK27QGgt6ovJAzJl/mBcN7v9bXsew/ocqkDcem5Vadbta8ivKh7j+2aYotd5q7reQbD63DP
	Ui1vgpxnOC5Tm3Fht8Y3d4xMTInDBOuROHpGa4NjrPhoiL3913jowIi3nXwq6Lw3Z65w6c6mXIm
	L9TI4Knq20aJSwjCMJFP/DgXQlmv4hrK6ZeUVH6c5nR4sLybdmp9G6yudHshIGjxWEZplo4uEQW
	6JqzFKg=
X-Received: by 2002:a19:f014:0:b0:5a3:7baf:516 with SMTP id
 2adb3069b0e04-5a37baf0529mr4522892e87.16.1775642588660; Wed, 08 Apr 2026
 03:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402025406.94272-1-rosenp@gmail.com>
In-Reply-To: <20260402025406.94272-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 8 Apr 2026 12:02:32 +0200
X-Gm-Features: AQROBzDWexNARo4IjITkl94P5SbK9YSsttWqIbmtAP-BJVdX4RN61uj8AM8oTYA
Message-ID: <CAPDyKFo=1MnF0SQTrE=K4Miqn8LQ+pW_p7Z-+cf=sRzt0g1zEg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: cpr: add COMPILE_TEST support
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pm@vger.kernel.org, 
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 04:54, Rosen Penev <rosenp@gmail.com> wrote:
>
> Allows the buildbots to build the driver on other platforms. There's
> nothing special arch specific thing going on here.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/qcom/Kconfig b/drivers/pmdomain/qcom/Kconfig
> index 3d3948eabef0..72cbcfe7a0c9 100644
> --- a/drivers/pmdomain/qcom/Kconfig
> +++ b/drivers/pmdomain/qcom/Kconfig
> @@ -3,7 +3,7 @@ menu "Qualcomm PM Domains"
>
>  config QCOM_CPR
>         tristate "QCOM Core Power Reduction (CPR) support"
> -       depends on ARCH_QCOM && HAS_IOMEM
> +       depends on (ARCH_QCOM || COMPILE_TEST) && HAS_IOMEM
>         select PM_OPP
>         select REGMAP
>         help
> --
> 2.53.0
>
