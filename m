Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586533B38B5;
	Fri,  9 Oct 2026 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564641; cv=none; b=SLRrPWUkmlX4mlw67vcfCm6Iwt86Ze+OWrROyJu3STvXrLLtETlh6BqI4/dLalHEBsLK717fKiYDo/s/O7kjAZeBEw23LOUkyGYOhryZIJpPpw4w+S9fMStV8WXiOhpMlEe3WXdlfJsZ9F1mcQKH0kmUrcxQlBXLRCaTLjTILtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564641; c=relaxed/simple;
	bh=LIFsaO3fsvEhD6wKg9EfgPe8fhHtTQ9Cyr4ksp9R8xo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp8DjzfzlgiI03eoSvrN2LgnSqZ7JTBGFQMAFHwtEhVjkKVdIsyQ2FuLQrkzVRTFTOKsPvh/JII2jI8H4lBaXu1CS/U8FAxF05qt7uOg9cSC8Czqe007goAD1oojq8E+K51Q3SISoYOQrcndEh/+BTeOkwMHxBzVRsw86OnASRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=fKiuW4Nm; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="fKiuW4Nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1791564640; x=1823100640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0kAPpWGj1DC84kxfJatA2C4pxii/3PkUflvl6jcTUWU=;
  b=fKiuW4Nm58rJxOUYPRZ+PwjouBuQAzXpuzOt2wJkSrSY5b3n/XQJCacQ
   /IM0aWVWJzKtjYlYzPdxF9d3wrRQAO5idMO2l18kamYTFcbPnUzz22+31
   7oJMqoPrDuAKMysTpd3fRE2AaxQVdo2plktYhUYHDT+o5NfR48bJoef7o
   OC1DZmEKdvgbp7tPeXmPiJWdhBiXdC7sO0RRaxl4GDBikUr025ZvtHUip
   wR52RIg1XwhqQhbHBKVhYuNyrcpUKocyax+W2/JhOWiEhELbDgaNZFxgF
   5HpytFVEbiysislftvsJ2gr8Ny+YuCoeUdWoKrdjgvARdokF5ZmObmS3q
   w==;
X-CSE-ConnectionGUID: f2UJQ553Tn23QdDbD8h91Q==
X-CSE-MsgGUID: ATqxIQTtRLSTP+W/nH5mfA==
X-IronPort-AV: E=Sophos;i="6.27,148,1787011200"; 
   d="scan'208";a="30616529"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:50:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:25422]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.115:2525] with esmtp (Farcaster)
 id 744db98d-fcae-4ba0-bbf3-9974e881881a; Fri, 9 Oct 2026 16:50:37 +0000 (UTC)
X-Farcaster-Flow-ID: 744db98d-fcae-4ba0-bbf3-9974e881881a
Received: from EX19D001UWA002.ant.amazon.com (10.13.138.236) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 9 Oct 2026 16:50:36 +0000
Received: from localhost (10.106.82.18) by EX19D001UWA002.ant.amazon.com
 (10.13.138.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Fri, 9 Oct 2026
 16:50:36 +0000
Date: Fri, 9 Oct 2026 18:50:33 +0200
From: Roman Kagan <rkagan@amazon.de>
To: Christian Loehle <christian.loehle@arm.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [PATCH] cpuidle: Add the shallow governors
Message-ID: <askbWVeX1pDtYC60@ub9ea591b72db54.ant.amazon.com>
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
 <asjaR_aPwevvBw_O@ub9ea591b72db54.ant.amazon.com>
 <2e635fc7-3d5c-4555-b92b-9e6e405f1b23@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e635fc7-3d5c-4555-b92b-9e6e405f1b23@arm.com>
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA002.ant.amazon.com (10.13.138.236)

On Fri, Oct 09, 2026 at 01:45:40PM +0100, Christian Loehle wrote:
> On 10/9/26 13:12, Roman Kagan wrote:
> > On Thu, Oct 08, 2026 at 07:29:43PM +0100, Christian Loehle wrote:
> >> On 10/8/26 19:17, Christian Loehle wrote:
> >>> On 10/8/26 19:06, Roman Kagan wrote:
> >>>> The idle states offered by a platform trade wakeup latency for energy
> >>>> savings, and there are situations where the trade is not worth making:
> >>>> while a latency-sensitive workload is running, or during a live update
> >>>> via kexec, where everything from the outgoing kernel stopping the
> >>>> workload to the incoming kernel resuming it is downtime, and deep idle
> >>>> states may lengthen it.
> >>>>
> >>>> The mechanisms currently available for that are all one-way.
> >>>> cpuidle.off=1, idle=poll and idle=halt can only be requested in the
> >>>> kernel command line and cannot be undone, and the PM QoS interfaces
> >>>> (/dev/cpu_dma_latency and the per-CPU pm_qos_resume_latency_us
> >>>> attribute) can only be used once user space is up, so they cannot cover
> >>>> the boot of the incoming kernel.
> >>>
> >>> You can also disable all but the shallowest idle state in sysfs:
> >>> echo 1 > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
> >>>
> >>
> >> And I'd probably prefer having that exposed via the cmdline rather than
> >> two separate governors...
> > 
> > Doing this cmdline configuration per-cpu per-state is non-realistic.  I
> > guess you mean a single option that would express a policy, like "for
> > all cpus in the system, disable all but the shallowest state" or "...
> > all but the shallowest non-polling".  But policy is exactly what
> > governors are for.
> 
> Yes, I had something like
> cpuidle.max_exit_latency_us=<N>
> in mind that then sets the disable attribute for the applicable states.
> 
> > 
> > Why exactly does having two more separate simple, narrow-purpose
> > governors sound wrong to you?
> 
> Because it's a lot of duplicate code we have to maintain (and the
> documentation).

Fair.  But then PM QoS model appears to fit better.  I'll see to
reconcile it with the need to be able to set at boot and clear later.

Thanks,
Roman.
