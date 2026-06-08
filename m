Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623839020C;
	Mon,  8 Jun 2026 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905775; cv=none; b=NvIvoC3wySddiMgvu4jow/FB1gqRXjuEwuc04UTg8aymyilUe8X4A0rAVNv7/NOXMYNxMCpDPfopxQc/9mOpq9ZAh6CQV+17aEdl8dHkQFVfVgzY7MrGOBwLVWo2vA+F6weRcgbUlwSkXk/koK/gnMiNfsAyM8EHOn35QFefSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905775; c=relaxed/simple;
	bh=1tSDoXNhb7SgjEIkhqIL13GKP2qY5vWoJASiCw4GsNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS/NT0RmOXbcncm5y4i2g1T1fncrUpn8DjFkjtDVcJmzwzLu2zf5UZSmsa8C3F8slhUaoiNx6moFUG8WUENb1XxPb2f36/PwTK6oYcfh+eUfMVTXzOaK6p70jrLu+JGKmuDQnSNZHRUYEZ1j8goaAAJDZsswHWKOeZ3MB/RHDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3OYe+dy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3OYe+dy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46291F00898;
	Mon,  8 Jun 2026 08:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780905773;
	bh=PvD9dkZIb+vT8pHtc0tPSxPCksAIeVFAwjLoPDEvWlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H3OYe+dyxWjKyPlwpIV57pf1eQnkyB5PPrVqVOwRnUWORSOZkd5hrQSw5QRCJwdKg
	 x//+kR+KpWnD4kH6SG3314GobXto9WtGdsflenBo8KW3SRBC0cc07Ky3Uhl7EbpkhO
	 xUmZSUEajaGs2sm75WZUOiovPeOPT8HlzzesiJl6yFGLirQBYfk6hctv9/QkrY4Qq/
	 AjMKhcUT+i45b/PPlqr3copOZIe0sD77NMZtwyuBU7UB98FX8IRHqIu4Hv+TyOwDbi
	 MIjPLZwpC0PRVLCoGf3QrghiljmDXZrmk+obRUpB5z2NJcpD34ouDJM9AlG1zhwU0d
	 srlyQJRagAY2Q==
Date: Mon, 8 Jun 2026 10:02:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: interconnect: qcom-bwmon: Add Maili
 cpu-bwmon compatible
Message-ID: <20260608-statuesque-strange-bumblebee-c7a95b@quoll>
References: <20260602-bwmon-v2-1-d4a851c45f37@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602-bwmon-v2-1-d4a851c45f37@oss.qualcomm.com>

On Tue, Jun 02, 2026 at 02:54:13PM +0800, Yijie Yang wrote:
> Add the Qualcomm Maili SoC compatible string for the CPU bandwidth
> monitor (BWMONv4). This falls back to the sdm845-bwmon compatible,
> consistent with the existing pattern used by other recent SoCs such as
> sm8750 and kaanapali.
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
> Changes in v2:
> - Drop Assisted-by tag; no functional change.
> - Link to v1: https://patch.msgid.link/20260525-bwmon-v1-1-b8f6e189c3e3@oss.qualcomm.com

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

