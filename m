Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8F39DBCC;
	Thu, 13 Aug 2026 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613846; cv=none; b=PK9enndoU2qupaPBBo7hHqKHPK3/9CUEMNT0T1KjsTwNYWnVYS9PypTdwA0b07EUgkn7DMR6LV6BVf1n9rcAdgU3I/0CX9LvfIWPcmiuGcomrmD39nAu6DEGV9U1Ff6ENouFu392UQqsoQ014UdCSf3Bmcqu+crIycE7YUf5R9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613846; c=relaxed/simple;
	bh=Y983/vUjLnT/Geu47yOe4dghI0QmpN21wea/H9nhjYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8hJtxqkC5SjKEYdlJ7LvL4nr9eUHZDsGgS1HpCnBQubj6AezhMMvcwODV6fAkU7+7vECbgwFd8iYdmFnieGtVHeAdkArNEG8RJ4QaiKRrykkb1dM3hYZzOKlfORVxkWw8ZkBzTyEY1HwTaVpumDBE5Ha8Pt8DwgscIM2iOmb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjEHGm0A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjEHGm0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C6C1F000E9;
	Thu, 13 Aug 2026 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786613840;
	bh=H/cpt1sYJ9/YPI2KghdrxKaidPsEpYxg9gXSISxQD1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PjEHGm0AmHrE+bmijZLgjodBmPbIcIutlhpRV0D4bvICXoKYExqXIBeMdZtZxWnx6
	 jWJWkjYESOFKDcTivj+Ehj7w1QL8xPNBCSvSD2lvtHlW7oS4uYh+C8fYEjiGDTVv+L
	 jpSy7nNTexf8M4BSl/dnbToemHJ0x5vAVfhtVsue4Ax10YHgijr6lR2K63qxt5l9io
	 KPLSpiJA7ehqqQUgeo9tCJiSYOmjQYtjQQzTUzotxQYYT94AabhPWuipREJAs5BGJu
	 t9Ne/mTElVy5hqZgpFFKsZLPQrC9Dh3LAcpQN2cqKgMewA2jazNbeQfgVCZMnsploz
	 RREJp08qscn1Q==
Date: Thu, 13 Aug 2026 11:37:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 08/15] dt-bindings: pinctrl: qcom: Add Kuno TLMM
Message-ID: <20260813-warm-whale-of-tranquility-eb2179@quoll>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-8-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809-kuno-soc-support-v1-8-5e0ede4a0c72@oss.qualcomm.com>

On Sun, Aug 09, 2026 at 12:57:07PM +0530, Hardeep Sharma wrote:
> Add device tree bindings for the Top Level Mode Multiplexer (TLMM) pin
> controller block found on the Qualcomm Kuno platform.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  .../bindings/pinctrl/qcom,kuno-tlmm.yaml           | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

