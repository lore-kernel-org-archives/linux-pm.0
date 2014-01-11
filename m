From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT] APM
Date: Sat, 11 Jan 2014 01:30:52 +0100
Message-ID: <4411503.NlcLOtbZPZ@vostro.rjw.lan>
References: <alpine.LNX.2.00.1401101148220.9087@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53182 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751263AbaAKARA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2014 19:17:00 -0500
In-Reply-To: <alpine.LNX.2.00.1401101148220.9087@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, January 10, 2014 11:50:08 AM Jiri Kosina wrote:
> Rafael,
> 
> please consider pulling
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jikos/apm.git for-next
> 
> into linux-pm.git, to receive:
> 
> 
> - addition of hibernation events to apm-emulation, from Bin Shi
> 
> 
> Thanks.
> 
> Bin Shi (1):
>       apm-emulation: add hibernation APM events to support suspend2disk
> 
>  drivers/char/apm-emulation.c  |   11 +++++++++--
>  include/uapi/linux/apm_bios.h |    2 ++
>  2 files changed, 11 insertions(+), 2 deletions(-)

Pulled, thanks Jiri!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
