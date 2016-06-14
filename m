From: Sumit Singh <sumsingh@nvidia.com>
Subject: RE: Need help : Way to disable runtime PM with system suspend enabled
Date: Tue, 14 Jun 2016 08:44:30 +0000
Message-ID: <44bf41112ac543cfa2642076386a6aa1@bgmail103.nvidia.com>
References: <d5f4566ed9f84a0e8840402bbac6b780@bgmail103.nvidia.com>
 <Pine.LNX.4.44L0.1606101043360.1615-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17571 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbcFNIog convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2016 04:44:36 -0400
In-Reply-To: <Pine.LNX.4.44L0.1606101043360.1615-100000@iolanthe.rowland.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, Bharat Nihalani <bnihalani@nvidia.com>

Thanks Alan. I am trying with the approach that you suggested.

Thanks
Sumit Singh

-----Original Message-----
From: Alan Stern [mailto:stern@rowland.harvard.edu] 
Sent: Friday, June 10, 2016 8:28 PM
To: Sumit Singh
Cc: Rafael J. Wysocki; rjw@rjwysocki.net; linux-pm@vger.kernel.org; Prashant Gaikwad; Bharat Nihalani
Subject: RE: Need help : Way to disable runtime PM with system suspend enabled

On Fri, 10 Jun 2016, Sumit Singh wrote:

> Thanks Rafael for the suggestion. I will try with that.
> Using pm_runtime_forbid() API, we can do that. Could you please suggest a proper location for using this API, so that it is applicable to all the devices?

If you want to change the kernel, you can change the definition of
pm_runtime_allow() in drivers/base/power/runtime.c.  Just have the routine return immediately.  You should also change pm_runtime_init() by adding a call to pm_runtime_forbid(dev) at the end.

If you want to change userspace, you can add a udev rule that writes "on" to the power/control file for each new device.  But the user could override this later on, so it wouldn't be as safe as changing the kernel.

Alan Stern

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
