Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F23CBE6E;
	Sat, 11 Jul 2026 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788051; cv=none; b=YAiwMd0CUOQPw3SCPZQ6yTgvogGYjUjFsc7NhrKPb0n41jRSDq+OnpUwd0ljK/tRNAnKVWQftwZx612+q+Y4Oxex8Bn/G7BM2/dMkRFT37EMYtMl3XHsh9fbYcM25Iu/VxCbz29O8tqw7eosBFBMCErn6v5j+rM6v26f0rQs27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788051; c=relaxed/simple;
	bh=KtPshX9G9ZZQeHqyymbVjRXdMrWL0vFAzZUOHIyWLL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hegeakUXtCh03+iX7/Vp+nc7yjC0h7T5J//gmQ1QuB9MTa46grjdIEU3uMoHv/Z74GcUKu8KdUEUno/E9bnM22/vq6fF2/oKeoxkINQixBLSsomveRT4wJTywRnZskoy6b5/QPsxpC7kKKi21jmJMCPAYbm/uFrhYWdlWJynh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTKhlx7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTKhlx7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29C11F000E9;
	Sat, 11 Jul 2026 16:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783788050;
	bh=CQX698hxn3C0qIZ9h+t7i/by2l02GA/EGgvpb0ocGFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XTKhlx7Ibk5O9aoBEMG47TEDPcWhPRYN7ttEf+azuSgyXgiyMszDO9+tAEcK6Dbgs
	 x+GVA81Ba0JZqiitNLoZviS1aDe5aD4rM5sbEgyW8wILl/+cHId4bCc0uhM+Im4qA1
	 vG6v5sVNcPE15cj34Kc9tkDSTjoBM3Pgd1kIp+2eL090/8eQoe80sgmSfI8R+gVkMf
	 /mBOhatCxh274YsDh3SvSJlHzTPjljgdcERIBOScsEn0b6h+wyaIAoWIF+VUq9qg8H
	 I4YS9JpJKDpXSgaT9d8dRoYjOGr1ooIxHUKQgohAmUVJwiVMYzDg7ed9rTkhwP+PA0
	 BIVTLRxMNGc1w==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/5] soc: qcom: Kconfig improvements
Date: Sat, 11 Jul 2026 11:40:37 -0500
Message-ID: <178378800460.138068.14941627413672684925.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711-qcom-soc-kconfig-v2-0-4a907e064281@oss.qualcomm.com>
References: <20260711-qcom-soc-kconfig-v2-0-4a907e064281@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 11 Jul 2026 15:25:00 +0200, Krzysztof Kozlowski wrote:
> Merging
> =======
> Defconfig change (last commit) depends on earlier changes, thus that
> patch could wait a cycle.
> Alternatively, everything through Qualcomm SoC tree, but then please
> keep these on a dedicated branch in case defconfig has to be shared
> with soc tree to avoid conflicts.
> 
> [...]

Applied, thanks!

[1/5] soc: qcom: Hide all drivers behind selectable menu
      commit: f2866e6a27f7cc26111ce195ddf00d4050bb27e5
[2/5] soc: qcom: Restrict drivers per ARM/ARM64
      commit: e10b198a94c66f7105dbd535f66631c96579c903
[3/5] soc: qcom: Make important drivers default
      commit: 9b3daac1d0eed2564e49a08636e5044c0bfac0b1
[4/5] soc: qcom: Avoid SCM and SPM for cpuidle drivers
      commit: f6540105e0aaf6c1d3fec6070217f199bdc351f7
[5/5] ARM: defconfig: qcom: Drop Qualcomm SoC drivers with defaults
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
