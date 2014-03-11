From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] PM: Add missing "freeze" state
Date: Tue, 11 Mar 2014 15:51:01 +0530
Message-ID: <531EE38D.7070105@linux.vnet.ibm.com>
References: <1394532270-4101-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:41504 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbaCKKVn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Mar 2014 06:21:43 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 11 Mar 2014 15:51:40 +0530
In-Reply-To: <1394532270-4101-1-git-send-email-geert@linux-m68k.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

On 03/11/2014 03:34 PM, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

While at it, can you also fix up the comment over the state_show()
function in kernel/power/main.c? It is also similarly outdated.

Regards,
Srivatsa S. Bhat

> ---
>  Documentation/ABI/testing/sysfs-power |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index 205a73878441..64c9276e9421 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -12,8 +12,9 @@ Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
>  Description:
>  		The /sys/power/state file controls the system power state.
>  		Reading from this file returns what states are supported,
> -		which is hard-coded to 'standby' (Power-On Suspend), 'mem'
> -		(Suspend-to-RAM), and 'disk' (Suspend-to-Disk).
> +		which is hard-coded to 'freeze' (Low-Power Idle), 'standby'
> +		(Power-On Suspend), 'mem' (Suspend-to-RAM), and 'disk'
> +		(Suspend-to-Disk).
> 
>  		Writing to this file one of these strings causes the system to
>  		transition into that state. Please see the file
> 

