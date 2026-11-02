Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636153;
	b=WY3BNv6l+pNbAETal7U73cejsnJYzNRZ0PaPdQMW1vV2f4nM5NgNaNfBaMbC6m+oSku4
	 iLblctr4Jlz0fuK+gK7weZI1kelAq1rYeCkm3InibriM9RBy5PCqFi0N9F/kGBtOvvyZ7
	 r0xx8fM/fGYKXPR9vhwPogaX7wpmYH0LAucv5RvzSid6/KHBNdEPEBm/chZkrzOQts7Fx
	 tr/xVmjjl5N6v0ZgWoC3FeG1sBixODJ5hT/rw2oEJWIdh5RNRqTRMt91G/jGceft6l/D4
	 THg2pHzzHHooZUMOzSL2/MpreCyK1t4hJCFPf3qW3HIWcx51ze7TEHeXWEPDJvX1+AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636153;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=XmzZN/QhjlzcSaertRL7UUmB+mzbbmbqLS9Rd6E3UxI=;
	b=x3vKBnpkW5TniPFie2P4qg4fd28Le9cRBoY0vvnm2QnXh0Iirt7As3skmZ97Trhz7u3w
	 H6wGj83wabyO2GMxpiYPniT5P2PJgs5dlytQbDASH5Hn2XowNov6sm2u2laBoWtdcNGod
	 5GBGXre5eElhBLUlKDiWCyW/HIfV+KTXHVE+JO8cawH4VYOIcz27x3dZkvyUhEujHUgmG
	 OlgZLsjrgsStTPI+DxN/uOfu/i04+LP5/XUlJes3XXDfGHzXSzU5Nb4VcZgU7G2B548XZ
	 rGdvKgiU60VlwOpE6Id9GvnTUyfFiykX/TDYCWEPa8ickEYccxOpewtTYbGSwmMYHDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hVhDKak5;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833E60716C8;
	Mon,  2 Nov 2026 16:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B833E60716C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hVhDKak5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793636152; x=1825172152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gkPgrxM1TwjKtf3tbno2m9G3lnciTVHEcOozD+OD7mQ=;
  b=hVhDKak5YlDQQUnBM/dzo6QAE3n7DtMIWbI0KJn4nTVViMPsb85f/N8W
   KJuMbHMqjgGoL8IUPRzmNPcI/XYfxBNJoT0FaYpOYWE539Isk1G4Svg+8
   fRhcXLCLFrciIO1dXIyvmbM07S+ahse6BamcA/XEUEUl7OPc5gfEXJrDZ
   hcEDN57xCu2SVsTJ02s/EHt2FFwOVKxS31PghBUGdB97MQm38CcaBZ4hy
   WjUOpqwXY7681f08ar1ObaJHi1ZI+dhZoufwr3UGWbRquZ6VHT4b/r6TD
   E2vhjMtNr6yTO1/hzhA3MHlC0tNDBM2/w13e3P8OHuYXAVwlt8Be9gHmn
   Q==;
X-CSE-ConnectionGUID: kUt0Yj0YRUy4aeOmWpwKAA==
X-CSE-MsgGUID: k2Vequ3PRYWUAe3Hla9liQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2245170"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2245170"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 08:15:45 -0800
X-CSE-ConnectionGUID: vS5QyT21QpqixrBKTRYX7g==
X-CSE-MsgGUID: tru8nSpATcafRTdDojd5mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6175887"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 08:15:44 -0800
Date: Mon, 2 Nov 2026 08:15:43 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 3/6] perf/x86/intel/pt: Stop tracing at syscore shutdown
Message-ID: <aui3L0ppW-cBBo1W@tassilo>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-4-adrian.hunter@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102074039.26983-4-adrian.hunter@intel.com>

> +
> +/*
> + * Tracing must not continue into a kexec'ed kernel, which may reuse the
> + * trace buffer memory, so stop tracing on all CPUs and prevent it from
> + * being started again. Events are left in place, but record nothing more.
> + */
> +static void pt_syscore_shutdown(void *data)
> +{
> +	WRITE_ONCE(pt_shutdown, true);
> +	on_each_cpu(pt_shutdown_cpu, NULL, 1);

I don't think adding more and more broadcast NMIs to the panic path 
is a good idea. It's always a very big hammer and a risky operation
that risks breaking the actual dump. panic reallhy needs to be
simple and reliable, and this is the total opposite.

KVM already does one at least (which I never liked either). At a
minimum please find a way to consolidate those into a single
one (as in have a notifier chain that is called on the target CPU).

But better would be to not do this and find some other way.

How about just passing the PT region as reserved and maybe free
it later after the target kernel had a chance to reinitialize all CPUs?


-Andi
