From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: 50 Watt idle power regression bisected to Linux-3.10
Date: Wed, 11 Dec 2013 12:52:39 +0100
Message-ID: <20131211115239.GA21999@twins.programming.kicks-ass.net>
References: <CAJvTdK=+aNN66mYpCGgbHGCHhYQAKx-vB0kJSWjVpsNb_hOAtQ@mail.gmail.com>
 <1386478624.4748.19.camel@marge.simpson.net>
 <CAJvTdKn_2mihtMLiQVNCOp_zokx8CsSr2c5NhbkbfJ-qvma-8Q@mail.gmail.com>
 <1386559014.4875.16.camel@marge.simpson.net>
 <1386652637.5374.72.camel@marge.simpson.net>
 <alpine.DEB.2.02.1312101458040.28330@ionos.tec.linutronix.de>
 <alpine.DEB.2.02.1312110030330.28330@ionos.tec.linutronix.de>
 <1386732093.5964.6.camel@marge.simpson.net>
 <alpine.DEB.2.02.1312111206200.28330@ionos.tec.linutronix.de>
 <20131211113839.GF21683@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54468 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab3LKLwz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2013 06:52:55 -0500
Content-Disposition: inline
In-Reply-To: <20131211113839.GF21683@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <bitbucket@online.de>, Len Brown <lenb@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Eder <jeder@redhat.com>, x86@kernel.org

On Wed, Dec 11, 2013 at 12:38:39PM +0100, Borislav Petkov wrote:
> Right, if it turns out that this is really the case and that this
> erratum hasn't been fixed for models later than 29 - we'd need the
> additional model numbers to set X86_FEATURE_CLFLUSH_MONITOR correctly.

You also need: https://lkml.org/lkml/2013/11/19/143

Because obviously not all mwait idle loops check that cpu bit.
