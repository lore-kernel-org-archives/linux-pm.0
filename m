Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C923B8934;
	Mon,  6 Jul 2026 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329402; cv=none; b=ZPbGu6IAxVhoDEn33jJ7jPCQe2PPlcN/gLICSAPEbr2r85u073Ajt/YVPImAOUnXptdDhUmGYGJW7Tbp7/14cRTdwustuAnzpd78pTJ4jT9OeqpRCWySwfxPhXvg949TzHl14o881t4QTAyY4ccmL2AHqY53hSGYRYbovXbnVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329402; c=relaxed/simple;
	bh=tAvOtMXm/P4hMQo4CyDsw0njcmQbY4L/sLCEhymQXEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu5CJkdE8LgBRKsAb3J1nNcr0deaoED2YGX/KQAc9QBffgBOikgCjSzOFeBVQr24G0Wx9CEtaSH77VaZMXY8S7Z7S575vRyXDA28oNiTSu30esFAAKpN9Yxk0gfeng+JdejjDVXh5R/YdYhcn7WwLfycy0Gb/TXXmC4GHoZPWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRLy7BXm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRLy7BXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6433E1F000E9;
	Mon,  6 Jul 2026 09:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329392;
	bh=GqDsh2QaLKyHlaA9B2wG1IbFv9bbWVtFohll3WxV0wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WRLy7BXmrQwuhcKKUQeEVftjBJSq86DS94OZuPCDtxVVR4EzjIwIyxHW19+RNTnl/
	 agnpZdEOj4r2UwCF4o5qz9ShTdxFLQEX08eSDco8+NxfukYNxIVJBOgpmCgrFG3tSI
	 HtHIc3dFLxKbhmlCYLBlMggzaB5gUNP5NeCeJhDqy6vv7l5ICeFT9kHpwdRUK8OhPS
	 7U/1s8+0E9kv2R9QUFEjqDz30TX+Q+zpmiu2NKA4NMis4c8iU1krFfrUDcUdZsdPpT
	 eE5fhi/IFdyQe0zB0qDbod27nr5AAy5VLFqTkCgDwFmpXOPZkHoDdOpXh8bwtQbwVF
	 wBWkGIoAbbEMw==
Date: Mon, 6 Jul 2026 10:16:27 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Disallow disabling boot CPU based on config
Message-ID: <20260706-practical-inchworm-of-experience-d4e0ed@sudeepholla>
References: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
 <20260703-competent-adaptable-coot-f8daaf@sudeepholla>
 <4b7fe7e6-2531-4d26-9085-43f40a2ce2e0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b7fe7e6-2531-4d26-9085-43f40a2ce2e0@oss.qualcomm.com>

On Sat, Jul 04, 2026 at 08:43:39AM +0200, Daniel Lezcano wrote:
> 
> Hi Sudeep,
> 
> Le 03/07/2026 à 17:51, Sudeep Holla a écrit :
> > (It is always good to cc all PSCI maintainer for any ARM64 CPU
> > hotpug/suspend related changes)
> > 
> > On Fri, Jul 03, 2026 at 04:50:02PM +0530, Sneh Mankad wrote:
> > > The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
> > > the SoC to ACPI S3 similar state where SoC is turned off and DDR is
> > > retained. The hardware design on these SoCs forces a constraint to suspend
> > > and resume the system on boot CPU / CPU0.
> > > 
> > And you fail to explain why they have that constraint.
> > 

I still need the above to understand the issue/constraint better.

> > Is it because some secure context is not allowed to migrate ?
> > 
> > We already have a mechanism for that in place and this hack is not at all
> > required.
> Do you mean a mechanism for the secure context or for preventing CPU0 ?
> 

I meant constraint based on secure context.

-- 
Regards,
Sudeep
