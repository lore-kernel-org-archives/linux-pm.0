Received: from mta1.migadu.com (out-153.mta1.migadu.com [95.215.58.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5AA4CF46B
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792272653; cv=none; b=o06hy/Q72J4ym7Yjlb3T8Qu1ZWFCE5cqiGmDHV6wPKRUwqsT15PSQhJrBxeY/7TkGNThtNUaUCa6Ayg20JjYTWjR/JFt5lroklexI8i/Vjw+eNgTCoc9NhuqUNlZqwQQC5XHMp1QW+xIqRvn3GmtjmR9VqB0tqhdtWhvtNn5vPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792272653; c=relaxed/simple;
	bh=oFKzuUCJrKx39ZMIlQ2/kgBJRP6R7Lq8f0WtyI+Xr90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CO0qhNT3TjbNQHcMRPMe6qe8K7TGKTPOwRjvI95uIbL8bgm7bSOZJD4lNLaqas1/rOX8BuyzG6eOluv4/mqnFvhGt5utCT/+AFz9LwA2XToZ6picwBKSYl1L//G/W0gNBCey4K0q/vm7SDVOhWYxJKixdrgXjApYMUlpX57suJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=XjjbILmE; arc=none smtp.client-ip=95.215.58.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="XjjbILmE"
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oFKzuUCJrKx39ZMIlQ2/kgBJRP6R7Lq8f0WtyI+Xr90=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792272646; v=1; x=1792877446;
 b=XjjbILmEv+znvTWFogSTQRgR80z2Xr6J0Mspw8g+8NgPV+vqwXJHrJ8y6LU1+0iO3lAOUplv
 3sio0cDIMMJ3lK9dV2WE26vlcmvxOhtwbCWYjl7kuFe8unHyNR4LSCKgADs2FfBpW8wrqr3zepO
 Ic+C6Wrjhcwj6i4+AmwBx3Cw4TLVPc14jscvVt3JBllwb6sbkYMBozi2ZQ4pmKcXuIhqoBw0tb/
 GUXTZnaiGU8/h19e5Wo83TDK+rgWzwHkoY78S/3jlfl52bysFKxWSRjfekwwQNtE2Byig3hilNv
 8w4WYbz7jzm2TLqz1DRScJ5vQeAjEDIoGlzNJO08QSRZw==
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4b86bf520d346430;
	Sat, 17 Oct 2026 21:30:18 +0000
X-Mizu-Trace-ID: 4b86bf520d346430
X-Migadu-Flow: FLOW_OUT
Message-ID: <748ec3d0-2eb6-454b-b0ce-36c04d7bf844@packett.cool>
Date: Sat, 17 Oct 2026 18:30:08 -0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: arm: psci: Add skip-suspend-mode-switch
 property
To: Reza Kurniawan <imkyufie@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Alejandro Tafalla <atafalla@dnyon.com>
References: <20261017-psci-fix-v1-0-dedae27e4a31@gmail.com>
 <20261017-psci-fix-v1-1-dedae27e4a31@gmail.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20261017-psci-fix-v1-1-dedae27e4a31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/17/26 1:41 PM, Reza Kurniawan wrote:
> From: Alejandro Tafalla <atafalla@dnyon.com>
>
> On some SoCs (e.g. Qualcomm MSM8917 and MSM8937), PSCI_FEATURES reports
> that OS-initiated mode is supported, but every PSCI_SET_SUSPEND_MODE
> call is rejected with NOT_SUPPORTED.
>
> PSCI provides no call to read back the current suspend mode, so the OS
> cannot tell which mode the firmware is operating in or why the switch
> is rejected.
>
> Add an optional flag that tells the OS not to issue
> PSCI_SET_SUSPEND_MODE on such firmware.
>
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> [Reza Kurniawan: split out the patch, rewrote the property description,
>   renamed the property]
> Co-developed-by: Reza Kurniawan <imkyufie@gmail.com>
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---
>   Documentation/devicetree/bindings/arm/psci.yaml | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> index 0d04389c81..7777077dd0 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -98,6 +98,19 @@ properties:
>         [1] Kernel documentation - ARM idle states bindings
>           Documentation/devicetree/bindings/cpu/idle-states.yaml
>   
> +  skip-suspend-mode-switch:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Do not issue PSCI_SET_SUSPEND_MODE.
> +
> +      Some firmware advertises support for OS-initiated mode but rejects
> +      every suspend mode switch with NOT_SUPPORTED. Since PSCI cannot report
> +      the current mode, the OS cannot verify the state the firmware is in.
> +
> +      This property is an assertion that the firmware works correctly without
> +      a mode switch. This is a workaround for non-compliant firmware, only set
> +      it on firmware known to behave this way.

"for devices that ship with firmware known to …" would be better 
phrasing imo, "set it on firmware" might sound like it's implying things 
that aren't actually happening


Thanks,
~val

