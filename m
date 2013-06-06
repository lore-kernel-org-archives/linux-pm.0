From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 1/3] cpufreq: ondemand: Change the calculation of
 target frequency
Date: Thu, 6 Jun 2013 15:15:23 +0200
Message-ID: <20130606131523.GE21181@pd.tnic>
References: <fqrv6c2yk2ebwb4182ect77d.1370523260717@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34334 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587Ab3FFNPl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 6 Jun 2013 09:15:41 -0400
Content-Disposition: inline
In-Reply-To: <fqrv6c2yk2ebwb4182ect77d.1370523260717@email.android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org

Please do not top-post.

On Thu, Jun 06, 2013 at 03:54:20PM +0300, Stratos Karafotis wrote:
> I will try to provide the requested info (although, I'm not sure how
> to measure total energy :) )

tools/power/x86/turbostat looks like a good tool. It can show, a.o.,
power consumption in Watts on modern Intels and other interesting stuff.

HTH.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
