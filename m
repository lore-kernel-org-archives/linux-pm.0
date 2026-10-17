Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0063AFB07;
	Sat, 17 Oct 2026 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255558; cv=none; b=gxKk4MhsfHpLvh97toZ8w7Xg1WMuyqjuz2dSIhnWIoNqZqHfEbimz9TRqI1ebx37dRjoSXy10NCzuDvWYItrlV24aZECiswZ3PQOPKHT+tnlRVf4Fl7Y/n7SbS1JZmzehk2c2s8M8vL5iglkiljFp7UH4VWPNBv3A+G7MbnYSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255558; c=relaxed/simple;
	bh=Mjlqhejdm5FrIoQnX4RxPMoWRM+ithZztKzW6RzU6YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOybA4f7884JaDVMNdwCfKFRLaF5DQGAkVO595YL4ZaT4/CkhsurKTOvrnD2p9eU+VAriPJVIdaxTM5x3h8RvgCkFynT8dtP+y56dOlF4aFC7DGeBKwQYilZ9VFvvtK0pxI8kWf18dSLnlxQSdLqaGRY7hJqfKRYebV2EDc2zko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0CXq2ao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0CXq2ao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFF21F000C5;
	Sat, 17 Oct 2026 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792255557;
	bh=Mjlqhejdm5FrIoQnX4RxPMoWRM+ithZztKzW6RzU6YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F0CXq2ao5qFmoPcNyzSoEHf/bicGi+RHQM3oVStbqWXJM/q/Hhdg8MtapXqAEYF5B
	 C8/8qmu/CnD+69f+tOCC88Lk7wST3vd1KeSalwReMCM/wNmRAPJQQCUqm/PkhtiWW1
	 qh2DF7zA41EYaM3wVw+mmPf9H6BLG6I5V4RM0IAaoxaJuzPrGcK1lkTe2MurkcztPY
	 7v8w9ZEz9j8RvTnES4PHgQYMmVBptj2GnrkHOS4PnTbe41ikkeIkResNNxA9Tao+Nm
	 7Mwor6cDaha4+CSA6W3AROYcRNltzW/DYwFa/Wklx+fV4yz0ijEekbhUkRkEUseiuj
	 hdd0pIW6g2rdQ==
Date: Sat, 17 Oct 2026 18:45:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-nvmem: Allow generic OPP
 tables
Message-ID: <20261017-calm-tangerine-marmot-2e8bfc@quoll>
References: <20261015-opp-v1-1-f18fb6f9bae1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-opp-v1-1-f18fb6f9bae1@oss.qualcomm.com>

On Thu, Oct 15, 2026 at 04:25:28PM +0530, Varadarajan Narayanan wrote:
> The OPP table node-name pattern also matches peripheral OPP tables on
> supported SoCs. However, it only handles Qualcomm CPU and level OPP
> compatibles, causing unevaluatedProperties errors for generic
> operating-points-v2 tables.

But the select should not select them. How can I reproduce the issue?

Best regards,
Krzysztof

