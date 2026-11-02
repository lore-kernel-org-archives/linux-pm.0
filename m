Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641560;
	b=adKEEIL4TP/vtcHxkbx+sezUlI8mVtkzl+upEAIt3C01AIWwkjP8e/nI3B959+kGeCM9
	 +eHbZ+nseG8qPCdAx3tL7IlxToAi55yLDHwGZS/Ah814BXAa5capcpq5aKvEaNX71JuiU
	 4YszFRQ9EflEL7AOyGgY0szUKMeJmwHa8ufDodeDhj7rBXiDzOcAjs/Uw8rk8nhSc96dy
	 eD+uVvef+qhrD4Wj7uE+VJztf5aHq2qnMKE2s23ATgSlTGoDny6ujRG/JYI4O+KSKbSCH
	 y4fU7nlUgAHayWP77T9OI79m2173RQkN8HwNDex2s6hDEtmg2TEXkEU6uqtJxFhThig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641560;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TyrupP9HlfXQmjG2GxRqzTa9XeQTSyEAkYuFINjOMic=;
	b=2WtcVta65B6iZqqiMQNgFwDWoZLUjgnEb7GpI09PRHX/CRV/4OVLzX0pg+Mcn+t06vDZ
	 rvhevuOfSvUEHTJSkkHGnBiLC+o+sPmVFJah/PgJWvqcCrfp0oMRma2Pl9wUcMLXBw5XE
	 PJ4UIjI4Xj0TDH3eteY9p6syfE3VvNw4k0/PQWiAk9a/XQ6fOnb+hlNW1h98KG6DsSnma
	 6D6I7kGjMeWLQ7T7HRes66otowRBl1iBXgKSOpE2cEGbKBAu+aCvzJ66oUESFDKoyEp1D
	 yMrSP+lYoYA3AGYO//bOvKqhk6PAdUvYLx9xNKytcZ/7ua2bLKzo+gFP/kxhBXhF+dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BPnU6XEl;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDFD6074661;
	Mon,  2 Nov 2026 17:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FDFD6074661
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BPnU6XEl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793641560; x=1825177560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uD19Fb5fdpt/7jRuUUbcNI5DvCbhjKMzTNkgHXyTE6c=;
  b=BPnU6XEl1kh0Y/qMRSmaNZOmNTZIaGTVL9fysGDicJI/X/Y5w1dphxAR
   /XdvVOEGSkt7XmfKt1KSzEo5QFJ/vWOGepf5KOBuXgN480TuZjh0OdqCd
   aAh7TkEnKZMHhJmnLkUgptBdfqPkc+ZfBGZtAmtMrfhG0PkW64Cxyit9n
   l2vh3E5B79iw9RMv8uWB9aOqQ4MO1vdhqhfu5n0S6q9C9L2nlpXZYMk5Y
   Trif07gQLglFL/Wr0TOe389pJRzEAIDfBCPf4Kkil1PMMddQc0J+F2R5r
   L4HyrmasjwtOZ3pqVfYXyuu5C0L1Hp4Ol/U4DpK8DVietJsLsbJiUNtag
   A==;
X-CSE-ConnectionGUID: VCUdeNORSoW6n4OpJ6sCJA==
X-CSE-MsgGUID: fOQ4b7/4QimON8Ob+7cHyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2375573"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2375573"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:45:59 -0800
X-CSE-ConnectionGUID: hzN+wRsuQ6+Zf5DjyDJwTg==
X-CSE-MsgGUID: wfp7iaEFQUa/aOEfGKH1AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6570948"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:45:58 -0800
Date: Mon, 2 Nov 2026 09:45:56 -0800
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
Message-ID: <aujMVC0_8purXK5k@tassilo>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-4-adrian.hunter@intel.com>
 <aui3L0ppW-cBBo1W@tassilo>
 <a2108322-0c88-48e0-a10f-77ae2556bcae@intel.com>
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
In-Reply-To: <a2108322-0c88-48e0-a10f-77ae2556bcae@intel.com>

On Mon, Nov 02, 2026 at 06:27:30PM +0200, Adrian Hunter wrote:
> On 02/11/2026 18:15, Andi Kleen wrote:
> >> +
> >> +/*
> >> + * Tracing must not continue into a kexec'ed kernel, which may reuse the
> >> + * trace buffer memory, so stop tracing on all CPUs and prevent it from
> >> + * being started again. Events are left in place, but record nothing more.
> >> + */
> >> +static void pt_syscore_shutdown(void *data)
> >> +{
> >> +	WRITE_ONCE(pt_shutdown, true);
> >> +	on_each_cpu(pt_shutdown_cpu, NULL, 1);
> > 
> > I don't think adding more and more broadcast NMIs to the panic path 
> > is a good idea. It's always a very big hammer and a risky operation
> > that risks breaking the actual dump. panic reallhy needs to be
> > simple and reliable, and this is the total opposite.
> 
> Is pt_syscore_shutdown() called on a panic path?  I can't find a way.

It's called from kexec which can be called from panic.

> 
> > 
> > KVM already does one at least (which I never liked either). At a
> > minimum please find a way to consolidate those into a single
> > one (as in have a notifier chain that is called on the target CPU).
> > 
> > But better would be to not do this and find some other way.
> > 
> > How about just passing the PT region as reserved and maybe free
> > it later after the target kernel had a chance to reinitialize all CPUs?
> 
> Intel PT has cpu_emergency_stop_pt().

?
