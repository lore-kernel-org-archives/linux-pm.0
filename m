From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/5] cpufreq:boost:Kconfig: Enable boost support at
 Kconfig
Date: Thu, 6 Jun 2013 17:58:15 +0200
Message-ID: <20130606155815.GB21272@pd.tnic>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1370502472-7249-6-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:57740 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab3FFP6b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 6 Jun 2013 11:58:31 -0400
Content-Disposition: inline
In-Reply-To: <1370502472-7249-6-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Thu, Jun 06, 2013 at 09:07:52AM +0200, Lukasz Majewski wrote:
> Enable/disable support for BOOST. New flag - CPU_FREQ_BOOST has been
> defined for that.

What's the reason for this? Why would you want to not compile-in the
boosting code?

Also, at least on x86, even with this feature disabled, the CPU will
boost by default unless you fiddle with it through the MSRs as root.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
