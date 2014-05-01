From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] tools/power turbostat: Drop temperature checks
Date: Thu, 01 May 2014 04:12:51 -0700
Message-ID: <53622C33.9090100@roeck-us.net>
References: <20140501114019.1a63728e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:60890 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224AbaEALMz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 May 2014 07:12:55 -0400
In-Reply-To: <20140501114019.1a63728e@endymion.delvare>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Josh Triplett <josh@joshtriplett.org>

On 05/01/2014 02:40 AM, Jean Delvare wrote:
> The Intel 64 and IA-32 Architectures Software Developer's Manual says
> that TjMax is stored in bits 23:16 of MSR_TEMPERATURE TARGET (0x1a2).
> That's 8 bits, not 7, so it must be masked with 0xFF rather than 0x7F.
>
> The manual has no mention of which values should be considered valid,
> which kind of implies that they all are. Arbitrarily discarding values
> outside a specific range is wrong. The upper range check had to be
> fixed recently (commit 144b44b1) and the lower range check is just as
> wrong. See bug #75071:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=75071
>
> There are many Xeon processor series with TjMax of 70, 71 or 80
> degrees Celsius, way below the arbitrary 85 degrees Celsius limit.
> There may be other (past or future) models with even lower limits.
>
> So drop this arbitrary check. The only value that would be clearly
> invalid is 0. Everything else should be accepted.
>
> After these changes, turbostat is aligned with what the coretemp
> driver does.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Josh Triplett <josh@joshtriplett.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

