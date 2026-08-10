Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB08400990;
	Mon, 10 Aug 2026 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378991; cv=none; b=pQ1+ySW4gcP+SqZuOcwj9yKIyeLdnXyjzmwhTKjdzr3bCStAQVNO9oufTgQIlSOqN0PQwrhQDNEH4bFRYlLbpC84xJqBPLixeRrq2MmiKu3yX0xXFxsRj+V9bZ5aVmMjU9Gxz3abxN9I0qYlSXmpggf07w6P0SOrfJUcZnHrmvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378991; c=relaxed/simple;
	bh=mGT8QD7jB4Wb8ZM2FeAM7BQM9tRihA4YEGKxUS6HeWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXuDDdLPkTVQNbKy8836a62p0wuceProYsIFrB7gMXK61m1IXekslsKuF7i8AYdu9PANLXfBhh7K45rZIX9F7BRmapeMo3ys5DBO2aTB672KQnswJ34ZbwT5OPrXpQIT1ycVzL8dm3Z+vrW4hrLXOlWqelYkepmOOJwidw7D3vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHhq2xZo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHhq2xZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39BE1F00A3A;
	Mon, 10 Aug 2026 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786378990;
	bh=d0AdmS0+9+fwLhJajay5Wlura89yduV8D2X5f2OXIDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RHhq2xZoUFCgUI7UI6s1aaeIvL/fRyWwpBuKEbQAzqGhkI8dafmAQ0xxrTdSEMqCp
	 kWD2mxr1W8Mc4pR8K8h4kXmRp0bBKm3PFZ527M50UAZQNSKHdNi9drPgZbFHEAcxk+
	 ZJrLjmvEfQhCUa/C05YRE2iBCdrfdZotaUZy2yCeuk8wWA5iF2wcPMwbxU0LLpRilN
	 qLpUE9gxCE7x/e7GsHkouU4AiikecyE7mpDtdgMYMZHeYdQmhflFwyGhJ99Pp1svdY
	 vGUjl6F7LvctmxArlaEstfsywjuq2svHmTp47cb3mNxtKWfQaoI11cqOw5f68F8R82
	 FwbVbCUI9YrsQ==
Date: Mon, 10 Aug 2026 18:22:58 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 12/16] power: sequencing: pcie-m2: support matching on
 remote "port" node
Message-ID: <2qwnxzyxcnwepqpmjj2bc5jgo6dgytcuz7equqm6p4hruoy7hb@7lkl7dxksxgf>
References: <20260724084328.3943997-1-wenst@chromium.org>
 <20260724084328.3943997-13-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724084328.3943997-13-wenst@chromium.org>

On Fri, Jul 24, 2026 at 04:43:21PM +0800, Chen-Yu Tsai wrote:
> A USB hub can have multiple ports, and this driver needs to
> differentiate which port is being matched to. The USB hub driver now
> associates the "port" node with the usb_port device, so here we can
> use the remote "port" node to check for a match. Then fall back to
> the remote device node for the other connection types.
> 
> Also rewrite the existing "remote == dev_of_node(dev)" with
> device_match_of_node() for consistency.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v4:
> - Dropped blank line between __free() variable declaration and
>   subsequent use of the variable in conditional
> 
> Changes since v3:
> - Drop redundant device node validity check; device_match_of_node()
>   does it internally
> 
> Changes since v2:
> - Use device_match_of_node()
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index 83fe6a1396bc..691cad0a6dd0 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -175,9 +175,16 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
>  	 * parent matches the OF node of 'dev'.
>  	 */
>  	for_each_endpoint_of_node(ctx->of_node, endpoint) {
> +		/* USB port devices are tied to the port nodes. */

I'd reword this comment to:
		/* Try the remote port node first */

With this change,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
