Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE83955E8;
	Thu, 13 Aug 2026 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611255; cv=none; b=Y95v8wVGQTmJQngyXqMGhsfJYq4qDpHSLDKztIXyVz8CNSknAQoNOHM9E1Mq9k0cBFRVekAVo4U00zHI3qFJK8kwcXyFzCLn3GCC2i14MGQDZQUZxSzyjMvWl4HhCUwMiRY5wg/9uv9R2oVYm++yVeFxy1BbdT266Xj0M9UkIBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611255; c=relaxed/simple;
	bh=ya7+gkMSCtIE0DuOHJ+7IIxcGMBtBW1vI2vxcmT3O6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9bt3jfdMKqVj4GHUkG65QF5B98/xE4d7x85HaY6dYr3v/onpKKXxq3/4ae9kg6Bv8sliRyNL/cxUAdIMQbddZNc3f+kZ33RE8m/n37s3DGrUtUsFoKGOGsnWXQ7W+xHaMqQ9bl18FG5Jd+UPP25GWik0qaqL9gh+ascCWoMuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdDGGliG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdDGGliG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0073F1F00A3A;
	Thu, 13 Aug 2026 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786611254;
	bh=I1MNXpPx0FgeCJXMj+UI/UAtsN5uIJXp6y3+35rpExk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LdDGGliGWac/IfmV9OJJNtwWI5dnnbJWAstzCfTp7XfOhNXKTAWwr2X2Mz1HNlKtp
	 kny4vthYjJ+ZMntSTyWZCcGPeKca6mD7wr4JGCPYpBIu7jz5AxY6UeH4EcmPRSzYbC
	 fGg1E9k/2B8s6nR54J6mH7iERcYln8iM7eQNcNLQnxoEepi015sNoJBDwUBFbtVMdr
	 fkVrmvmDDYiQxzlP6/nkl0snqH9lInMgp+hxdspTV1+2tQuvgtO+EP+V6TtvbO4mLM
	 QaX5lJwTcq1yemLZl3Zl9eZk3RANVSqOaXrGoEoWxnCAS24JMNaKaK5vYaqcE53081
	 2K5AyjYdGLxaw==
Date: Thu, 13 Aug 2026 10:54:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robin Snyders <robin@snyders.xyz>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>
Subject: Re: [PATCH v2 2/2] power: supply: qcom_smbx: add SMB5 support
Message-ID: <20260813-granite-pronghorn-of-gaiety-d27f65@quoll>
References: <20260812-submit-qcom-smbx-send-v1-v2-0-f504b8f9bfad@snyders.xyz>
 <20260812-submit-qcom-smbx-send-v1-v2-2-f504b8f9bfad@snyders.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812-submit-qcom-smbx-send-v1-v2-2-f504b8f9bfad@snyders.xyz>

On Wed, Aug 12, 2026 at 01:57:00AM +0200, Robin Snyders wrote:
> +	if (chip->gen == SMB5) {
> +		rc = regmap_update_bits(chip->regmap,
> +					chip->base + CHARGING_ENABLE_CMD,
> +					CHARGING_ENABLE_CMD_BIT,
> +					CHARGING_ENABLE_CMD_BIT);
> +		if (rc < 0)
> +			return dev_err_probe(chip->dev, rc,
> +					     "could not enable charging\n");
> +
> +		rc = regmap_update_bits(chip->regmap,
> +					chip->base + USBIN_CMD_IL,
> +					USBIN_SUSPEND_BIT, 0);
> +		if (rc < 0)
> +			return dev_err_probe(chip->dev, rc,
> +					     "could not enable USB input\n");
> +
> +		devm_remove_action(chip->dev, smb_restore_charge_state, chip);
> +	}
>  
>  	platform_set_drvdata(pdev, chip);
> +	WRITE_ONCE(chip->probe_complete, true);

No, please do not invent custom probe ordering/synchronization patterns.

If you need this, it means either core is broken or your driver has
issues. In both cases the source must be fixed, not through custom
one-driver solution.

>  
>  	/* Initialise charger state */
>  	schedule_delayed_work(&chip->status_change_work, 0);
> @@ -1095,8 +1543,10 @@ static int smb_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id smb_match_id_table[] = {
> -	{ .compatible = "qcom,pmi8998-charger", .data = "pmi8998" },
> -	{ .compatible = "qcom,pm660-charger", .data = "pm660" },
> +	{ .compatible = "qcom,pmi8998-charger", .data = &pmi8998_match_data },
> +	{ .compatible = "qcom,pm660-charger", .data = &pm660_match_data },
> +	{ .compatible = "qcom,pm7250b-charger", .data = &pm7250b_match_data },

Your bindings commit msg claims this is fully compatible with pm8150b,
so above is confusing. Is one superset of another? Then it should be
explained in commit msg of the binding.

> +	{ .compatible = "qcom,pm8150b-charger", .data = &pm8150b_match_data },
>  	{ /* sentinal */ }
>  };
>  MODULE_DEVICE_TABLE(of, smb_match_id_table);
> @@ -1112,5 +1562,5 @@ static struct platform_driver qcom_spmi_smb = {
>  module_platform_driver(qcom_spmi_smb);
>  
>  MODULE_AUTHOR("Casey Connolly <casey.connolly@linaro.org>");
> -MODULE_DESCRIPTION("Qualcomm SMB2 Charger Driver");
> +MODULE_DESCRIPTION("Qualcomm SMB2 and SMB5 Charger Driver");
>  MODULE_LICENSE("GPL");
> 
> -- 
> 2.54.0
> 
> 
