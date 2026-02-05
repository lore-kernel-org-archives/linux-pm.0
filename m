Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF042652A2;
	Thu,  5 Feb 2026 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308707; cv=none; b=U0KpZOB6CbWADS57pg6/b0Z5OWmxNQDNMT+fP7OnNCcsS10zrb0Ygelz4Hh/qXs8TU90qP7vJqhffBlvw/v3yprOQbHmBzK+pv5Syc++xCFWguXT0UGgRVIQCpKak5nDHTWt5XsfWNE1qWf1hpAHOzDBUXb5EfYtXrsbOeynJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308707; c=relaxed/simple;
	bh=84qaqPxEsgHGe/T0FWu7nRcv/Mo+gLApGH55V/x/h2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nF6gVqqlVMfBv7G6Db6S7nQHtX2MmW/LsUH93dNZJl1UTDrv+PlS1rXbWvadg3gN3qy+C3PXB61+0scuzQXaZ8T+EJWqWgkDCYpTRnGPA6cCr9uIA0BJJPgmdKKjhGop2AWpQhcJFn1iCTZGfZOvwmz/thCMjHiRGpQcFpxmnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VmwwKR3q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VmwwKR3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302FDC4CEF7;
	Thu,  5 Feb 2026 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770308707;
	bh=84qaqPxEsgHGe/T0FWu7nRcv/Mo+gLApGH55V/x/h2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmwwKR3qhMK+NrUZRRtgBnryaElNsjTfXIwf6hiaeF2xUzk6pU3m11HhrL2Zbfmfg
	 H0MGa4guLesIM+jh/k1TraxmkmaGG5DVRRZOiHrNzPp65PVsilB2gcqNiaZGitGlIX
	 q1Scf9JAmwufqOJM/FdsAoE9PshyASPwVFts/ARk=
Date: Thu, 5 Feb 2026 17:25:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 6.12] tools/power turbostat: Fix compilation on older
 compilers
Message-ID: <2026020556-deprive-icky-9cd1@gregkh>
References: <20260205155907.1361830-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205155907.1361830-1-kniv@yandex-team.ru>

On Thu, Feb 05, 2026 at 06:59:07PM +0300, Nikolay Kuratov wrote:
> Currently turbostat.c can't be built on pre-gcc-11 compilers
> due to error: a label can only be part of a statement and a declaration
> is not a statement.
> 
> Fix this by adding braces around case labels.
> 
> Fixes: 640540beb883 ("tools/power turbostat: Add MTL's PMT DC6 builtin counter")
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  tools/power/x86/turbostat/turbostat.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index b663a76d31f1..85d40d3c6384 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -2799,7 +2799,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
>  
>  	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
>  		switch (ppmt->type) {
> -		case PMT_TYPE_RAW:
> +		case PMT_TYPE_RAW: {
>  			if (pmt_counter_get_width(ppmt) <= 32)
>  				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
>  						(unsigned int)t->pmt_counter[i]);
> @@ -2807,14 +2807,14 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
>  				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->pmt_counter[i]);
>  
>  			break;
> -
> -		case PMT_TYPE_XTAL_TIME:
> +		}
> +		case PMT_TYPE_XTAL_TIME: {
>  			const unsigned long value_raw = t->pmt_counter[i];
>  			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
>  
>  			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
>  			break;
> -		}
> +		}}
>  	}
>  
>  	/* C1 */
> @@ -2880,7 +2880,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
>  
>  	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
>  		switch (ppmt->type) {
> -		case PMT_TYPE_RAW:
> +		case PMT_TYPE_RAW: {
>  			if (pmt_counter_get_width(ppmt) <= 32)
>  				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
>  						(unsigned int)c->pmt_counter[i]);
> @@ -2888,14 +2888,14 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
>  				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->pmt_counter[i]);
>  
>  			break;
> -
> -		case PMT_TYPE_XTAL_TIME:
> +		}
> +		case PMT_TYPE_XTAL_TIME: {
>  			const unsigned long value_raw = c->pmt_counter[i];
>  			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
>  
>  			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
>  			break;
> -		}
> +		}}
>  	}
>  
>  	fmt8 = "%s%.2f";
> @@ -3079,7 +3079,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
>  
>  	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
>  		switch (ppmt->type) {
> -		case PMT_TYPE_RAW:
> +		case PMT_TYPE_RAW: {
>  			if (pmt_counter_get_width(ppmt) <= 32)
>  				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
>  						(unsigned int)p->pmt_counter[i]);
> @@ -3087,14 +3087,14 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
>  				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->pmt_counter[i]);
>  
>  			break;
> -
> -		case PMT_TYPE_XTAL_TIME:
> +		}
> +		case PMT_TYPE_XTAL_TIME: {
>  			const unsigned long value_raw = p->pmt_counter[i];
>  			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
>  
>  			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
>  			break;
> -		}
> +		}}
>  	}
>  
>  done:
> -- 
> 2.34.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
