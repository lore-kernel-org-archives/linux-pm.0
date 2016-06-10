From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: Need help : Way to disable runtime PM with system suspend enabled
Date: Fri, 10 Jun 2016 10:58:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1606101043360.1615-100000@iolanthe.rowland.org>
References: <d5f4566ed9f84a0e8840402bbac6b780@bgmail103.nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38760 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752101AbcFJO6T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 10:58:19 -0400
In-Reply-To: <d5f4566ed9f84a0e8840402bbac6b780@bgmail103.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sumit Singh <sumsingh@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, Bharat Nihalani <bnihalani@nvidia.com>

On Fri, 10 Jun 2016, Sumit Singh wrote:

> Thanks Rafael for the suggestion. I will try with that.
> Using pm_runtime_forbid() API, we can do that. Could you please suggest a proper location for using this API, so that it is applicable to all the devices?

If you want to change the kernel, you can change the definition of 
pm_runtime_allow() in drivers/base/power/runtime.c.  Just have the 
routine return immediately.  You should also change pm_runtime_init() 
by adding a call to pm_runtime_forbid(dev) at the end.

If you want to change userspace, you can add a udev rule that writes 
"on" to the power/control file for each new device.  But the user could 
override this later on, so it wouldn't be as safe as changing the 
kernel.

Alan Stern

