From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] PM / Runtime: Replace
Date: Sat, 2 Mar 2013 10:50:08 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1303021046530.11936-100000@netrider.rowland.org>
References: <loom.20130302T123529-697@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:53343 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752132Ab3CBPuJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Mar 2013 10:50:09 -0500
In-Reply-To: <loom.20130302T123529-697@post.gmane.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: swapnil <swapnil.tiwari1979@gmail.com>
Cc: linux-pm@vger.kernel.org

On Sat, 2 Mar 2013, swapnil wrote:

> let me know what triggers the pm core to call idle method where in the code this 
> is happening

It happens in several places in drivers/base/power/runtime.c.  
rpm_idle() is called by rpm_suspend(), rpm_resume(), pm_runtime_work(),
__pm_runtime_idle(), pm_runtime_allow(), and update_autosuspend().

Alan Stern

