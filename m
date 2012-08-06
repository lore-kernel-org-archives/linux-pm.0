From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] ACPI: replace strlen("string") with sizeof("string") -1
Date: Mon, 06 Aug 2012 12:26:58 +0200
Message-ID: <m2wr1cz571.fsf@igel.home>
References: <Pine.LNX.4.44L0.1206301023540.29029-100000@netrider.rowland.org>
	<5011F15A.3060007@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5011F15A.3060007@kernel.org> (Len Brown's message of "Thu, 26
	Jul 2012 21:39:38 -0400")
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Vasilyev <pavel@pavlinux.ru>
List-Id: linux-pm@vger.kernel.org

Len Brown <lenb@kernel.org> writes:

> ...both give the number of chars in the string
> without the '\0', as strncmp() wants,
> but sizeof() is compile-time.

Does this actually change anything?  The compiler is able to expand
strlen at compile time if the argument is a constant, provided that that
builtin strlen isn't disabled.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
