Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C038F62A;
	Fri, 13 Mar 2026 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412443; cv=none; b=UQxMzDhfyZlKypbGGjXqsQt33HRPUrlmlbyggM9VLbUBzoxwNZyi50SWb3J2AzvKtGaqIIm9y3VKwbcXxVfv5CcSmplj2JMOmuo7VAS7A3LamDYI3EgM5HJhEOd34oDy+QHX8YaIKznHyRUzHkgpk/hDTH4vcm17nLrQn6V/3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412443; c=relaxed/simple;
	bh=hLZ3SRfVm6e/5EjVX2oK77nkreaytjdojKEH9KkFrqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTXfCRYmRljKP54elN+oFoCx51fxUTRx2GSqZK9cKmGIuIP9u35hk4K/QqgAYBbOAhmJlWJ3MB86hQMfIarypCedPeTXwZfqjU/QR+hl1kYvQP5ojQVHOXeV0Snm4N5vv3rX4R6kgtEkHAsTqAKw1buklvNGZZZERv8gpuMP8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilrup0md; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilrup0md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FE5C19421;
	Fri, 13 Mar 2026 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773412443;
	bh=hLZ3SRfVm6e/5EjVX2oK77nkreaytjdojKEH9KkFrqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilrup0mdAHvZH3S2B2xcEQTHUxn7P2mcUW+939TtqIDUXP5xmuIYoNFXeDFhLwWX7
	 WaU7SMMNAPUZfd1vLE71s/PBkIp1X3P3rLiZY+axuxsGJjzD6u8CkuvE+XzsdW5WkF
	 fWRGKdh8bl5z1x1ISuO5Ve891WdLgiHZSzsEH2hnuvN4avPeMrZo0vB6I5DbAKWamz
	 LsHROnpY1N/8g8XaErhB28UiV5nxeyvoSi+eZgKC8fDPVgmTbGW8Wapipwqu4k/CXW
	 v6Djrh4FCGWi9V1QPpKIsEc4Kb2+SpohKdcBVdqHAyCekJOfjAtpscT+DGhyKAgFKy
	 RXheru8vhf+aA==
Date: Fri, 13 Mar 2026 15:34:00 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Qais Yousef <qyousef@layalina.io>,
	Christian Loehle <christian.loehle@arm.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v1] sched: idle: Consolidate the handling of two special
 cases
Message-ID: <abQgWDKIdSDDx_3s@localhost.localdomain>
References: <4741364.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4741364.LvFx2qVVIh@rafael.j.wysocki>

Le Fri, Mar 13, 2026 at 01:25:41PM +0100, Rafael J. Wysocki a écrit :
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are two special cases in the idle loop that are handled
> inconsistently even though they are analogous.
> 
> The first one is when a cpuidle driver is absent and the default CPU
> idle time power management implemented by the architecture code is used.
> In that case, the scheduler tick is stopped every time before invoking
> default_idle_call().
> 
> The second one is when a cpuidle driver is present, but there is only
> one idle state in its table.  In that case, the scheduler tick is never
> stopped.
> 
> Since each of these approaches leads to suboptimal choices in some
> cases, reconcile them with the help of one simple heuristic.  Namely,
> stop the tick if the CPU has been woken up by it in the previous
> iteration of the idle loop, or let it tick otherwise.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
