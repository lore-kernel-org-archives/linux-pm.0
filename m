From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / OPP: pass cpumask by reference
Date: Sun, 1 May 2016 12:01:45 +0200
Message-ID: <20160501100145.GF14243@amd>
References: <1462016049-1976580-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40995 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbcEAKBs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 May 2016 06:01:48 -0400
Content-Disposition: inline
In-Reply-To: <1462016049-1976580-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <vireshk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat 2016-04-30 13:33:29, Arnd Bergmann wrote:
> The new use of dev_pm_opp_set_sharing_cpus resulted in a harmless compiler
> warning with CONFIG_CPUMASK_OFFSTACK=y:
> 
> drivers/cpufreq/mvebu-cpufreq.c: In function 'armada_xp_pmsu_cpufreq_init':
> include/linux/cpumask.h:550:25: error: passing argument 2 of 'dev_pm_opp_set_sharing_cpus' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> 
> The problem here is that cpumask_var_t gets passed by reference, but
> by declaring a 'const cpumask_var_t' argument, only the pointer is
> constant, not the actual mask. This is harmless because the function
> does not actually modify the mask.
> 
> This patch changes the function prototypes for all of the related functions
> to pass a 'struct cpumask *' instead of 'cpumask_var_t', matching what
> most other such functions do in the kernel. This lets us mark all the
> other similar functions as taking a 'const' mask where possible,
> and it avoids the warning without any change in object code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 947bd567f7a5 ("mvebu: Use dev_pm_opp_set_sharing_cpus() to
mark OPP tables as shared")

Acked-by: Pavel Machek <pavel@ucw.cz>

(Hiding pointer into cpumask_var_t looks wrong to me, regardless of
const issues).


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
