Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7A3D6674;
	Wed, 21 Jan 2026 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025375; cv=none; b=X1PABjCf0mSFs7UUkfXv/+0P7ETGiCIY+K1n37PWLAHDftJjFUoZ7xkRC9Prkh/S/6EId445XCtPe+olRJ28ew4bgL/AI7q8UrXnihUyCvw9IcWGQ1BeF7A+YaKUHaQfEL62yIKgYHmPn590lJdBpHUKKQGe9n/gd45ezpfBXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025375; c=relaxed/simple;
	bh=+eoT0DvGiy3aMT43uk6Z0GRBp7AQPYiypxmsgTjnD4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsKqINdEySv9PJnk/JfMzOIpkVLlwbLWGbcF5NyNiQ+pO74f/9Lu+ksnhEHUITW4f7w/EetpCK6Wv4d518hEbf0weRg9gXwC4NL01Lm9OfmF7P1FgXkEgE4fnK115VcJvae1aGynmtN5dVJTqQNt628KIhJ/ebHNC7ufhMnYc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d88E2XIU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d88E2XIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AB0C4CEF1;
	Wed, 21 Jan 2026 19:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025375;
	bh=+eoT0DvGiy3aMT43uk6Z0GRBp7AQPYiypxmsgTjnD4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d88E2XIUfac0Bku8JgqbmqIahrqHDsNKZ+nmRD6e5kofE7Q79kt0m2feDLJQg+UPk
	 vEdA/ChgZkk52+I1bUo0rG9LDHcH6HtUl6wXGhFy8WmtPoGPLW6luzQhmy3tOb7/t5
	 kaWTkBoR4IMiD5btFFuaNpOwoMEas0woLuYEpmVZfi1Rm5Cez2FvgrJF/arxC2y32H
	 TM0fxQqkAYycX5+3KsjMbpeRS+sLcaCgWImOrwrvY9hUiM+aVwkgqNt1g+cmlM7Ofs
	 3bNjnQvNn9z6aYAZUacFOghVAVTrwYU4N0vXLpI2NKK/lXAw/OuFb6BsAzxWYysRNm
	 pdP1EUBdElX/w==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] pmdomain: qcom: sort out RPM power domain indices
Date: Wed, 21 Jan 2026 13:56:05 -0600
Message-ID: <176902536621.1171053.2577606405963713549.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
References: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 11 Dec 2025 03:52:51 +0200, Dmitry Baryshkov wrote:
> - Switch platforms to using bindings for RPM power domains controller
>   where compatible
> 
> - Drop now-unused binding indices for RPM platforms.
> 
> Two last patch depend on first two patches and either should be merged
> through the same tee, should be merged with the help of the immutable
> branch or just merged in the next release.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: dts: switch to RPMPD_* indices
      commit: 16860aee5003dc63f788f6f2999d657da991bd58

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
