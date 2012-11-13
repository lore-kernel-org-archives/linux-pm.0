From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/6 v4] cpufreq: tolerate inexact values when collecting
 stats
Date: Tue, 13 Nov 2012 17:24:49 +0100
Message-ID: <20121113162449.GE9327@x1.osrc.amd.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1352313166-28980-1-git-send-email-mark.langsdorf@calxeda.com>
 <1352313166-28980-4-git-send-email-mark.langsdorf@calxeda.com>
 <20121111163821.GA21635@x1.osrc.amd.com>
 <50A12565.4070701@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:38974 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108Ab2KMQYf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Nov 2012 11:24:35 -0500
Content-Disposition: inline
In-Reply-To: <50A12565.4070701@calxeda.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@gmail.com>

On Mon, Nov 12, 2012 at 10:35:49AM -0600, Mark Langsdorf wrote:
> The function is buried pretty deep in the cpufreq_stat code. It didn't
> seem appropriate to make it a function pointer as part of struct
> cpufreq_driver.

Right, what's cpufreq-speak for

	if (Calxeda)
		shift by 10

?

Better yet, add a flag or a bitfield called "minimize_jitter" or similar
and set it only on your hardware...

Thanks.

-- 
Regards/Gruss,
Boris.
