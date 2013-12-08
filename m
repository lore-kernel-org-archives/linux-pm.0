From: Len Brown <lenb@kernel.org>
Subject: Re: 50 Watt idle power regression bisected to Linux-3.10
Date: Sun, 8 Dec 2013 15:40:08 -0500
Message-ID: <CAJvTdKn_2mihtMLiQVNCOp_zokx8CsSr2c5NhbkbfJ-qvma-8Q@mail.gmail.com>
References: <CAJvTdK=+aNN66mYpCGgbHGCHhYQAKx-vB0kJSWjVpsNb_hOAtQ@mail.gmail.com>
	<1386478624.4748.19.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386478624.4748.19.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Galbraith <bitbucket@online.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Eder <jeder@redhat.com>, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

> FWIW, my little x3550 (E5620) box is spending ~99% of its time in C3 per
> powertop, deepest state it has.

Please run turbostat, which always describes what the hardware does.
Depending on the version of powertop and the hardware involved,
it may be describing that the OS requested -- which is not always the same.

The hardware reserves the right to demote any requested C-state to a
shallower one.  Also, it is the hardware decision whether to promote
core c-states requested by the OS into power saving package C-states.

cheers,
Len Brown, Intel Open Source Technology Center
