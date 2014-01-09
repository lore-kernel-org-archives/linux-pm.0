From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Allow runtime suspend during system resume
Date: Thu, 9 Jan 2014 10:41:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1401091040340.1493-100000@iolanthe.rowland.org>
References: <CAPDyKFrnGvLOQRBKz-V5SsGPNMLXRjSS1iSBPxXj+KW9sMbrRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49124 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751490AbaAIPlR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 10:41:17 -0500
In-Reply-To: <CAPDyKFrnGvLOQRBKz-V5SsGPNMLXRjSS1iSBPxXj+KW9sMbrRA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Phillip Susi <psusi@ubuntu.com>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, 9 Jan 2014, Ulf Hansson wrote:

> Allowing userspace to disable/enable runtime PM, does in many cases
> add complexity to subsystems and drivers when they handle system
> suspend/resume. This seems to be the case for SCSI as well?

No.

> To simplify for these subsystems and drivers, what do you think about
> inventing something like "pm_runtime_sysfs_forbid", which in principle
> will prevent userspace from enable/disable runtime PM? Typically this
> function will be called from ->probe.

I think it is a very bad idea.

Alan Stern

