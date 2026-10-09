Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342154D09F4;
	Fri,  9 Oct 2026 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547989; cv=none; b=YlxfVsfj4X/wJ24/0dzjhzHxdRrbfwtFMV/jNEFO9QcW+IKK5MSy29kO5be6lf4/WO2uk96E4zVddRRpgeQ4pxTpFXp3WbK4xi09tZy35MBaaCnfVS62o78L4wt9U7wfZ3mfc9VteU+wAItdPqAryi0oayNYT5sYG0sSY/EoFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547989; c=relaxed/simple;
	bh=OTNomCQwJL3N5zmMnY4VTlp2HhXw0YP72DMMiv/28dE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQgAhyRbvBXEp5B1WMRpPkck4+bOd7vmGTD3MJauX4yHsWG5PrGHx+2Mgh5qkrqrapE1REUK+ylc50ok/O7/21DunRplNfvNFactP5NSM7/TnDf+zmSzIruPwJnM6jxq54mpgutBdalOOFb2M7SawMVbWR64NhEDyVsjZlO7PAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=P1nyq4lU; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="P1nyq4lU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1791547982; x=1823083982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vSc7S0sErgSHpP9oJR+kqo0I61w+8l/PYMOF21YwtA8=;
  b=P1nyq4lU4hy/JfsShj7IjUWZXeDUYGarJRzNT4mL+7HS5mIFwlPKYC4s
   P/8Jvsrn4p0qddw9ziETpeu7KSL6OVV/wr6cHc3OCpWBN93N4aOZ9Cvhh
   wxEnSc/k6tbRTnvbvp+kckP4ODJjSzcKaczB/rb9ay4OEF2mzkBa4zKYX
   po9wYP5gOSNsiu4vqHJIce1aibQ+sjVY19QewTEFRWy5RINZQIt+OUA0b
   zYK9jJqcYCFkv5CxN6V2cBXQoHBIsNE9QMHz5YDDiwBsQunlAEvzuolux
   Q1+UyVNtdPXvmUUmvui5km5wOvIDNDAaBI/5FoEUKeKGrZyZ6mYIFvzJU
   g==;
X-CSE-ConnectionGUID: 3brt9oRuTPKwLfaPFx2A8A==
X-CSE-MsgGUID: ApmFh9biQ66jpIZrUWrBtg==
X-IronPort-AV: E=Sophos;i="6.27,148,1787011200"; 
   d="scan'208";a="30339871"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:12:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:12018]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.50:2525] with esmtp (Farcaster)
 id 924e5c0b-2973-4857-8323-402bbf408de7; Fri, 9 Oct 2026 12:12:59 +0000 (UTC)
X-Farcaster-Flow-ID: 924e5c0b-2973-4857-8323-402bbf408de7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 9 Oct 2026 12:12:58 +0000
Received: from localhost (10.1.213.6) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Fri, 9 Oct 2026
 12:12:58 +0000
Date: Fri, 9 Oct 2026 14:12:55 +0200
From: Roman Kagan <rkagan@amazon.de>
To: Christian Loehle <christian.loehle@arm.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [PATCH] cpuidle: Add the shallow governors
Message-ID: <asjaR_aPwevvBw_O@ub9ea591b72db54.ant.amazon.com>
Mail-Followup-To: Roman Kagan <rkagan@amazon.de>,
	Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nh-open-source@amazon.com
References: <20261008-b4-cpuidle-shallow-v1-1-c19e71127b14@amazon.de>
 <e18bd763-0d6d-4bfd-b59e-78f952c94aa2@arm.com>
 <faf34e6e-ecd9-471a-b30e-3aa79e3ee063@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <faf34e6e-ecd9-471a-b30e-3aa79e3ee063@arm.com>
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, Oct 08, 2026 at 07:29:43PM +0100, Christian Loehle wrote:
> On 10/8/26 19:17, Christian Loehle wrote:
> > On 10/8/26 19:06, Roman Kagan wrote:
> >> The idle states offered by a platform trade wakeup latency for energy
> >> savings, and there are situations where the trade is not worth making:
> >> while a latency-sensitive workload is running, or during a live update
> >> via kexec, where everything from the outgoing kernel stopping the
> >> workload to the incoming kernel resuming it is downtime, and deep idle
> >> states may lengthen it.
> >>
> >> The mechanisms currently available for that are all one-way.
> >> cpuidle.off=1, idle=poll and idle=halt can only be requested in the
> >> kernel command line and cannot be undone, and the PM QoS interfaces
> >> (/dev/cpu_dma_latency and the per-CPU pm_qos_resume_latency_us
> >> attribute) can only be used once user space is up, so they cannot cover
> >> the boot of the incoming kernel.
> > 
> > You can also disable all but the shallowest idle state in sysfs:
> > echo 1 > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
> > 
> 
> And I'd probably prefer having that exposed via the cmdline rather than
> two separate governors...

Doing this cmdline configuration per-cpu per-state is non-realistic.  I
guess you mean a single option that would express a policy, like "for
all cpus in the system, disable all but the shallowest state" or "...
all but the shallowest non-polling".  But policy is exactly what
governors are for.

Why exactly does having two more separate simple, narrow-purpose
governors sound wrong to you?

Thanks,
Roman.
