From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] make kASLR vs hibernation boot-time selectable
Date: Mon, 16 Jun 2014 01:04:42 +0200
Message-ID: <1565726.7T8Lt3Xc6J@vostro.rjw.lan>
References: <1402602419-27934-1-git-send-email-keescook@chromium.org> <13135927.OjVm86GPrt@vostro.rjw.lan> <539C7B2F.9070800@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62844 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751033AbaFOWrL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 15 Jun 2014 18:47:11 -0400
In-Reply-To: <539C7B2F.9070800@zytor.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, Len Brown <len.brown@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-pm@vger.kernel.org

On Saturday, June 14, 2014 09:41:19 AM H. Peter Anvin wrote:
> On 06/13/2014 05:39 PM, Rafael J. Wysocki wrote:
> >  
> > -#define RESTORE_MAGIC	0x0123456789ABCDEFUL
> > +#define RESTORE_MAGIC	0x0123456789ABCDF0UL
> >  
> 
> <bikeshed>
> 
> Please don't pick numbers like this for magic numbers... *everyone else
> does, too.*  In general, picking a random number is a good starting
> point; for extra bonus make sure it has at least one invalid UTF-8
> sequence in it (so it cannot be confused with either ASCII or UTF-8 text.)
> 
> </bikeshed>

OK, when we find out how to make hibernation work with the address space
randomization.

Rafael

