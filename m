From: Mason <slash.tmp@free.fr>
Subject: Re: Linux panics when suspend cannot offline the secondary cores
Date: Fri, 10 Jun 2016 23:37:42 +0200
Message-ID: <575B3326.1050500@free.fr>
References: <575ADFAC.4090009@free.fr> <2026483.61HqCp9Eli@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:48718 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753274AbcFJViF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jun 2016 17:38:05 -0400
In-Reply-To: <2026483.61HqCp9Eli@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Sebastian Frias <sf84@laposte.net>

On 10/06/2016 23:35, Rafael J. Wysocki wrote:
              ^^^^^

Your clock is 5 minutes ahead ;-)

> On Friday, June 10, 2016 05:41:32 PM Mason wrote:
>
>> I'm playing with S3 Suspend-to-RAM, and I noticed that Linux is really
>> unhappy when the suspend framework fails to offline secondary cores.
>>
>> Is this expected/by design, or could it fail more gracefully?
>> (It could also be something missing in my platform's code.)
> 
> This looks like a CPU offline bug to me which is more general than just
> system suspend.

You may be right, I will try just off-lining cpu1.
Suspend may be a red herring.

By the way, I know my implementation of tango_cpu_die
is incorrect, I was testing the failure mode.

Regards.

