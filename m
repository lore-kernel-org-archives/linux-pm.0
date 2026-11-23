Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422057;
	b=JHhHruSt/g3+xiQMZA5tqwYBYFXgZ3YEhoHcHdbX0Nra6KqSFdfzYGUNxRbC8CsDZFVz
	 H7rhMvL2e+P+gIucTXFU+zYmsNG9ihqNZ8Lr06M3cKOPwjjoa6JRpA7RJv2DZPpxqYLyi
	 Gq3NvHmo7yRuDWJtjNSs2pLE7BSfQrEGsCuchTx3aTHQxxKRkR4quj1IryhA/tgRqPFkw
	 WSaCsO6XZK7p3I+dHi/AAlJSrqglyeOCl8n463dDtbfO2umcKCyWcw6COmJHsQTiXC/8L
	 jpMsOB5M0QVl0KTVCj+BDtTP6ZR2qxPj2AhEsh4NyZwwslNBNt2+YuJZkgsOePkUe0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422057;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sQ2JsQyaGnkqNYmLSeY9DfK22ASO/J7meMW4se4AFjs=;
	b=hOYfs4snKlp8JP1DIca3n6zpd0uVaYsXnRoSvNmlZPEdOsLNfbcRL3ELtzJoscY3JMF2
	 WkIHmpnODQo84qD6ajD2MdgGK+E1HgalDhZuIoqViSCMpQ0gnssneCTVxheNfxHDonzDq
	 KFwxXJIET0FMkTy1VBwPu2+8LK5IrwXfJ/dSR14XRJ3lIbOa16w4hK8FVnYlJHlUlfx++
	 H9u/iLUt/Eh0+ulupUy7PfD6quyEGZtq3M5fYjZKP4qoKdV2WNZYE6CbINShX2lq3em4B
	 d7Yss6m3pVg9bK/O18KuGg5F96EuU0RT837J1KIVQvfoMN3BgJUF1aXHktgdOMrBCUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icoSr60A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ADB606A32A;
	Mon, 23 Nov 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icoSr60A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9529A1F000EB;
	Mon, 23 Nov 2026 08:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422056;
	bh=sQ2JsQyaGnkqNYmLSeY9DfK22ASO/J7meMW4se4AFjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=icoSr60AnKmsiMso2redWQXWDBZWee0lAtzPTvF+Zasu4N7Gj94As+/uUIRE1xWPr
	 aUPBxUo7njNGQJqg2dQMCYshuymDYaxkOx94gvzCgwwkSOcZKGkfh7T+iWGF7/OqNQ
	 NZJ42alF7jObBRQM/dP4wxcYcMDGMNmMg8umysd4UT3ZBEIZTjPsRmeVsxPNy7OEKu
	 I7r25UbiTTPN2ljo3gSBRT1gE0CTOtXZ+5O8+Ir8S4Q04ncvK09PatANUMO177CCo2
	 Nz7wZYJtbsiIlPNGlnUwIe0wmgwjEjR008QTCYW7RgAtygaWymbjfgdHHndnkK84j6
	 fT9ynBq4EjKVw==
Date: Mon, 23 Nov 2026 09:20:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: domain-idle-state: Add
 system-state
Message-ID: <20261123-humble-native-ibex-7d2f72@quoll>
References: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
 <20261113-s2idle_state-v2-1-ad604182e7e7@oss.qualcomm.com>
 <20261116-icy-free-lionfish-c3eed8@quoll>
 <d3060950-04ea-4f9b-b160-0e068946e623@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3060950-04ea-4f9b-b160-0e068946e623@oss.qualcomm.com>

On Tue, Nov 17, 2026 at 10:34:52AM +0530, Maulik Shah wrote:
> 
> 
> On 16-11-2026 17:28, Krzysztof Kozlowski wrote:
> > On Fri, Nov 13, 2026 at 10:25:25AM +0530, Maulik Shah wrote:
> >> Some domain idle states require system-wide coordination and are not
> >> applicable while the platform is up and running.
> > You repeated the property description. Say something more. Why they are
> > not applicable when platform is running? So if not running, when are
> > they applicable? Why?
> 
> On certain platforms CPU subsystem deepest idle state requires co-ordination with SAIL subsystem
> such that both must be powered down in coordinated sequence. During wakeup SAIL subsystem must
> be powered up before CPU can resume. The wakeup can take a second or more.
> 
> Selecting this state during opportunistic CPU idle can therefore cause substantial wakeup delays and
> repeatedly interrupt SAIL operation whenever the CPUs become idle.

The idle state latency times define that. No need for a new property.

Best regards,
Krzysztof

