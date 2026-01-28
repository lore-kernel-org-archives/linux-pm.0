Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D546265CC2;
	Wed, 28 Jan 2026 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600179; cv=none; b=Jk5mfsInttWoa6aCYZIhxm9y+/j97iWwTFjuWSjGdFB0e4aOR3PmK+BzBRudWVGoZ9pHizGM1oOZUIBie3tXbxbAijXVhlvw3wA7l6WAZy328CrBz6C0FzjFrnFgB/OYQpUDU+0Xd6I9p0sX0YUYEHHBzPbaFmAAxjEDcxaClFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600179; c=relaxed/simple;
	bh=fhoyLIZpdxyO2Qp8qlu1dbyx/l/VhIMpv75xMlAio6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fk9Hc7Fpd+DOKsOuGSI9AOHsHdRuAJ7ZrM98+xorc+vn13tTOM9xoqeBXH9VVUGtCpnjnLOc4zGy48omvb//gUM8Q2VVaGBifzAxyVHRVDdNddbS8syiWee5yQIeYrw0xtiquBl2N1aFTcVLH8XpgeeEs+Zsk3QUpj0lpDebRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBi67+Mx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBi67+Mx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5F1C16AAE;
	Wed, 28 Jan 2026 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769600178;
	bh=fhoyLIZpdxyO2Qp8qlu1dbyx/l/VhIMpv75xMlAio6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBi67+MxZqhSZv50f+G8DwtYEwyWZraAZ42iBOSigXI9bGgpY83QhQbrE+igDX5SO
	 lpDugCpwsaBc3J0FHM0lOSbEQaE7WJ5CTjiod7KxxIVA7aRmIqYtzzOPLon6VcHOE7
	 xbLY0EUCICP+NxuRUfKVWjergbZMr/mVdRHAAtaQrvigMAe2N3GAth8cFXSeatTTuB
	 8dA+0wP3wXxJElyaY6FxW7C5L5ntp8UaNqUKbf5eFK3XYhrwZ7GJxnR6kYnOETqnoL
	 p63pilYXA67RDmklB4AodLtRDZAXANkHmFJ9GBNPJVRw3NFeK95lbxR0aNWlP9dRhc
	 t9svFVM/r65ew==
Date: Wed, 28 Jan 2026 12:36:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	konradybcio@kernel.org, mani@kernel.org, casey.connolly@linaro.org, 
	amit.kucheria@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 1/8] thermal: Add Remote Proc cooling driver
Message-ID: <20260128-colorful-caracara-of-persistence-dbfaf2@quoll>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-2-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127155722.2797783-2-gaurav.kohli@oss.qualcomm.com>

On Tue, Jan 27, 2026 at 09:27:15PM +0530, Gaurav Kohli wrote:
> +	if (!name || !ops)
> +		return ERR_PTR(-EINVAL);
> +
> +	rproc_cdev = kzalloc(sizeof(*rproc_cdev), GFP_KERNEL);
> +	if (!rproc_cdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rproc_cdev->ops = ops;
> +	rproc_cdev->devdata = devdata;
> +	mutex_init(&rproc_cdev->lock);
> +
> +	char *rproc_name __free(kfree) =
> +		kasprintf(GFP_KERNEL, REMOTEPROC_PREFIX "%s", name);

Ah, you keep ignoring review and sending the same buggy code.

There is no point to spend any time here. It's also fastest way to get
your future contributions ignored or NAKed.

Well, ignoring review is obviously:
NAK

Best regards,
Krzysztof

