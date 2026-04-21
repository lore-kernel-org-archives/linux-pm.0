Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2FF2FB0A3;
	Tue, 21 Apr 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792176; cv=none; b=MnyFirV9wuS3kG63mDMLA89lk/DyE9sVMI2kLRL7UClXVShSbj4ltHIy/jpeQ7nG7e6DQ3G/oFb8/QCGTXVC3ApqPb9fQN+yup6RyjqFs4LE6vgCwSPi3penXZAIUYwnJstKol/+KRV9c1XTfIa+dW3sB8m6c0v59jkBScMJB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792176; c=relaxed/simple;
	bh=gQIFGSllr3HF979eM4o9wi7yge80fgwAZ1EYfsGaHrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMTaCbB8WPih7nT+pVVa0OBgI1RzltV9/zLKakDJBhaE7800dOxsdFEkW6MXleO96JRPN9EZSPLaLnPC7JAn8oU25vb2UkLn7SAJblZl48qX4jCVwep5BzzlWuInF0hfw8d/RVY74NOGCWjKHR9AbQ6DpU81rLsLvPkEfiNW1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO36nZU1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO36nZU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D202FC2BCB0;
	Tue, 21 Apr 2026 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776792176;
	bh=gQIFGSllr3HF979eM4o9wi7yge80fgwAZ1EYfsGaHrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aO36nZU1c3Scvjq+XSiUDZLQc8ER9bpuFDwCS4dhdVhdNa1XeKoUiWj3UCr9okM4U
	 +LlYv4nW9gRDmqt6t/ovpR2s5z9Ewk2sGOucPR9tMAANBxEpNMMXS6TTQfeVDvsZAG
	 ueDSGYbIoMRbr4NOwtgeeyYd6wggfgLx8InAq3M/A1Lw1ogDdpsyYLzZPXx3sDwvDT
	 IYpR34sAqKYttT3CfRG+F8RLVWPyTk4j72org02ssqGUfU3Fc1soWXbIKBw60+46Vn
	 obFruHGkgkwF5t2z95ksL4D3VCNo/hEV317hzKkJdikT3cPmajiJWvv/lXvLyttizS
	 BPjSU/jXCwj0w==
Date: Tue, 21 Apr 2026 12:22:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Taniya Das <taniya.das@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: power: qcom,rpmhpd: Add RPMh power
 domain for Nord SoC
Message-ID: <177679217336.1338438.15268622840948659658.robh@kernel.org>
References: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
 <20260414035909.652992-3-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414035909.652992-3-shengchao.guo@oss.qualcomm.com>


On Tue, 14 Apr 2026 11:59:08 +0800, Shawn Guo wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Document the RPMh power domain for Nord SoC, and add definitions for
> the new power domains present on Nord SoC.
> 
>  - RPMHPD_NSP3: power domain for the 4th NSP subsystem
>  - RPMHPD_GFX1: power domain for the 2nd GFX subsystem
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  include/dt-bindings/power/qcom,rpmhpd.h                 | 2 ++
>  2 files changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

