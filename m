Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B82DECA3;
	Mon, 12 Oct 2026 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798140; cv=none; b=lg5BORluDbghlzKkTV54efdQyIYXxrbEhC3z6l6dhNoYf/ZOt1RpXsdz9plHMPnwcaSgM+im7V2TvRfC2nZ+BJ1ZUxM2g5mb1Id+CIEfy6OcW+VmovNAMykgPCdfeHuCPw0KK7ZARnZJnyhwkfNbXYeMo9eQRi/V29DyleBSr0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798140; c=relaxed/simple;
	bh=K5DkLg7btD5JQl079jl2IigGtwZyC2pV5p+SJVgh5tg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A/bEt4oRMtQk6jvSvF5M6AQBYavcHOBTDiHDMByymJab5T6cWFvjh2zGHD2OThEZhlr7/O2/AJWDVfB4Ec5chxOsSh3P/DH8x8AvLPBDRYmCLxBvBprp2Z0Z1Civ5+FHmt9w4+oUA7wFlaqEJWorvlOBZ74ViAk7jC7DlGm6gPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkY4GbxS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkY4GbxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4341F0089B;
	Mon, 12 Oct 2026 09:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791798139;
	bh=DL+bNDBXLJgZfbToj6KWu+Y6oT0vGGjICS6VCCiANVI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=kkY4GbxSheSkicTkj+0Auz7nQ27TFQgev0Q0kB6GyKLAvz59/qHlg27GY40mEOIYA
	 s7jEbJVuFfGiWOIOYuDWllLOFfiFI01pE1D6sI/imPJKN1spXLgUAXsMGIBfGCZ7sZ
	 5K0lwSOeDziuX8qMkTsLS/TfrCfoQT9zB9rFGK2LSM4P/dWTNt/wLi7iqqsvEhrmgE
	 Cu0Ule6ClfkqQRr3f7gUg4byub8K+bIFn+upvvI7WH2d+OOy7jB7eUzX2/mmkVUzNh
	 pfWf6K6g+uzhXFqy8OTLM1G03k6iNxtGya/HGWW03M5LtaEQaq0LKKvfspmB8cJIXO
	 +KGUgAKaabL1Q==
Message-ID: <d11e7da8-9202-4b9f-b915-155f9185770f@kernel.org>
Date: Mon, 12 Oct 2026 12:42:15 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@kernel.org>
Subject: Re: [PATCH] PM: suspend: Do not call suspend_ops->begin()/end() for
 s2idle
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, rafael@kernel.org,
 lenb@kernel.org, pavel@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261005111157.17256-1-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
In-Reply-To: <20261005111157.17256-1-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/5/26 14:11, Ovidiu Panait wrote:
> Commit 7602c0ec0bbf ("firmware: psci: Set
> pm_set_resume/suspend_via_firmware() for SYSTEM_SUSPEND") made
> psci_system_suspend_begin() call pm_set_suspend_via_firmware(), so that
> device drivers can prepare for the possible removal of the power before
> PSCI SYSTEM_SUSPEND.
> 
> Since then, on platforms where PSCI firmware supports SYSTEM_SUSPEND,
> pm_suspend_via_firmware() returns true during both s2ram and s2idle.
> This is inconsistent, since SYSTEM_SUSPEND is only invoked for s2ram.
> 
> This was observed while investigating PCI-related suspend/resume issues
> on Renesas platforms (RZ/G3S, RZ/V2H), and was traced to
> platform_suspend_begin() falling back to suspend_ops->begin() (PSCI in
> this case) when there is no s2idle_ops->begin() callback:
> 
>    platform_suspend_begin(PM_SUSPEND_TO_IDLE)
>      suspend_ops->begin()
>        psci_system_suspend_begin()
>          pm_set_suspend_via_firmware()
> 
> platform_resume_end() falls back to suspend_ops->end() in the same way.
> 
> Since s2idle has its own set of callbacks in s2idle_ops, make
> platform_suspend_begin() and platform_resume_end() only invoke those for
> s2idle, like the other platform_*() helpers do.
> 
> Signed-off-by: Ovidiu Panait<ovidiu.panait.rb@renesas.com>

Tested it on top of 
https://lore.kernel.org/all/20261007053645.1391545-1-claudiu.beznea@kernel.org

You can add:
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Should "Fixes:" tag be added as well?

Thank you,
Claudiu

