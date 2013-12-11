From: Len Brown <lenb@kernel.org>
Subject: Re: 50 Watt idle power regression bisected to Linux-3.10
Date: Wed, 11 Dec 2013 16:43:22 -0500
Message-ID: <CAJvTdKm5sdT8R-DNGNWyebTKYDqP49dQMds9++TkF=aF8O=V7Q@mail.gmail.com>
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
	<20131211115239.GA21999@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37798 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab3LKVnX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2013 16:43:23 -0500
In-Reply-To: <20131211115239.GA21999@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <bitbucket@online.de>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Eder <jeder@redhat.com>, x86@kernel.org

For the record...

intel_idle doesn't check that bit because it doesn't run on model 29 --
the Xeon 7400 was the "Dunnington" 4-socket generation based on Core2.
Until now, i was not aware that this issue might apply to models other
than that one.

Checking w/ the HW guys...

thanks,
Len Brown, Intel Open Source Technology Center
