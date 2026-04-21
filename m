Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2582FB0A3;
	Tue, 21 Apr 2026 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792157; cv=none; b=mvv3fHve7YQpN+vX5VL7TVyfhM9MAht7W3+4j6F7XjFabQ67842GaW4QaS34oaQsYdhvAIiM1UMiCZOCvkate5VPiDN9uzbY6H5QYjSLvhIwdmDd5IOiGgBT+4sMQPFp+OYIjzgeupz9uAfjsJY9gUjAOR2MZUkfqPMzPsVBT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792157; c=relaxed/simple;
	bh=3Vs6A64Z/cDlXVKcYXu50l5AsAhPt9hHRpJl6Q5QeDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwFmiBkwE58GyJAuWHjvnkHGuLrlh+WhbNYq3+l+nSETl/fWbjP1LI/6C4DyTIa6256oxx1M16oReudFspL8j6p2ouSzjo75nHh1BSO7woyukfmduRGG28eO5In3VyHHUOen9EbLxP4F+mqS4OFV0PU+tfocxmhO3WUmWkR6TsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUbVsx0J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUbVsx0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1E5C2BCB0;
	Tue, 21 Apr 2026 17:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776792157;
	bh=3Vs6A64Z/cDlXVKcYXu50l5AsAhPt9hHRpJl6Q5QeDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUbVsx0JZYXdZIPnb4GcWVt5grZUZ90U/44RRRqtVC6RKcwfR5ET+ZRLDrSeStWCe
	 YaT9WmEjq0sbNhZGXyBPaFmApEtpdloJOmfbiwi3PuJ0zktT1oGQgE0HalyIV285Hm
	 46mjd0YYuNXuKLFHtuu333vEk2uqsrOqUaW7UNSX8ou9wgV0iv+dC3i+01ivQF4EI7
	 UjUJRQrnPTIO61LDHFnHzAcDRRE1j+ZErt6Xh+PYoqxbRTGqrnXsO+GFz+6/ZdDZ3z
	 wbhPy/ZkMqeeLQaOfRgD/UgYxZBzBoyh3N7Gt1q0Mqotxi7ZeFyId21lkIcorqpUxE
	 XXVDYhGI3gSFg==
Date: Tue, 21 Apr 2026 12:22:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: power: qcom,rpmhpd: Fix whitespace in
 RPMHPD defines
Message-ID: <177679215038.1337457.8627312083472225787.robh@kernel.org>
References: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
 <20260414035909.652992-2-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414035909.652992-2-shengchao.guo@oss.qualcomm.com>


On Tue, 14 Apr 2026 11:59:07 +0800, Shawn Guo wrote:
> Some RPMHPD_* defines in the Generic RPMH Power Domain Indexes section
> were using spaces instead of tabs for alignment. Fix them to be
> consistent with the rest of the file.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  include/dt-bindings/power/qcom,rpmhpd.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

