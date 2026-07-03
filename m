Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEEA352016;
	Fri,  3 Jul 2026 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065414; cv=none; b=HJoYPIy6dOeO6v8uX0tih6T7ZrkMQfMwbdYv0Vwisy8hbv5MA4nYDTq74E46LvtAItZydUCRvzZVGV8fpHtDoGVZm6DacDmSP8QD9VbizkbtVVMr4Ilqk5+w1ggLmKJ3F3PvqmbqFzbSO4ydyTEjYcuWVrNjyRGaLYq+2hszsbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065414; c=relaxed/simple;
	bh=aQ3oEBTPhm1gryIRmhwlrfvRxDkq3jO2i7QNrtHN0YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZkd+tAE4YcEwmVgjn9nUr8JEaxlEEJ1MIjrwUEw0rpPjR9m7ggf9FzuQtoI4iviB81PiWTDwIZVxqyehmxqkIF1h6K0yi3vEl+NKj5zUBHhFVrohp9cbvCs4kmB4Jq9AL5y43UchlgoAPmkHa4LIcJZWTE1YvjKDJjEE7W8yaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+OzT5Er; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+OzT5Er"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C961F000E9;
	Fri,  3 Jul 2026 07:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065413;
	bh=wkiAfNgFKoP8g9PhbtCeDvi8bG+BrOFBZaoRy7ahfPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y+OzT5EroJvo39yBHYzrs3W0lOk8F7+Q1XtzJSTYv1MG5xZmMkS3r8VkZNTrbwieK
	 2eUJX0IKJGtrE86viN9xz6mPRsWiik60STpWOfGr1xYtdEWEjUAMzmsRIbfoTzZJir
	 l94wfRN4Z548JeJGcA95qlbeKz3eo1NTQ4hLLUmZrb+rGDG0f1/0O30yOg4TsIqWdk
	 1CImlBy2+Z3uGPiVMxh38O+OahtqkU+uwfzzUqe/qpf8OpIcCJRLzenAURy/wthzIM
	 WIrcRvAv6+JpfrVRnC6Q2D8GPpJgz0Aqdg+3d0w8+Zi6Au1Pee+F67eB76BN2BzXVP
	 kZrzVlIJ/tTnw==
Date: Fri, 3 Jul 2026 09:56:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Amit Kucheria <amit.kucheria@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v4 04/10] remoteproc: qcom: pas: add support for TMD
 thermal cooling devices
Message-ID: <20260703-accurate-feathered-mammoth-11eaac@quoll>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-4-3882189c1f83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703-qmi-tmd-v4-4-3882189c1f83@oss.qualcomm.com>

On Fri, Jul 03, 2026 at 10:33:07AM +0530, Gaurav Kohli wrote:
> +	tmd_inst = qmi_tmd_init(pas->dev, desc->tmd_instance_id, tmd_names, desc->num_tmd);
> +	if (IS_ERR(tmd_inst)) {
> +		ret = PTR_ERR(tmd_inst);
> +		if (ret == -ENODEV)
> +			return 0;
> +
> +		dev_err(pas->dev, "Failed to initialize TMD: %d\n", ret);

You already print error msg in qmi_tmd_init(), no?

Is this probe path (looks like)? If so, why aren't you using
dev_err_probe()?

> +		return ret;
> +	}
> +
> +	pas->tmd_inst = tmd_inst;
> +
> +	return 0;

Best regards,
Krzysztof

