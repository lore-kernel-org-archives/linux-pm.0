Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB23ECBD5;
	Tue, 10 Mar 2026 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134356; cv=none; b=lmoacRzA2CkP1CCsy0XkXajFtdVC7dM4gRYlP+IcU4xojzJ/WpbrCrIrsfiwS9zKTcUmqwP6HDSEkRgLkk129DO/d8GfdMjlUAMDsmzbpXvcRYaxp4U96Wkv1yS/D+Yh295AykU/A/iLiBw9ZRUelVvpRz80C9BX/aPyaCxb5hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134356; c=relaxed/simple;
	bh=MdGM23490cqwr2/sVTI1UyMMRt8MzyxBUeK645TbW84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRoDSZ24ii8cSDcZb5h4Av5wGEwYHo3Gjrlv0YuJBkKBi4jnXyZTVEUzyjPckNiU0hWj2GxepGOUswyiZGhQJ971Y6lurbeBcsjTzXg4iA9MLJkBppmkfh9lXe0Wkd5155zarrPv2OPV89mBIQZ8EdzbqWBHBEW1EolSPJpq3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI4X5lgJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI4X5lgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10355C19423;
	Tue, 10 Mar 2026 09:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773134355;
	bh=MdGM23490cqwr2/sVTI1UyMMRt8MzyxBUeK645TbW84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nI4X5lgJD+ZMqfSPdJitPsghjQWL7MRXycU3UFIhEjLS7y6A8pB4gylEG5KtaLJYl
	 RZG6/eEQX9bE8cH8zQ0mXdC5YjKVfACbhoHNP5SzDVpJ/HsQsHkEY/Nrz5p9JqOCoe
	 V1BDC2Va0wPuvGEd79XCQUCg54McGizNLAUBbG2/mI0hpy+W1rbQWCwSay8bhOvux0
	 4nJWkgfMtBdJg4QDgX8E0P6KCfmrLAGkF0CPICDOB+Sanudy9KR7JOUDI4wk7XrXDH
	 CVEVSmFpzSsgzhFwT4rcKXJAEP18FlXsEp0TkEO8efISnDzQKuy6eNveqW97qCzOeq
	 uNukP/XEKzZzw==
Date: Tue, 10 Mar 2026 09:19:06 +0000
From: Lee Jones <lee@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
	lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
	amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
	subbaraman.narayanamurthy@oss.qualcomm.com,
	david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
	kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
	lukasz.luba@arm.com, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
	neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH V11 2/4] dt-bindings: iio: adc: Add support for QCOM
 PMIC5 Gen3 ADC
Message-ID: <20260310091906.GD183676@google.com>
References: <20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com>
 <20260209105438.596339-3-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260209105438.596339-3-jishnu.prakash@oss.qualcomm.com>

On Mon, 09 Feb 2026, Jishnu Prakash wrote:

> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
> 
> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
> going through PBS(Programmable Boot Sequence) firmware through a single
> register interface. This interface is implemented on SDAM (Shared
> Direct Access Memory) peripherals on the master PMIC PMK8550 rather
> than a dedicated ADC peripheral.
> 
> Add documentation for PMIC5 Gen3 ADC and update SPMI PMIC bindings to
> allow ADC5 Gen3 as adc@ subnode.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

For the MFD change:

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
