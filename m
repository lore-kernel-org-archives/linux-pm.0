Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79383BFE26;
	Tue, 31 Mar 2026 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941736; cv=none; b=pPfn2YOlUIUJrtV1DtM3v6oPUXfCfi+1SVAzs01njSd1aNtEialzGKsSi2ZPghxrQlK90hxzjZpP8W3DJUGFTEGP1YzJtLkoBWidiIF1WdmHT0dLGmxM8XvDMrQ/RR1ZJMhERGZVsh4lYwQUMFZzym49pf4HaMfpE/WgRZFBvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941736; c=relaxed/simple;
	bh=cAhfPY2nlrEvbPh4MsPAlD8tOnaKqYTDsn/2Pmn3kAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY8deu6yHQf8SRli+EuL9LSZZjtkTBNnJXKZ7gXYP4LDSctjG96r7nc13acmy6H9trVMUTCkTP3hbUn8wDsVOHQWk2mVFy9JbWm/T15OUf0hSi+f2WmOsuc/EB/hsZYz42fA4n4N7McbIJiojGEqOuD4hmRPBTeiuPvSQCCOhlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml9Kx8Ff; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml9Kx8Ff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F43C19423;
	Tue, 31 Mar 2026 07:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774941736;
	bh=cAhfPY2nlrEvbPh4MsPAlD8tOnaKqYTDsn/2Pmn3kAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ml9Kx8FfN1P7y9DKSLbTjPNUdC92APM15X5WMz1zjiaCDxeK10k+DSBoZequrmuxG
	 f2iYYM0UYsxnpEl5vjRL9nl9hkaePvauuRz4Hgcw49ZL8Btnt5LPVJhptCXq2atX/5
	 /xXdJ9mtVy+FO+6pRAfisFfp+Fxx2dTEIJUKaZADCyhU96oY9V/Nd+Nwoy3GnVIMP3
	 edDfr2FlXQM/gEBvzjLaWtw3/QLr85BvkhIfko0hvqxjEXYgjRQcDLIgMyINt/k196
	 WRLRZjZGV60A/5gaFwU6aS6ALFyzx/fpopdlRy1XF5kBaMJkRFduiPx70+ksNcWXVF
	 d6MYgj80iSItA==
Date: Tue, 31 Mar 2026 09:22:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khushal Chitturi <khushalchitturi@gmail.com>
Cc: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ulli.kroll@googlemail.com, linusw@kernel.org, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: power: reset:
 cortina,gemini-power-controller: convert to DT schema
Message-ID: <20260331-acoustic-rousing-lyrebird-ab3cfd@quoll>
References: <20260330110135.10316-1-khushalchitturi@gmail.com>
 <20260330110135.10316-2-khushalchitturi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330110135.10316-2-khushalchitturi@gmail.com>

On Mon, Mar 30, 2026 at 04:31:34PM +0530, Khushal Chitturi wrote:
> Convert the Cortina Systems Gemini Poweroff Controller bindings to
> DT schema.
> 
> Signed-off-by: Khushal Chitturi <khushalchitturi@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

