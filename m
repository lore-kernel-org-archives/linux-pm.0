Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794893597;
	b=ur3gwbVgCHO4gtwnAYbLgPGhC4GOXxnQ0cZ6WlOS+F8kch3Wazsc+vOlOgMrEsJ5gSiu
	 rCw+r8Lt7sYK6sGvzifWoS81KkQhhEst+leGOPH1D7SgTpXIprzKaLpjcYQRRxUsxjqNu
	 Q8qjZb9tSjguQPBoI0abFE7oIy6IqLkS/Q/ZHSkB51zM7S0sfMkCbgZGxxGCAVABsdQdy
	 BIh4FnZhhUYWZwkdoSpt7SStfmxrHeuVcANGB3RIQYZWINp3mhVXsFTG1z+rvZE0/V5gX
	 1eN2Ml4iW7/pCgoQDq4nRFu+RiWj0JTnMy6R50cNKE37pbH1Jc/1cyPHKsY/DWbBcIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Cz1YEfgAYIVyaKhtnxIgh6hL4aaxiRbKUnEOpQeT7xk=;
	b=aKihiNESmv/Nog/MGsRn46lojdCi5KmZKFnCn5gmMp6IS1d307L9GQNC1X+7yVw7cdxn
	 GLvVQ2bBShqIaJuY80JeZ4hiI+jm5beGX8MJR53XIh0aPdcAtfgQUuya4WnDQcEKmYszq
	 SXAtWJ+BEatAb9FQjWcjQ8KQUlQne8QTzSIC3PTNMF3CH5LuMAp1JrGnvhC1TEpiMXxh9
	 LeBBgtlkMarD1QHtp0UkwKaTSxDVtjP52kPkkBczLz41N1RJCsOexZFt7cZKP+AHEy5u5
	 YPMe0mGuNYRVebxYXe7oZ/UOKy1Yibi4gTXnoA+gh9FV2XLILwXjx8oC+yWrlpS7G7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AGL+KI8L;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEB606A329
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 05:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61AEB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AGL+KI8L
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b3acec6677so6221881c88.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794893595; x=1795498395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cz1YEfgAYIVyaKhtnxIgh6hL4aaxiRbKUnEOpQeT7xk=;
        b=AGL+KI8LRIwJ8cdflaNKNFX41d2JvLSAp7FK7DVGhFMM95xQ2g6hkZnMXfgy9Dk+tz
         jF/FOlGQCot53XTV7jjbVzexEd1ibyLLbiTnWYmzyGIob6wfhXry4Yrmn9Xjpx4n0mmx
         64xX9MjzM7kY4bo5/t/gzirbKWGfsp9tEyCAHOimcl08rU5Jl4uBa0Wx9mSgCrQuQqsP
         BuKV0XZjl8k+qcTtAmGxUGGvp7T/UmVu1wwVOJRLskCsA7D8hi57ogVTzIBQqTPazWwz
         2lnQjRhPrDRp+kLd+NWigdsX7LEWGmKltMB5scA64g+l8CZQH+UdN3I43rrZuJuzgNuT
         z4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794893595; x=1795498395;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cz1YEfgAYIVyaKhtnxIgh6hL4aaxiRbKUnEOpQeT7xk=;
        b=h832hH5I+zG4FdQsRlESReqqvqVYVnPnu0vhZI00/h5Jg6Z+6xXoFzS2Cnz8BKPpml
         NAa/V/guPw0gcheaLlgANB+aMsE6mpjE4QiudJXGyXf20WKpo2eXl5dA2xOR0WfskL+C
         E4z5n1phNfSvZAV4IMC0CpWYb5W/VRNJ8NLv+0awAPPLBCAEZZ8opVpGtr7+dzCqswas
         Fp4hmOIBH2RTZytH1TC99xUAF4vAgg0lScUW2/Evyr7UuNIZDxjyC8hXO+csbomnWOLE
         fDCZsYgmed9HhqIXFKGL3ZeZkQ6IiYEwMOuFr5UnpTGNFiG7PL4JuXgxYXFHBwNFoLy3
         2vJA==
