Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA54244687;
	Tue,  6 Oct 2026 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255221; cv=none; b=WsgITdo7bpYv15oXKyg+4A4OBsPVfawyjaDjsMsLDFUDFfsUvaKO72jRRAPo+UojLsWeltxO1hdjZjGfoB0ABRq8eNsP1aBheq7T/ZuK5fb+6kGeA9RvZKYTBNQGljfAC3c9ixb5mYrCUqwtyAV3/IQiEy1uD4YuLk8Tj0ZzOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255221; c=relaxed/simple;
	bh=AHiP8kURPHN2C0DWX5LOnlG7Bl8XhZ0CSkNi6iXUDHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl45gFGUf2uGD7nqRyJ67Z1pl1skKIKvSRVvWFVwctA6Gagr6gBK9Sbq0/Xhfb1Bs+LPLHvjes1UbHAjdzgVLgqVd+oHa0ir4isGIlSOcXadB/JHDxeZcjdSoHDmi3hPW1EAM5xW6EoHPNv2s0Se9wIy4jKTXtP9Gg4O8n0smk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3b/+E90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3b/+E90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E6D1F000FF;
	Tue,  6 Oct 2026 02:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791255219;
	bh=V3cTE6CEeaVLSbJBCMPs3juqjM+llsV1pDj+h29WtkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C3b/+E90+51wgBgIZ63YKbOX5mfjNH4e57ru9piCUPJA0hGhgxUykIJlp8rX+I5XE
	 WH4p7ElVlUZIvYV+rH/J3LJ5D7JDDVui9cUV0SH+pSXpAsHhQHNbgPE8OWW1pXhf0h
	 NA70BPbjOWlMl6MfCkouD/F3l70f50mf0qgawKTq9FNERZvKFj0psyGCZaSA0Gfkti
	 MWZQx1OVSWeONbqoYPqm526aiTTlxxpzw2h1tNIdjz3kW9qCTQSKsAabP/6Yu5f1v3
	 Zy/vPwSdKkXvZzZhMbLvsuI1SKo1ZB/b8ChaX43kKEuij0erQVLuWEYTKSvqAJS2FW
	 V4E2BSkf09wUg==
Date: Mon, 5 Oct 2026 21:53:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Moritz Fischer <moritz.fischer@ettus.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Andy Yan <andyshrk@163.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Andre Draszik <andre.draszik@linaro.org>,
	devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v26 05/10] dt-bindings: arm: Document reboot mode magic
Message-ID: <179125521832.3448223.14726360710255018567.robh@kernel.org>
References: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
 <20260928-arm-psci-system_reset2-vendor-reboots-v26-5-b24e2348e8e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-arm-psci-system_reset2-vendor-reboots-v26-5-b24e2348e8e1@oss.qualcomm.com>


On Mon, 28 Sep 2026 11:39:17 +0530, Shivendra Pratap wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 56 +++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

