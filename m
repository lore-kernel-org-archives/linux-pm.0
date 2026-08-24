Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A63F6C39
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563140; cv=none; b=TK2JT25tUbjDnLOf4C8tc7XF/h54BIYFk+6c3qe3cC98yXU2FEn6uY4LhkVvX2bkYD+SApq4uHrlJaQHluX8WU9+HOC89EbyRIT1ekJEQ3IRiECOSNTnACLJcS1Fv2/ftZ7SD5O0PxhQoQu6AYS8VCuVJ4Ww9q1LR2yqN16gvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563140; c=relaxed/simple;
	bh=WhHWUx1lkpZdwfjQMtwcJicNC0V9nwr/uenYypZhCYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihff74pJES5JParMcWgapSxqhDvIY0EAvwbqTs0eTPg6MeipZx543LFhwhXLWho44rf3UKMgAi6DQsJzhVEZwHc/MKNhUGuBz70qVLbb1RbvPDzpz/MI1Le05AWN23rsr8Vle2AuvFRNwIvbw2c2aPBfbXdVShihq6PFIVa+ug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MiZts4lX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiZts4lX"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8520161fdb9so2907999b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787563132; x=1788167932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pbr5eP75HMWDjVi5kSReXoq3ufPagXFdRczlYd+lCws=;
        b=MiZts4lXoJkLr5HBI4HQPY7610zQ5iyr38oxrXtio882yooTVihC3CZYo859or82nk
         G0mMU52DSVGVcAAIKiSZAmF1E4ennLMXvMTp9ouo1x2Ilz0HU1pL0T7SZQGAzcZMOxi8
         VH8G39IcfEKDPR2F4CsGZKbs74ypLf0tL8LBYhAzt2e+vmF+vDrFBMvXY2kM/PdACuDn
         2Cpdh9ucuRtkG9hp5oWb/NCoL/Zns/kqcnBNV92ml5YIU55tm6aKVfIXXWuiXiWqWJJB
         jSTVr6Nn2H/V+eV/RYHBf23K6K23G3Rm4+KWGbbYAAMOb4VOGxbVf7FtmGTSTjZwKnEe
         3iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563132; x=1788167932;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pbr5eP75HMWDjVi5kSReXoq3ufPagXFdRczlYd+lCws=;
        b=VNL/JCTPmgYwpls/CVbpzt6085guHXG1AwabdxuRaonzeMvjyc4AJIJLNmQ6xjr6Yz
         wHpKBOj8mXURDl309uh5LE8jS4+g1x4Abik2efYMZanoymOkSYZtKcj8QkTViQf/xxQR
         muZ8p24yBMWNb90zJUsJ1xGU6M+IOz3VewMMykOEQw8BSJW5pQZnHgVka1FOmabkEehv
         7Bo0133S5/ZmgaJIMktTcBP0FRazRb0C16QFgucxBHQ87o5r6TagXnds4TdbNNJIOedV
         mpnVbQsg4kprieA5eC33jVMgU161NLJ0b3mVc9opYrLnpnvUPLqCJPb6dsifohRzyCc+
         2ZWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq8wQcipTnHQ4EqtLPKobkD/CNVoLxHudfbM6V453XL+gWg6N+xjWauVPsuBQ/foCLFJsEJwUSTEQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lzuOr4L6gxdC9czgrNdJG/zemGM4WfEEZW4RFfF8aCtGkuU0Ti
	J8GGzZP7P6CxArH9+dPzkUE2a+KYdplkG0IBWO1ekqugtSisyXF4xvVkLcyR2X9X7b4=
X-Gm-Gg: AR+sD13FO8xE/pRzjNy/2fJelqvMNlWTcb5mGRA/IC5gFPb0aSuvfIwIGK1MJy42Nqj
	iGz6La+rBU4WbO1zK+S4mS8I6/K6xi8mHQdijubGkobrS/4OxMyFdz+7Jea4G0y8gmnqo7eRmN+
	kTQslnG5elmqv/xnUKM1wZxbrlvxVDZElNgkBHNZNzQ7LxqR+8rL3AZ++9iJ++njwGqlkliCH1k
	XkERnEgglzRsyVAS2w/o7Vy+LvHqnEzuOY1XhFwIAtx/v5FjNJVqEvEEzhj7Ifs4YTFG2FOffAe
	x+KcT7QOZLuNkgqRaZDlQrxsUJ4tiPEDY7G0DOQypyeyzTca5JOOlqZTTs2qoqQuvlBb4rmGAc7
	Fb7apRlJKjVoJOrS79oS3qeEGQIU3OUdQ9oNyjQcttbCieNmCMa3To/s9WIKElPMZDvbUy+QBNw
	zRzXHCtAegBtsRYmK+gGP/Pz9nN9/Sm03EyRFLhpTkPfrxsizGrfUVQobKrI9ZkcIz
X-Received: by 2002:a05:6a21:9981:b0:3c4:1916:9d40 with SMTP id adf61e73a8af0-3cd2ffc1753mr40291706637.12.1787563132361;
        Mon, 24 Aug 2026 02:18:52 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f923f2c0sm36790685eec.30.2026.08.24.02.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:18:51 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:48:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	rafael@kernel.org, konradybcio@kernel.org, tglx@kernel.org,
	ulfh@kernel.org, bmasney@redhat.com, radu@rendec.net,
	abel.vesa@oss.qualcomm.com, lpieralisi@kernel.org,
	quic_tdas@quicinc.com, danila@mainlining.org, davidwronek@gmail.com,
	mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 12/13] dt-bindings: cpufreq: qcom-hw: Document SM7250
 cpufreq hardware
Message-ID: <aowMeGkWZQGmSmHx@vireshk-B250M-D3H>
References: <20260821154030.2514-1-sreeshankar0910@gmail.com>
 <20260821154030.2514-13-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821154030.2514-13-sreeshankar0910@gmail.com>

On 21-08-26, 15:40, Sreeshankar K wrote:
> Document the cpufreq hardware on the SM7250 SoC.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 98eb36bff..2dc2c265c 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -29,6 +29,7 @@ properties:
>                - qcom,sdm845-cpufreq-hw
>                - qcom,sm6115-cpufreq-hw
>                - qcom,sm6350-cpufreq-hw
> +              - qcom,sm7250-cpufreq-hw
>                - qcom,sm8150-cpufreq-hw
>            - const: qcom,cpufreq-hw

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
