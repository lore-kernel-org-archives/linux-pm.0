From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86: Calculate MHz using APERF/MPERF for cpuinfo and
 scaling_cur_freq
Date: Sun, 24 Apr 2016 18:38:49 +0200
Message-ID: <20160424163849.GG8880@amd>
References: <6e0c25e64e0fb65a42dfc63ad5f660302e07cd87.1459485198.git.len.brown@intel.com>
 <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34897 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbcDXQiw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Apr 2016 12:38:52 -0400
Content-Disposition: inline
In-Reply-To: <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

Hi!
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -0,0 +1,76 @@
> +/*
> + * x86 APERF/MPERF KHz calculation
> + * Used by /proc/cpuinfo and /sys/.../cpufreq/scaling_cur_freq

Could we use some shorter filename here? cpu_mhz.c? mhz.c?

> +/*
> + * aperfmperf_snapshot_khz()


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
