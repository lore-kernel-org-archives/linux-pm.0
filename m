Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43382D97AA
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783273664; cv=none; b=hQScvMjv2VWDvpyOxmFxzJY0CVTRSi0NLbE75NUWENqxONgcpHlTXYXK9NH/EdXd8DMuu3egx+5mKjLlQu26CR3ePwxHzITLasXdmBRUfEWRomz2g/gPEJn4wgBAR8Lj7i5njdCOZrhUtAFBB3ztdO5hHO4501LYS2eqsqz/tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783273664; c=relaxed/simple;
	bh=+DWCiJuHtexmYzOgAlNi4lBL2tdyHsr209Svskkd2Rs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=goON6TIQbYQ81a5ITeJQTWLj0wP2M363EWSazRwRZWfWK8eGnecDAqtdmzaaRHnsDwKlFxoib2da4/enQ7KBvYNhWtseSNXj0yeyXfQ5539zF4RrX127w99GhB+J2q1JvtFnV6qU8aYosa1pyEj1G16H1J3L7ifw48hX/ho8dqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR9EVRVs; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR9EVRVs"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6a308736a36so1334558eaf.3
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783273662; x=1783878462; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=75FEqaRZi7gyVEUOxCRUP71SjurGrXH97prx6jJpO3Y=;
        b=RR9EVRVsmCAw+wcrAKa4ntkKxPOIH9RrIpAy1ENR/V+W4NGiDXFGjZO52kbHPTlV/5
         lXnuIBS+6aYZiccU/hhfLr5wh571ToWp0Vfgpy0XY2bp6nK1j6fHro6pdciCpoCr56sh
         zdzQpGurW1AuVtlQ56rt11qsotsNcVxBRXSAHsDbwPBK/K0bhvLmeC+FtxNYqz1AoS3Z
         vyWEK9HiFkuemMIXcEd3GjymH0ZCe4z4DTp6ba9VNpn8egmWadrPOGb+nGPN4LpYGD2S
         MFq+7VUj/T54+Rnqwc+OzfJ4YU3dR3xTs5e/D8u+3K64Xapud3rE2veJ3V71Xzmk0+vC
         Ub2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783273662; x=1783878462;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75FEqaRZi7gyVEUOxCRUP71SjurGrXH97prx6jJpO3Y=;
        b=s/jj2VX5Fx+Ckk6+x4Dcez8wZ3d5Tujb1l0BBpzv3O4C5MgJQEwe6diIGDzmcto4BJ
         gKi1DT5cWPBjhWRemJePy0yHPze0IOuTOkGnbzDTAE92waDy3BirH/kKL+60LfZnVSMc
         CHynQ2x9qpXjyivTiPdNFsbEBIUQjT4ShT01pJqTU57tWJ019LtRWTtGRJamNDHwt8mp
         yTtV/PS2z0nQYGrRkNFD3h09w7IRj+vRvZ8J+RfJcGZYFgUKiK1zhl/y8OxFtnqBiZBu
         ioAeq3KFLW5sdkAAdT8YuyBZ36lG1rZ40O37fUZ+uqUTjIPYOL9JuyBu7js2nzkZ/Vhb
         3Xww==
X-Forwarded-Encrypted: i=1; AFNElJ8qLli0+AfkYvNbYFZYRaa//s47ycbI4skP9gF5co0kHkFe3Mt8i9aeRm7hU/zK3OGXqBnGzP5m3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqj/5K/hlbUhvJ6ZQ++AvrYz3mhrq4meEm8G0wpuqz/iSDy1rG
	7pAWcGd8JmvOvF3ZRAVtiprYiiy1YkKuGHZbkOGfL0pA4YR+UW530zLN
X-Gm-Gg: AfdE7clpgjhuuHZUzVD6oWofIiHR9pGLf9YoVyOdlKqEREdvsIUcueADnXyQYyAdjCj
	DJERXIPQbRWRfWUpT/hOAKFZjm9NWaU107nVpsLKp6CAeMZg+enPRI0V/KNvU4pnyg9de2/DHpN
	F91xJPUi9YuX8UdHNmUdj01yUP8YmSkMaHHTeCyrMOa5eg4aiEhoRo1477fd7vrFusdmwqGmhH5
	/uNk5zhtQHSc0KzLLMRYc/ROSkLxjlXg+Z+YTsx3lSFXT/B6rDfzTnRzVi64KhiWvEzqn34I4hv
	Jgg3f02dNqIBJrP+Xke+ulZTwEx6BqoKJd8aXztpx60Fwx6LaE8X6dILxpVBo8lsC5//QFZCeOw
	HvjgjF0Q37+9aXltKlkYd7zEEMoxV+vbIVixIssQXdhUPXDbS8IWXeDfKLINTpHZTnkqFSl9bB0
	UvfYfv7LSOOnHOh33oH3r/3vhL6uEtZByMcFkwhA3azjqAeLAw+g==
X-Received: by 2002:a05:6820:3095:b0:6a1:8192:4d75 with SMTP id 006d021491bc7-6a32f5d6b94mr4075618eaf.64.1783273661937;
        Sun, 05 Jul 2026 10:47:41 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb559559sm8482157fac.9.2026.07.05.10.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 10:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 12:47:39 -0500
Message-Id: <DJQTR5SRX5DL.20UJ66ES758CN@gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: qcom-spmi-adc5-gen3: Remove an
 unnecessary print
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Jishnu Prakash" <jishnu.prakash@oss.qualcomm.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Amit Kucheria" <amitk@kernel.org>, "Thara Gopinath"
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>, "Zhang Rui"
 <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Kamal Wadhwa"
 <kamal.wadhwa@oss.qualcomm.com>, "David Collins"
 <david.collins@oss.qualcomm.com>, "Anjelique Melendez"
 <anjelique.melendez@oss.qualcomm.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Stephan Gerhold" <stephan.gerhold@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
In-Reply-To: <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>

On Sun Jul 5, 2026 at 11:53 AM CDT
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> devm_request_threaded_irq internally prints an error message using
> dev_err_probe in case of any errors. Remove the error print in the
> devm_request_threaded_irq failure path as it is not needed.
>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

Seems like I'm a bit late to the party, I got distracted messing with
email templates. Oh well.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

--=20
best regards,
max
