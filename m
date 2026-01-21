Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83987322B68
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990607; cv=none; b=sKyLVld7+yK/CIbdNC/HIm2iFLpX+6rAOPLQ9BSy1kBSzD8m/dkImSvLw9niHwamitCpCc+AG881nb4DdjMtYhiFw3QERaIR72PsjxefhhtdnThyH2fNmc7J8gwvyJJfMbTpr5Vc+9hYntQJgOYV0mTynXuUExytuJFnX9Ph7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990607; c=relaxed/simple;
	bh=BqJB0ky6a5o2Ecu+3eubhea+J8ftyleZiqpIAurBAes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dU5AnSe635hzMbholI31UUhj/VxTPEaCUVFpGUVdXxNpzTIPWDOVA4yXk6er3vMLikPm0JL6EpZMbAyu4I/f5wriB+8YRdp/zi2vp1HDIVjqM9tgwCgpzwyiyBgLHzItW47FdazDeMeDVkw/PT5hOdCHwMDXticmgetQwGY06dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RNmK0BFK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RNmK0BFK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B638D4E421C8;
	Wed, 21 Jan 2026 10:16:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6BF7B6070A;
	Wed, 21 Jan 2026 10:16:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 833AF119B111C;
	Wed, 21 Jan 2026 11:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768990600; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uNOQ9N5B9qlztbYZFFk35qcWieqUQXY/SvMqhArSNVg=;
	b=RNmK0BFKvkB8IF5ORRR6qJWC0XvUCd5IlBVPRrQ/iiq4Dj8rj3tn2hhx8PxXmcDpjqcAMP
	vweEPJJvrehHNpkxvoTg5lRK9Ej8Uuh43cjRZEp31yZ7FfatQ0kExVBuRRosErznkBdUpj
	kOwqcoWN2/h/05AnmoU0OHgfo3GvVZ0svy7RPaRkwYfiYi3rjl0vJwwNc+cEF0YBmhBBCC
	Ms/XMqza/DsYPaKaaB2nOz3st4T8ChMYSMI/PCsdB0wAoQnGVwwWueqn4tj0R3S4aspGLq
	4W/+GQRLvdI2oS44/Ic0kTPLoVwb4oIqvgTDKudnEBpu93C2y4wdfPfoRZT1cQ==
Message-ID: <43461785-37a6-4228-abec-2364cae190ea@bootlin.com>
Date: Wed, 21 Jan 2026 11:16:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpupower: make systemd unit installation optional
To: linux-pm@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, shuah@kernel.org, trenn@suse.com,
 jwyatt@redhat.com, jkacur@redhat.com
References: <20260113132753.1730020-1-joaomarcos.costa@bootlin.com>
 <20260113132753.1730020-2-joaomarcos.costa@bootlin.com>
Content-Language: en-US, fr
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260113132753.1730020-2-joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

I hope this emails finds you well!

On 1/13/26 14:27, João Marcos Costa wrote:
> cpupower currently installs a cpupower.service unit file into unitdir
> unconditionally, regardless of whether systemd is used by the host.
> 
> Improve the installation procedure by making this systemd step optional:
> a 'SYSTEMD' build parameter that defaults to 'true' and can be set to
> 'false' to disable the installation of systemd's unit file.
> 
> Since 'SYSTEMD' defaults to true, the current behavior is kept as the
> default.
> 
> Signed-off-by: João Marcos Costa <joaomarcos.costa@bootlin.com>
(...)

Gentle ping on this patch in case it slipped through, and any feedback 
would be appreciated. Thanks!

-- 
Best regards,
João Marcos Costa
