Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E3253B73;
	Wed,  6 May 2026 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778035823; cv=none; b=jlSt1bp1G8PcO2DZSeByiCRpJskFrquTCi6TYphuWv9ylSslFcb/WdUixloC4hMg8lgdcspZVTy0THDaAljd3xyznVN9bYr6XQD61rPIFxZjUPaTjo646ClNTKL7ppKyY+1aeUDwIUN06hiVzsmBov/FGOaPrMo/XoOWPmlZ+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778035823; c=relaxed/simple;
	bh=kVEEx9O0ENsEOII1fvf3wtaDnOxQI6FjpuFBQC05fYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuM6HkASFFcCy3NnH5Sj6boaFTRgx2DyydIf0VF0hGM5jAu5xnkfHa+4tyh7x4ofzPLkz+UJort37HtEJBQ9TRdEFl/22LE3NAZ/vXJ6I10Lun6TaWEht+5bKuyw2R8P2Epc8b7ds94Tt8HR3Y/4UMVi3sD/Whha/2jolvUCKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyd/V2gr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lyd/V2gr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B1DC2BCB4;
	Wed,  6 May 2026 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778035822;
	bh=kVEEx9O0ENsEOII1fvf3wtaDnOxQI6FjpuFBQC05fYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lyd/V2grP7v4Hbmy3Lxrf6P819ZJWmaWqtjmxA7RLmsorJhkiShCePL+0OWhFpyOb
	 Sdv8r5xT7xeT8vQGl/PpXerDUr//QnQJk0hNNo6W6+fhhXcaCLbTgekb8XkoCDsD8l
	 52SJmeVGk2awbRnGr6iQZqSCDq0hiktYh54VNXvL+c9o42dXZgAXOXWy2QDElzQPmY
	 2839+qcWnorhPlVIioP3TuqEiLWjzQvovTQc5fErFWqvcjNim0yEpe6CYYusb1jc9P
	 8rcehbzmSXbELvo9KkXrpGX1urP2+RMQ8GWlwFdsRsTJr8JcuafSFOvPpOZfOxuq3q
	 GfGGBIrv9tDPg==
Date: Wed, 6 May 2026 02:50:19 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>, chrome-platform@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: cros_charge-control: Move
 MODULE_DEVICE_TABLE next to the table itself
Message-ID: <afqsaxBA6AzcV_bK@google.com>
References: <20260505102752.182089-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505102752.182089-2-krzysztof.kozlowski@oss.qualcomm.com>

On Tue, May 05, 2026 at 12:27:52PM +0200, Krzysztof Kozlowski wrote:
> By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
> exports, because this is easier to read and verify.  It also makes more
> sense since #ifdef for ACPI or OF could hide both of them.
> 
> Most of the privers already have this correctly placed, so adjust
              ^ d

> the missing ones.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
