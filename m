Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000583;
	b=u9gJBwsIU5oYUqlWSgAEIQiBBsSa0SLvZAhSxSi31BfDlXbzEtmMgfiFg1bCdHvHI5q0
	 WJ9HYXLpaOiqeI/t7H2FWfc1E8ZScTCMiamujyn8Yd8QfHsIvMp0MYwaid4yM6YOLmfMG
	 UmcRn6Vd1X8YF+x3ayE+OklsKAfMsPVjk2eAhA1/by6RVOq1wDhtfq7AFSNr3chdz+7T0
	 cgEJLwDzBudgkzuU+AjVZ72HOzl3YeF/gNvYgyePPYB+9NJxUqv8YbSEkiPEu6flEdnQw
	 SDoB3KsXquAtXtxAC6+EKSrTVBG4zXyEPPKmPp78vKfoKeQ5qYW60LjSAv4Ja4BeKrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000583;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CqdwfM5CSlFvy5/OhILqWGW0aw+xBkJteTQDyeaLuTo=;
	b=xpl9aFpwwjq/xyIlCGUyJEOW1QtXQS6xLoWtFSr4+QCovmG9itRLclmAJZsX5r+Xo5pb
	 A4a8rVxgH49jC6Wtl6aeTDTMq7f3s4aucjicveCS+S/pdAUmvjaFjjMRywqcd604Id86E
	 yibmyZzaGqyral7OaA784kcrrldggTGWRXko9toItF3pOT6GWvehWiXSlcxHN/5v7kNGE
	 jmoO8GVqtw0U1U2hFBpT54TsFo0FL6UnAVC2V6XaGFVQZBK+tvcCFdsQMtLTbnJsOBp4f
	 Sy5AxbF4Z8fubjUgihhEf+6Y7Lr2qpXONwZzZlToQLkTihEPHyAKA0bj1MCaXnvKzeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQQVZ2lY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA42606A326;
	Fri,  6 Nov 2026 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQQVZ2lY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D0D1F0089F;
	Fri,  6 Nov 2026 21:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794000582;
	bh=CqdwfM5CSlFvy5/OhILqWGW0aw+xBkJteTQDyeaLuTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fQQVZ2lYiYZlDEu10qX9/c4r1gv2Fx38R3aKVCKS3cq2j8lzuGUVGcpdjaZLpqUjh
	 FUUhtYmCqq3PotRU+CnYhHnKpgHw1i/YAIZTBjId7ge4sEczylffu9L7Awjz2aA51V
	 BboQUsiAICQQm/sLcKwIvstXgJKL1yTf610E/sAOjW+Lb1wa44Bq7Keav+lZSh7toF
	 EfDDMQYbKYpCwgIvRIt+I3egt9sLyNoUz8oYc6FrYF9C1CRyP9w3xGSUnSDXED4v+j
	 tX4tPilIQvgoU9A3tDYwZGLpDvQu69saj8gsRUYbopCwx9co9zq/hCxs1rji1ejRUl
	 e7QekGDYLdtqw==
Date: Fri, 6 Nov 2026 15:29:39 -0600
From: Rob Herring <robh@kernel.org>
To: Reza Kurniawan <imkyufie@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, Val Packett <val@packett.cool>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Alejandro Tafalla <atafalla@dnyon.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: psci: Add
 skip-suspend-mode-switch property
Message-ID: <20261106212939.GA1814035-robh@kernel.org>
References: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
 <20261022-psci-fix-v3-1-9ce2133c5659@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-psci-fix-v3-1-9ce2133c5659@gmail.com>

On Thu, Oct 22, 2026 at 09:41:10AM +0000, Reza Kurniawan wrote:
> From: Alejandro Tafalla <atafalla@dnyon.com>
> 
> On some SoCs (e.g. Qualcomm MSM8917 and MSM8937), PSCI_FEATURES reports
> that OS-initiated mode is supported, but every PSCI_SET_SUSPEND_MODE
> call is rejected with NOT_SUPPORTED.

Is that call fatal? Why can't you just try the call and if it fails, 
avoid it. Then you don't require a DTB change to fix the issue.

Rob
