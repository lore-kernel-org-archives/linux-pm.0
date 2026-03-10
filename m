Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73713AE191;
	Tue, 10 Mar 2026 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113181; cv=none; b=iVCUkrGyQa3/S1yf9NR3idFv2BXvsqKYES1tKhNOjrXJMU7C/Zld09GgYgHGZq86JIhnkDEN8B8I0qTkC4+O/mirKVJdgwPaqjRtMNLTzTvwXG1Mk4th/LGwlOXOgFXwyiux2lupfCPY263whuh1Fg070s+t/l8XHU8TTCcWL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113181; c=relaxed/simple;
	bh=CGUraFSadO6xwK8hyPzW2nYZizEbPRWyDuSeFqHRTi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noORVqIFLpl1/xleDTGFDa57LPvRZX5iUA6Qh572SkiQZ0Zt6/+WPk1n+3UgOBdVdH34MAKPscFtRr+1fsh7WCudZ0l6tAgomJMuUPXZtIw8jwbm1fKRuc50WvtkYmuzI4JZbNpRnm0/LPERNdpvZQRCnuZv3DmQeQk15/aNFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9f+oybQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9f+oybQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FEAC4CEF7;
	Tue, 10 Mar 2026 03:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773113180;
	bh=CGUraFSadO6xwK8hyPzW2nYZizEbPRWyDuSeFqHRTi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9f+oybQ39xBTyHNnSSDheYXZsp8GFVDPYcsxsfvYUkmJAY3jmrxUmGkMAnGRLmxj
	 F4emLXKKU0sgpNy+zSHKXDvyMmmZJ0KtYP84ceCrFU+85OMgjmCk1WgZEcwm4/cjSS
	 XaumY3JY1DVAPL9VGuQZa8IAPP/U8OoqtKDmN9C2OE3HqhQQEwP1KQjqiMnHUWakRA
	 y7NrWrWv4CfaDy/cUAcqt/D8DsRdRw40FvVXSKkH3lPuBPUsWg+2eKatLJrZZn/UNs
	 QsGtZ3DQCc2xcAC/DWLQ62n6e3OcJl3FPKPFoawsV147xwy1ba8qrStY6iNDV2eEhp
	 +UJ1MboPrYxHg==
Date: Tue, 10 Mar 2026 03:26:14 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Tobias Schrammm <t.schramm@manjaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 10/10] platform/chrome: cros_usbpd_logger: Simplify
 with devm
Message-ID: <aa-PViGyA2CTVxHv@google.com>
References: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
 <20260305-workqueue-devm-v2-10-66a38741c652@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-workqueue-devm-v2-10-66a38741c652@oss.qualcomm.com>

On Thu, Mar 05, 2026 at 10:45:49PM +0100, Krzysztof Kozlowski wrote:
> Simplify the driver by using devm interfaces, which allow to drop
> probe() error paths and the remove() callback.
> 
> Change is not equivalent in the workqueue itself: use non-legacy API
> which does not set (__WQ_LEGACY | WQ_MEM_RECLAIM).  The workqueue is
> used to update logs, thus there is no point to run it for memory
> reclaim.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
