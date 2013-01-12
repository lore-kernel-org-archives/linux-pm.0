From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hibernation fails from kexec'ed kernel
Date: Sat, 12 Jan 2013 18:26:27 +0100
Message-ID: <50F19CC3.9060104@gmail.com>
References: <50F18577.3030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:40772 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab3ALR0a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Jan 2013 12:26:30 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so819190eaa.39
        for <linux-pm@vger.kernel.org>; Sat, 12 Jan 2013 09:26:29 -0800 (PST)
In-Reply-To: <50F18577.3030506@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>

On 01/12/2013 04:47 PM, Jiri Slaby wrote:
> Hi,
> 
> when I try to hibernate and resume from a kexec'ed kernel, the resume
> fails with:
> PM: Image not found (code -22)
> 
> I dumped sig and orig_sig from swsusp_check and it looks like this:
> 53 57 41 50 53 50 41 43 45 32                    SWAPSPACE2
> 53 57 41 50 53 50 41 43 45 32                    SWAPSPACE2
> 
> So it looks like the image (or only the signature) did not land to the disk.

Note that I see "PM: S|" and the error returned from mark_swapfiles is 0.

> I use only the in-kernel hibernation, I do not even have the suspend
> package installed. This is with 3.7.2 and happens this way for some time
> already. When I boot the kernel normally, hib+resume works just fine.
> 
> Any ideas?
> 
> thanks,
-- 
js
