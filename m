From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ktime_get_ts64() splat during resume
Date: Tue, 21 Jun 2016 13:36:20 +0200
Message-ID: <7262967.4GkIktYpLq@vostro.rjw.lan>
References: <20160617105435.GB15997@pd.tnic> <1540485.MOmcxrPnr8@vostro.rjw.lan> <96a692a0-08eb-6d64-d396-82bee5d7a0a1@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47372 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751369AbcFULfm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 07:35:42 -0400
In-Reply-To: <96a692a0-08eb-6d64-d396-82bee5d7a0a1@deltatee.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

On Monday, June 20, 2016 10:35:16 PM Logan Gunthorpe wrote:
> Hey Rafael,

Hi,

> This patch appears to be working on my laptop. Thanks.

Thanks for the confirmation!

Rafael

