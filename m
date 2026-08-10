Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A09331EDD;
	Mon, 10 Aug 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378805; cv=none; b=nmctRFEAjNbSs530X5eA1uok7TA0WwKGhQBdH0ks5lfYFRNskZYw2eodvzW22SlIq+cH7GOFLKouN6VvpyfEH7zDCM7kPpRAIQfr8fuAsZ6/IZC/R5bIL39tEFcX9U4/VHbqb1+7GXAIqQx2PQN9YFpExzDqIOxOxhZXY0EKr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378805; c=relaxed/simple;
	bh=gsBZW3roLR55x3KD23eK9IBtGuPFN6cGbNRvxUGO+Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THzDC67tmkOxfBVwdHkankbYGfR47hBleHEIQCZrX4E38OtiRYWlg5XLiSvcy9xiY5AUJrUjJmTZLZcDVQZ8g2ca5Vf71c8PvIZbD9rXKPiwvHMgz/beTtuDT4stmfPbaHoi5zWKMNPTeXYSuETs9r+TnLmibg9eMpeAcn+Q6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTNv9jC/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTNv9jC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87551F000E9;
	Mon, 10 Aug 2026 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786378804;
	bh=RPOZDjm0qicPVxcdpi6ugyNcGwoCVz6o/jhlFg1DkwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cTNv9jC/aG9GpEcPuG/S5rsnSC9CG7OLShcGUUGf2DothJRSHWvCP/+upsSE3l9WG
	 f0woCzDd/0kF6hE8tAo2g7pqiAK8eukZm/KrEr66NptSJIUaJ0Rb4fwSDfYyn8HiW3
	 HGf1yCCsfDutQZ/ziT3ziWsbFK170iLWcCL9BfNfeuy+wcAcURn2mRN1yeZg9hzTGc
	 pjjz1Ip9lIEZQMpupAP2tKSo3rmBjEW7N/YIIDMV2dUIXvbQElP5QNDu1wCIQZwMeP
	 9SdjsXJFS1ErWospxII5r6xeT3+s9QIbquSzf2G/Y2uLxK0jPOyY8LApKOpWoD+QBM
	 uwclds2+gi4Uw==
Date: Mon, 10 Aug 2026 18:19:52 +0200
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
	Alan Stern <stern@rowland.harvard.edu>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v7 03/16] power: sequencing: Add pwrseq_get_state()
Message-ID: <5kvmepqjoeh4igu3q3xovgimqunz4e6z3h35gqq6p2runsab5c@an2sg7ltp4p4>
References: <20260724084328.3943997-1-wenst@chromium.org>
 <20260724084328.3943997-4-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724084328.3943997-4-wenst@chromium.org>

On Fri, Jul 24, 2026 at 04:43:12PM +0800, Chen-Yu Tsai wrote:
> The power sequencing consumer API already does power on state tracking
> internally. Expose the state to consumers through pwrseq_get_state()
> so that they don't have to reimplement it locally.
> 
> Instead of just on/off and error codes, the function can also return

'can' -> in the future? I don't see a value in adding it, but not a concern.

> "unknown" state. This is in anticipation for "uncontrollable" power
> sequencers (such as GPIOs left unconnected).
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
