From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Bisected] 3.7-rc1 can't resume (still present in 3.9)
Date: Mon, 15 Jul 2013 14:11:50 -0700
Message-ID: <51E46596.9050702@zytor.com>
References: <20130218155439.GA902@onny> <201305031515.55595.jarkko.sakkinen@intel.com> <20130708095042.GA20797@onny.Speedport_W_700V> <3442698.l2vNEGx5aV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:44901 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754991Ab3GOVMO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Jul 2013 17:12:14 -0400
In-Reply-To: <3442698.l2vNEGx5aV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jonas Heinrich <onny@project-insanity.org>, Jarkko Sakkinen <jarkko.sakkinen@intel.com>, len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 07/08/2013 06:05 AM, Rafael J. Wysocki wrote:
> 
> That's because no one knows how to fix it.  Actually, we don't even know
> what the root cause of it is.  Sorry about that.
> 
> Are you still able to make things work again by reverting the commit you
> bisected to?
> 

Well, we know now.   Hopefully we should have the fix in 3.11-rc2 and
then on its way to stable.

	-hpa


