From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/6 v4] cpufreq: tolerate inexact values when collecting
 stats
Date: Sun, 11 Nov 2012 17:38:24 +0100
Message-ID: <20121111163821.GA21635@x1.osrc.amd.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1352313166-28980-1-git-send-email-mark.langsdorf@calxeda.com>
 <1352313166-28980-4-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:45762 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235Ab2KKQiU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 11 Nov 2012 11:38:20 -0500
Content-Disposition: inline
In-Reply-To: <1352313166-28980-4-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@gmail.com>

On Wed, Nov 07, 2012 at 12:32:43PM -0600, Mark Langsdorf wrote:
> When collecting stats, if a frequency doesn't match the table, go through
> the table again with both the search frequency and table values shifted
> left by 10 bits.

Why would that second pass succeed?

And why is this in generic code (I'm assuming this is a Calxeda-specific
case)?

-- 
Regards/Gruss,
Boris.
