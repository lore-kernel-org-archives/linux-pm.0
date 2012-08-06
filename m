From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH] ACPI: replace strlen("string") with
 sizeof("string") -1
Date: Mon, 6 Aug 2012 12:21:14 +0200
Message-ID: <20120806102114.GA31404@elf.ucw.cz>
References: <Pine.LNX.4.44L0.1206301023540.29029-100000@netrider.rowland.org>
 <5011F15A.3060007@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5011F15A.3060007@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Vasilyev <pavel@pavlinux.ru>
List-Id: linux-pm@vger.kernel.org

On Thu 2012-07-26 21:39:38, Len Brown wrote:
> ...both give the number of chars in the string
> without the '\0', as strncmp() wants,
> but sizeof() is compile-time.

What about introducing something like streq() to do this
automatically? This is ugly....

#define streq(a, b) ... if (_buildin_constant(b)) ...

?

> -	if (!strncmp(val, "enable", strlen("enable"))) {
> +	if (!strncmp(val, "enable", sizeof("enable") - 1)) {

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
