Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785C3EC2F7;
	Tue,  5 May 2026 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967245; cv=none; b=E3f5M49zuBh6S5ZH+pEgp7gUr+IVs6hRzrVYXfHL1N4/I3n5828G/M3+1f6AlWc1T62oxrJDOM1yDBP3JRLoAadVo71f6RMY+w0JX/SlaTOxqm7PvLEYp4JzjQr3r2HlBKaRhU7LdHioK1PVTl8O4wfVP3f/lQ4JmKYeQZ48EI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967245; c=relaxed/simple;
	bh=S5DCEpQQY8jHnHa9bPETfZ4LlRSc5EYFF7zJMZdC60o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/nXq3YlPiDxOS/Qyd7kG1K9tbmsqg/uiuTzW70cimhNrvwy/TSoN8TIrvMkt9YMMTJTVcjoKImTnsGUFUQ9wrx/tkQJU4pj5wUVu1fQY24HozrkRRVeuq5uXiBs92FV2Fj/KibmzlDPoDE+FQPYSJVqIDqaCGAaqcbiZ3lWDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXRjZ9wK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXRjZ9wK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071EFC2BCC7;
	Tue,  5 May 2026 07:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777967244;
	bh=S5DCEpQQY8jHnHa9bPETfZ4LlRSc5EYFF7zJMZdC60o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXRjZ9wKq8FW+m4saZFFHPCkzkRXD0W82R3NUAg2nXNsgi3pJ6ft7PsmGYQEY29zH
	 Uts0rRmHQGjmoz92cR+rzp/7ezfCtqk+CRn6v1//TlUokQBiDHsJWC7qsHJ4iibXI9
	 oJngVM45zMfy0jBC0i0Mea0+hD/WVrZ/p8sS9L1vBZQIjrnNOWNYOoMVkbxA0vhtaZ
	 sBEYNOlK+zC2/uZkKeLr44tbhYYktXZplafoHKLK+KYgXG4JfAzr/xsqzy9sAMPAzK
	 nbuMw4gwWn6FG6JQmlXrVa0rPHeY8peRrqrSbZIlS+gMuXTUsX6Jdo+yQB2mbtNEvk
	 2Rvp2uos91Blw==
Date: Tue, 5 May 2026 09:47:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: thermal: qcom-tsens: Document Nord
 Temperature Sensor
Message-ID: <20260505-magenta-dog-of-cleaning-640cfd@quoll>
References: <20260504081236.825755-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504081236.825755-1-shengchao.guo@oss.qualcomm.com>

On Mon, May 04, 2026 at 04:12:36PM +0800, Shawn Guo wrote:
> From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> 
> Document Temperature Sensor (TSENS) on Qualcomm Nord SoC.
> 
> Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
> Changes in v3:
>  - Improve commit log to drop "compatible with" part
>  - Link to v2: https://lore.kernel.org/all/20260427012511.231475-1-shengchao.guo@oss.qualcomm.com/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

