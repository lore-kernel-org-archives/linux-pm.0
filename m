From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Question about runtime pm status issue
Date: Mon, 29 Oct 2012 22:50:37 +0800
Message-ID: <CACVXFVOV2JBvPj-AnOYo6HELCYDthOfM1Qb54=BezNAikfL9OA@mail.gmail.com>
References: <508E889C.6070009@gmail.com>
	<CACVXFVMZi7_uSsL0_0Sc=Nmkc4OMwogtiRB3v=uJY2LF1UYS3A@mail.gmail.com>
	<508E95FA.5070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:55156 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab2J2Oui (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Oct 2012 10:50:38 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1731735eaa.19
        for <linux-pm@vger.kernel.org>; Mon, 29 Oct 2012 07:50:37 -0700 (PDT)
In-Reply-To: <508E95FA.5070906@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Mon, Oct 29, 2012 at 10:43 PM, Lan Tianyu <lantianyu1986@gmail.com> wrote:

> I have umount the disk and there is no user of the device since its
> usage_count
> become zero.

Looks runtime PM of usb mass storage works well on my box with
3.7.0-rc3-next-20121029, maybe you can enable trace event on
runtime PM to see what happened.


Thanks
-- 
Ming Lei
