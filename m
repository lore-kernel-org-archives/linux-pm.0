Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E02620DE;
	Fri, 20 Mar 2026 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976001; cv=none; b=tyE/VJFhk4lVAiFJ8JDYTh2IuqttzkEVWvOKbU1ny9tqB2gHsbt7mbA9KgRQGlV/wHKDISORERi5ENFHsL1TH8S4EdDOadTAyWBNoENjVUOG2D6jx2gXALaGjTu2VVusnBfhXEHQgiWas6bX2ZyiFiICM5Co9Z9WgpNIi7ypgG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976001; c=relaxed/simple;
	bh=Qa2kKiW2K4o32w52YsMZm0rMqJtB23Cf1BU+wGQGI/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRWwqy9GwDvipGVgCUPBldqx89IwGye/EQYUNrnSaQlTpma0LOJoylvsvz1NWcBsEUa5VNlaydSYdrruRmadz/6DkTp2kScf3/mofUbMImbdkNRj1527+oqiox3vw3ULjuJg7UA8OU+kIzH/NVtSj2sxwDjyaKquXgQlbStl3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSuW0pWL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSuW0pWL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A240C19424;
	Fri, 20 Mar 2026 03:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773976001;
	bh=Qa2kKiW2K4o32w52YsMZm0rMqJtB23Cf1BU+wGQGI/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSuW0pWLO3r7l7Zja6MMNkzFI+8A1EBOKMEvtmHHOGIKOoyLKRqdZ/jQukHTWJu9b
	 Fgx/wyx68udFKnMkZVza6jDMWbJm5ftMtTdj9V9GkEpG0MglFWioFcESAS/DI6X9GM
	 mGCf2nu+ksWrxIpmWQQewDgsWAoSl6KLfWBW7fiIh0AE+ayV3Iyu7LvHIMZt981W/C
	 gtTCVNs9ZuvSPL0GldB3BIkKZDrrDyTkHZALx8IPVz8CvH8OPb8mT14PCaZMeWkQSO
	 eZMs6n6Kmb37cAfq9gU42TqtGO+315YwmgBUo/BkwwQ7KBvJySucgbldHrjtmzEWHv
	 y1hEKlj1DR/mg==
Date: Fri, 20 Mar 2026 03:06:35 +0000
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
	linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/10] workqueue / drivers: Add
 device-managed allocate workqueue
Message-ID: <aby5u_ToXifVwf6B@google.com>
References: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>

On Thu, Mar 05, 2026 at 10:45:39PM +0100, Krzysztof Kozlowski wrote:
> Merging / Dependency
> ====================
> All further patches depend on the first one, thus this probably should
> go via one tree, e.g. power supply.  The first patch might be needed for
> other trees as well, e.g. if more drivers are discovered, so the best if
> it is on dedicated branch in case it has to be shared.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[10/10] platform/chrome: cros_usbpd_logger: Simplify with devm
        commit: 168e4b208ca8c2e04de20cc6cb7e2fb035dc1ec8

Thanks!
