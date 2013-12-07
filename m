From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 50 Watt idle power regression bisected to Linux-3.10
Date: Sat, 7 Dec 2013 13:54:01 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1312071351510.30673@ionos.tec.linutronix.de>
References: <CAJvTdK=+aNN66mYpCGgbHGCHhYQAKx-vB0kJSWjVpsNb_hOAtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34508 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701Ab3LGMyE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 7 Dec 2013 07:54:04 -0500
In-Reply-To: <CAJvTdK=+aNN66mYpCGgbHGCHhYQAKx-vB0kJSWjVpsNb_hOAtQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Eder <jeder@redhat.com>, x86@kernel.org

Len,

On Sat, 7 Dec 2013, Len Brown wrote:
>
> How shall we proceed?

Can you please gather a function trace so I can see what the system is
doing? Preferrably with 3.13-rc3 so we have Peters fix included.

Please send it offlist or put it somehwere for download.

Thanks,

	tglx
