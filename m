Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC52F8EB0
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272581; cv=pass; b=Csu68HLbyMy2T251U66T7yAvEv1cldGuPVFHL1wwYujGGXRDxKntUfhXdc/7vehRr/aUCJEOivlod1lGXKxxb5lXabsRj3CCqDe99m2Z3XhuZpWe/jNPUpaKonmf4+sN6wKTaAy+b79n21nkuucjul01X2Zt8uUvkPCK8go8bcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272581; c=relaxed/simple;
	bh=/9tz9Gj7/smAtDHhEOCvlfAtZV2MqM8svnwdDenrBQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qz3Br6CAQiHN4u2wbvPMf1fC8xZgxjE0Bhn6REwspkGH/WBtVKF/wFn7Fo4QiV8V1D4BXONbRrHonHi9sb0/QdZ6n6xP3yvALCDNIqNOSC1LQZgcuRbiDq5i2ndZ9k3cVS9Qjx14RRThXVpt022Q/QI2Kn8Vr9yfxF5BL2hnnQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0r1Bfgg; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0r1Bfgg"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-476a130c138so2297189f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 10:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783272578; cv=none;
        d=google.com; s=arc-20260327;
        b=VmXlSv2sp6ezOSeT+eRE+G/QDVovSbJ7qPgqWYc0dNb3AzP6bz/+NMABpOM/GoCEyr
         J/W1/SE3WY4lC/DxXDNDbLW6LMAJ5v1nkLLNIlaI+kcZU3JuJqwY3wUbuvMjlCMgxcXk
         GmI13UDXUeN5nM+5vheV5dhJHOvF7Zg/xAQw+dj93qOCRaRvxY9BTXHHfX1wKYl/BGsO
         P7TppB643VQwaTAW+uxaxZMVJ/uZZ9cQRfFve0ZbLg3V1gYL5vDD2GgkR6w5oaUlZriw
         m952jyT+0/gl7Wm8Pm/CypFKX30Df3S0P1Mew8wgClsQrE9vPPzRYMfR+IqvITKBmK93
         tE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XLezQwhPY7BUrn23M2xpKTiVW4rocfdQBq+p53l6sXo=;
        fh=g8eKma4OIyO2s1BYILVNDhJl10KOPxNHYNG+jB8osL4=;
        b=fIq5Ome8ue1COsqJ4DPoBQXhZPnwmow/TgylnCCLxjdKjto3iD7yu4PbRss7lKqxSU
         mf432QNzgdGo9f9sHD2mzVDvxHGQzDl8Zndnk0LRBvsG0h3qI5u+UjKbGHmPOaJiYG/C
         exUDniEFI6UnyMI0r4FHgd4PpTy30tZW85THOaEyKgnCuycncJFcmHshwmIxodvaZqA1
         jT/c3XrNTqgYmOzK3zItuQmKwFXUL25eTHg6gp9p4TxR7ajFgAeBuOF+toBO0R5DpIus
         iKPbL3g85jfXV4JXTzb11PINUyT0PdA+KXSff1qjY4RWtWsfMfNTx03MPFo/ztax5kQn
         0Gfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783272578; x=1783877378; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLezQwhPY7BUrn23M2xpKTiVW4rocfdQBq+p53l6sXo=;
        b=O0r1BfggC+LjcZPINm4juLgMG4gG24UnXCXadJU66f93/SSMQAhmjfnEHU6GVVik4H
         BPeaqbczwHCzy/vDHnhNlCZhy9Vjh2YR/XV0w8+XC7sWNcQ8StWJVGdnHq9OmM8+NAx1
         HM3gNtyzf9Fk2mfX/dkUI+6UHoEmDjxhMkkVqsZWfX80n5WBsYJrgSMVCqSPCgXb9ItT
         v+KFivMiQkC2CFn/K0eveYXwx5POXhoOFDPzv+lj1bUV7fMdx9yO/duwAc6Y61q8NT4Y
         OP7XPB7QgLV5Xulm5Qb88iidQo8Rg7Ha32RiEQHL8gT/bS+oPJnCgf9CSgr8+/91Xd6D
         pKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272578; x=1783877378;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XLezQwhPY7BUrn23M2xpKTiVW4rocfdQBq+p53l6sXo=;
        b=mLYxXtVITtHbisDiA6RGRgGOJ8eGqCYN2XjkRiduaeXxfdfNwDtgLePSdx0hV8/rwr
         oOBSCWxm+BZgNFeWVr9PQxdrVBCO3//EQge2QMoHnxzYdZQsCWOATCZtkE8gALL9MBNu
         +CYOkO5Knwl3dqEiE0T0nVQftpyGJe3Yj/pY9igcM88/1W5mI2vP8go9Czf5v/nsya5U
         wRX+Y1g6brutmonk+LlPrq5ijqqhxuYJHzaY1IM+WlMUaLb7fIp/tHk6jAZuTGcT2xo8
         hX1cCLzzDCovtzOuE1bUotpsvePSMPp0M3JUOFpLOGvDF8nl8LuBgTi9xZS0ezQMVctv
         LI+w==
