From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Allow runtime suspend during system resume
Date: Fri, 10 Jan 2014 14:35:11 +0100
Message-ID: <2073478.g5B0SjSvHB@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1401091015200.1493-100000@iolanthe.rowland.org> <3652290.QccRAxIbQ5@vostro.rjw.lan> <52CF52FA.3030001@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55845 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751303AbaAJNVU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2014 08:21:20 -0500
In-Reply-To: <52CF52FA.3030001@ubuntu.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thursday, January 09, 2014 08:55:06 PM Phillip Susi wrote:
> On 01/09/2014 08:25 PM, Rafael J. Wysocki wrote:
> > That looks reasonable, but in .resume_early() you can do it like
> > this I think:
> >
> > bool disk_spinning = disk_is_spinning(dev); int rc = 0;
> >
> > if (!pm_runtime_in_use(dev) && !disk_spinning) {
> > pm_runtime_set_suspended(dev); } else {
> > pm_runtime_set_active(dev); if (!disk_spinning) rc =
> > spin_up_the_disk(dev); }
> 
> You're not allowed to call pm_runtime_set_{suspended,active} without
> disabling runtime pm.

Well, thanks for reminding me how my code works. ;-)

.resume_early() runs with runtime PM disabled.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
