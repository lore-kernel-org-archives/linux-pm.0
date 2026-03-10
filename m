Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947B40DFA5;
	Tue, 10 Mar 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152912; cv=none; b=TqXuqhxtgn7UZInW9+6hwhcNYYd4YMoZdK15uF/26mZ47QGUJHxpEdaOTIRe6675SwXbFdJzcFNRjfI67g/6MGkVDXEZgarbMiUs4Dm6TlfY4XU614drTmrwuCKsXuCSOpXFQpOxk4E7IAhES2s7OccKgJpq8SdogZwJ5KOhAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152912; c=relaxed/simple;
	bh=SSDg6dDCGOUtLMYGnRvPaYvDxdpxGMXM75KaN0cQERA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtVg71q77ALcGi75Eoc7WD4brHT12jyDXa30W/sLNG4yt3+OYqZuVydNWXjm3dlU0W5JIkmxCM57K1DA9kXN2J/BGG6O+t3rcnhbJ7ekokBiqgJNZBjGqOOnQ/1JoCQ6sgc/zdljPUgHuJ/0i8jaFd+NYOemNyeYndnqrPglpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAJWK2GU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAJWK2GU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E78C19423;
	Tue, 10 Mar 2026 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773152912;
	bh=SSDg6dDCGOUtLMYGnRvPaYvDxdpxGMXM75KaN0cQERA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAJWK2GUwpuPAJdYg0nf7gHHhsPmegEgKJyni5sQybtoyoFaOplQVMzGy9s4gsHMK
	 eEE+hTmBM+dLcLkvz/aQPm/Plc1y933YSuAXJWfAUCBys4fzmYnt4a+AafLQn957+Z
	 0y9ncO072bFP103Lh264vfdAh909laadzzc+yN4IoB+Uc0C7wqUgjXNfgveepQizEJ
	 LWv5fGfd5aXQuCknMZeYjDFVFHGxStPbpqYjzmCMhOg+Cl/rrYXypqs6jjymryCOW/
	 Js74maP4zn2qyBUP1Xv3v6+sNur4GPKS0Xd56YvuqzzyUjwHas4X0tG70SbcoPi6UV
	 lJFaOKlztR2aA==
Date: Tue, 10 Mar 2026 15:28:29 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Qais Yousef <qyousef@layalina.io>,
	Christian Loehle <christian.loehle@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v1] sched: idle: Make skipping governor callbacks more
 consistent
Message-ID: <abAqjS39Je9AFo8U@localhost.localdomain>
References: <20260301191959.406218221@kernel.org>
 <CAJZ5v0h-bGU34d9OnhYqdzz+5UiKV1rBEB9NS-TL4=sK2jf-LQ@mail.gmail.com>
 <20260304030306.uk5c63xw4oqvjffb@airbuntu>
 <12857700.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12857700.O9o76ZdvQC@rafael.j.wysocki>

Le Sat, Mar 07, 2026 at 05:12:05PM +0100, Rafael J. Wysocki a écrit :
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the cpuidle governor .select() callback is skipped because there
> is only one idle state in the cpuidle driver, the .reflect() callback
> should be skipped as well, at least for consistency (if not for
> correctness), so do it.
> 
> Fixes: e5c9ffc6ae1b ("cpuidle: Skip governor when only one idle state is available")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