X-Forwarded-Encrypted: i=1; AHgh+Rr4JGW0u57KZ7WigcP/jfcWU8s0Sn17yz8zUEoxlsQW23WylZs0UF1p4WBW8FLIkNCknZFFndOTDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YLWIF8pEBS+iY7Ge0id0W61AvASDfborKJS8uR7oA/z9FhxY
	coaXIwkxh32d6UfLc4OU4FdPUpKR3Cp9urvdEy2uDXPENowRvrWoqkGtse+j0CtQ+3HI4WqxYqK
	De2pUJAbgZqGWI1avDyUEH5aYaSY+Qq8=
X-Gm-Gg: AfdE7clP2w5H2Qy9bYDsH1zcPXdEJfxwTrrTuth8DTeziUOIpGftpaTaIlMsjxzplSI
	At7isqkTE32Zr7gamezfungspffYqUHchlnMmVBEGDVMq0tQakv66j0qtffnHBcd1p5ueslbSt7
	afWokVh2UnOLkl0y2poEG68abL7bULkJh3txPXYfW+4WI2tFu+wrVXza8KfOgx3+0mzAmJfQyZ8
	f4Gafo6R2bi73Bq5F/1BDAratEJROuwSQQS/EUXxBIFAG/1BO2oOe+al2U8XP8tQZVf9q6Ah7PN
	k3wTS9uYXtUFiCQuBvuOxLNh/kCLJxNfQ4bjr4ulSWkOFlZWS0+Akqe87Ay8jqRNZ5RmgYWnfhf
	mtnESUhnNgLswGtC1W+vqM46R7N7WknFnSyzp4mbaiMoALw8R/uEwwEndjnmGggZjNkweHCFM+e
	e4KuF/oP1zO+RsNixAgyrBM8qEHwRO9qw0wNaUwLAZOOArwCJ6XqtD0OleMLP/c4k=
X-Received: by 2002:a05:6000:298d:10b0:46f:558:a43f with SMTP id
 ffacd0b85a97d-47aab57d3b9mr5698021f8f.4.1783272577955; Sun, 05 Jul 2026
 10:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com> <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
In-Reply-To: <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 5 Jul 2026 19:29:26 +0200
X-Gm-Features: AVVi8CfQUxrT1-hVwlpSkwk0fu1ROQnVJWm80bpEdP3NZQ2u32dEzKUetnRoGfM
Message-ID: <CALoEA-ynWc7Dash6sprqZotp0gxy3a=t_VY5r7_00KMN6kYBDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: qcom-spmi-adc5-gen3: Remove an
 unnecessary print
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, 
	David Collins <david.collins@oss.qualcomm.com>, 
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Stephan Gerhold <stephan.gerhold@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Jul 2026 at 18:55, Jishnu Prakash
<jishnu.prakash@oss.qualcomm.com> wrote:
>
> devm_request_threaded_irq internally prints an error message using
> dev_err_probe in case of any errors. Remove the error print in the
> devm_request_threaded_irq failure path as it is not needed.
>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com >

-- 
Kind regards

CJD
