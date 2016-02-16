From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 13/15] PM / Hibernate: Call flush_icache_range() on pages restored in-place
Date: Tue, 16 Feb 2016 20:27:18 +0100
Message-ID: <2881465.GhJSKR2Hdf@vostro.rjw.lan>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com> <1455637767-31561-14-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41475 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755027AbcBPTZ4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 14:25:56 -0500
In-Reply-To: <1455637767-31561-14-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

On Tuesday, February 16, 2016 03:49:25 PM James Morse wrote:
> Some architectures require code written to memory as if it were data to be
> 'cleaned' from any data caches before the processor can fetch them as new
> instructions.
> 
> During resume from hibernate, the snapshot code copies some pages directly,
> meaning these architectures do not get a chance to perform their cache
> maintenance. Modify the read and decompress code to call
> flush_icache_range() on all pages that are restored, so that the restored
> in-place pages are guaranteed to be executable on these architectures.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

This is fine by me.

Please feel free to add my ACK to it if that helps.

Thanks,
Rafael

