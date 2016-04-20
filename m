From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 1/2] perf/x86/intel/rapl: support Skylake RAPL domains
Date: Wed, 20 Apr 2016 17:43:20 +0200
Message-ID: <20160420154320.GE3408@twins.programming.kicks-ass.net>
References: <1460930581-29748-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1460930581-29748-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38243 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbcDTPnk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 11:43:40 -0400
Content-Disposition: inline
In-Reply-To: <1460930581-29748-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, x86@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com, linux-pm@vger.kernel.org

On Sun, Apr 17, 2016 at 03:03:00PM -0700, Srinivas Pandruvada wrote:
> @@ -729,6 +771,11 @@ static int __init rapl_pmu_init(void)
>  		rapl_cntr_mask = RAPL_IDX_SRV;
>  		rapl_pmu_events_group.attrs = rapl_events_srv_attr;
>  		break;
> +	case 78: /* Skylake client */
> +	case 94: /* Skylake H/S */
> +		rapl_cntr_mask = RAPL_IDX_SKL_CLN;
> +		rapl_pmu_events_group.attrs = rapl_events_skl_attr;
> +		break;
>  	case 87: /* Knights Landing */
>  		apply_quirk = true;
>  		rapl_cntr_mask = RAPL_IDX_KNL;

Please post this against tip/perf/core, all this code got munged in
patch:

  4b6e2571bf00 ("x86/perf/intel/rapl: Make the Intel RAPL PMU driver modular")

Also; what about 85 (skl-server)?
