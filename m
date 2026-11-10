Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.244.194.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301973;
	b=5KBjVYOlvnq25EBkcfVh0d05KRez4AKhHRvnXYVcT5VZuzqOLuq2loStDmV+hd+hPcQ/
	 9Mpn8JkDEV/4nnUj4vIfD17XZWCjvSpOFNlENu057D90sKi4WWSejvf/c9wAVqxPn2vJp
	 t6MFd3tlTFx7O4iF7AexDEajBT+hmO/XFkoiqf5YTOo1JgAyrW3V4P1RP4xm8El7UIktA
	 XV3VmeNoJmkYIO8HiQ5CWBEf9rVRbNDmP72LAp4/MULgOszHv6JUQW4snmxXgxU+oKYHy
	 +DGSKGIrEI/B8D8TelQz15IkFpGwF1/pN5xzdyiIwMj/P5F+5rP2gDOrqlrbDzcnnEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301973;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=P6SoTY/qPxSRsFVfVmHV701Duq3Pn8mi7sps2ssRpo0=;
	b=YEwjb1nEUQqgpfvkxoA4WGJPJB2j4yMHMoEkpKJwNoCQdiAJSe7YijLjcY8k43u5DRMX
	 ZS6zjCEckb+HmBvROJWNRMNKXJqpb/z67iQO7vl9zigYSvYDqXDPI5dr+A1JUHikKl15G
	 eOmICK8n0ijqaLqBYK0CEr3tT9zmbUAvb4+wA/0g/pfiS6kJE3i94Tdc7U9ymOiGVLbGp
	 WCQErD1FvwEvs2qJHI1jH5xHMFJJb7bigsh96j50gp9uHOlP/a1rKo4g3is1jHcokK/A3
	 NbaNz8sVi0PEr9g77l2OlXRvKIpD/5wwW2/LCq/nMsuTA2PSFfUaV6GGXcRzch3dyBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=YOpMKtm7;
	arc=none smtp.remote-ip=185.244.194.184
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81A606A325;
	Tue, 10 Nov 2026 09:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE81A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=YOpMKtm7
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4jP1B65cV4z9VR8;
	Tue, 10 Nov 2026 10:11:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1794301918;
	bh=Uxfq+9SLLu4IfxwcONSpQNLgnskcylSEYAOSXGskFCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YOpMKtm7JwzGGfCu+MECFEV5sDtNm1BEiN+bHejH1gjrgt3h9oH5ZSmFAILGWzzJ9
	 gvPRfPduHW6So2e0/PFgsZpunVb0DOB6Nxp7+bmJpOnoVIlBH2szvnEXV2olYK7iDU
	 nfde6UVbD/PRqh+BD66cQ3Tar2rjvMXpBcB/dI3JnsNKky1sdLTxr2FI7vYCwCP1I/
	 xb224RNw4kAXhSd7rPIBA83vLAtHpaagfisnl9hKwTB94f0i1hyEhDCWQ5DLXYA8z/
	 BcovTzac3iLgylZazUzngZtDl/J1Xk6z1+BZN962esa16W5Iiu6XYu59rhnKOc190r
	 m5A+ylD9rSs/A==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4jP1B64vK8z8129;
	Tue, 10 Nov 2026 10:11:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jP1B35ZP6z8tgk;
	Tue, 10 Nov 2026 10:11:55 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 3321B5FA5B;
	Tue, 10 Nov 2026 10:11:34 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f5ddf27a-9771-4967-a9d0-13c09f588402@leemhuis.info>
Date: Tue, 10 Nov 2026 10:11:31 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] cpuidle: psci: boot stall/hang on i.MX8MP
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ulf Hansson <ulfh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
 coresight@lists.linaro.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <20261030171910.2822677-1-dario.binacchi@amarulasolutions.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20261030171910.2822677-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179430189496.738146.16548204213021020966@mxe9fb.netcup.net>
X-NC-CID: nXaVOhT/l03j0ELJaOTQF9RW2is43Eqb5I+9yhoMdtaYrpVBfhs=

On 10/30/26 18:19, Dario Binacchi wrote:
> Hi Ulf,
> 
> on an i.MX8M Plus Dual board (Engicam i.Core MX8M Plus), mainline
> c339f4010dea sometimes stalls for ~0.9 s at boot, or hangs until the
> watchdog resets the board, right after:
> 
>   [    0.806123] ledtrig-cpu: registered to indicate activity on CPUs
> 
> On a good boot the next message comes ~11 ms later.
> 
> About 1 boot out of 3 stalls or hangs. With cpuidle.off=1, or
> with commit 65705b18162b ("cpuidle: psci: Move initialization a bit
> earlier in the boot sequence") reverted, 10 out of 10 boots are fine.

Hmmm, nothing happened here. Might have fallen through the cracks, so
maybe this mail will get thing rolling. If not, I'd suggest you submit a
revert.

Or was there progress or even a fix and I just missed it?

Ciao, Thorsten

> I haven't dug into it much. The stall seems to be in
> pl330_driver_init(), so my guess is that it is related to the AMBA bus
> reading the ID registers of the CoreSight ETMs while a CPU is already
> in cpu_pd_wait, but I may well be wrong.
> 
> Any idea?
> 
> #regzbot introduced: 65705b18162b
> 
> Thanks,
> Dario

