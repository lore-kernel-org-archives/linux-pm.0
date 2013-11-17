From: Borislav Petkov <bp@alien8.de>
Subject: Re: 3.12: kernel panic when resuming from suspend to RAM (x86_64)
Date: Sun, 17 Nov 2013 23:46:21 +0100
Message-ID: <20131117224621.GR27323@pd.tnic>
References: <52888F6D.6000802@gmail.com>
 <CAC9WiBggfssh+31_MqVCT-hDf2E8zTuc81q-DhLYQuVF053mEA@mail.gmail.com>
 <20131117220611.GQ27323@pd.tnic>
 <4636530.OR894YNbbr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:48200 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab3KQWqx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 17 Nov 2013 17:46:53 -0500
Content-Disposition: inline
In-Reply-To: <4636530.OR894YNbbr@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Francis Moreau <francis.moro@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>

On Sun, Nov 17, 2013 at 11:34:20PM +0100, Rafael J. Wysocki wrote:
> This looks like a softirq bug to me (and related to cpuidle).

Reportedly, it happens right after resume from RAM. Francis, is that
correct?

> I'm wondering if that happens with any of the older kernels or just
> 3.12?

That could be helpful, yeah.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