X-Forwarded-Encrypted: i=1; AL+hErERy6FeYb5AcoILHmLVNFhI0t4BMde5IBERlIjMsQhwtaRDDIpmQSr1QMVsVBF2p9wz3ISHeyVUCQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/4yk/HzWXEWa7aCkrJfXfKuWD2Ed5lMN2qpgm2Ken3tkG5Blzq
	WNv8BZO41xgbnhGA3GZFlSs9o9F1emXFThklWsy/UUumwHITIqVNR9DxhUjaPNnfaQA=
X-Gm-Gg: AZFdTZdtyip1pX633bag5IOcjItoEN0udTa40WSYMFW4hIMWH3G7YXKCXE+Ad1K+sEl
	Q9jwFqRXRHHSsPYFuRa8kP2rR8j5eHrzO6FIJIzbbefASc5V6SNQiKNR1cY8rQnGdlqonLUTNdW
	5SsrR2AzK8MJZ2dwgyQMB/Xz66mI53or55mCuN6v/5RnVjvf4RiW7muXB3FtoUmQPXzx4872rdA
	7IG72B3We+6uZDp5AjJe2qSL9+/+mTjJ6jNOoAUs/LJjwsT/YJitr+KselgI7/4MzqIz/gfr8Wq
	8IVdh5xB98hXeGYEKmlkWFy5BiSiqvywqdacRZHGuuTr+mTAtnh1d2FfId2KuTixifp7wpMOWdn
	sUYxEw5S0AXaxlIRZ4IjBT+PKFK3Gft6VfwQhquHDMDMNTZ7E1XEo3FQ30SjiTfp2/H4x0pnRit
	Xb98AQYbWSUpq/eGHyXKTBESFlknRcvmaXzelwzqEPQaS3bBVbGsmx/XZubBZaxNRmt9LkJEF+K
	KaRSkR3EmeV/pH+Pd5OrU8VCzW7qg5ctmS1NVOJPjrl0LZS6o6QLRZPmobcvDUqj+NVohPgnvlR
	/i9Y4weTKpXz7LoPXooDyat+QsRaBA==
X-Received: by 2002:a05:7301:b06:b0:376:13e5:e8fe with SMTP id 5a478bee46e88-37964b08f4cmr11532201eec.3.1794893595271;
        Mon, 16 Nov 2026 21:33:15 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795533170csm40174212eec.7.2026.11.16.21.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:33:14 -0800 (PST)
Date: Tue, 17 Nov 2026 11:03:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Majid Hajiheidari <majidhhdri@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, rafael@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	abelvesa@kernel.org, mani@kernel.org, admin@mswin.me,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM6125
 compatible
Message-ID: <avvnF7zQfYhF11so@vireshk-B250M-D3H>
References: <20261115003158.391171-1-majidhhdri@gmail.com>
 <20261115003158.391171-2-majidhhdri@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115003158.391171-2-majidhhdri@gmail.com>

On 15-11-26, 01:31, Majid Hajiheidari wrote:
> Document the cpufreq-hw (OSM) block on SM6125. Like SM6115 it has two
> frequency domains with one register region each, so add it to both the
> compatible list and the two-region constraint.
> 
> Signed-off-by: Majid Hajiheidari <majidhhdri@gmail.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 98eb36bff..8dfe77d08 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -28,6 +28,7 @@ properties:
>                - qcom,sdm670-cpufreq-hw
>                - qcom,sdm845-cpufreq-hw
>                - qcom,sm6115-cpufreq-hw
> +              - qcom,sm6125-cpufreq-hw
>                - qcom,sm6350-cpufreq-hw
>                - qcom,sm8150-cpufreq-hw
>            - const: qcom,cpufreq-hw
> @@ -146,6 +147,7 @@ allOf:
>                - qcom,sdm845-cpufreq-hw
>                - qcom,sm4450-cpufreq-epss
>                - qcom,sm6115-cpufreq-hw
> +              - qcom,sm6125-cpufreq-hw
>                - qcom,sm6350-cpufreq-hw
>                - qcom,sm6375-cpufreq-epss
>      then:

I hope this can be applied independently.

Applied. Thanks.

-- 
viresh
