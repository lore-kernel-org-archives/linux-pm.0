From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM-Trace: add pm-trace support for suspending phase
Date: Wed, 11 Feb 2015 16:25:47 +0100
Message-ID: <5368734.2g4GXN33HR@vostro.rjw.lan>
References: <54DB6A81.3040706@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63623 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752185AbbBKPCl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 10:02:41 -0500
In-Reply-To: <54DB6A81.3040706@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wednesday, February 11, 2015 10:43:13 PM Fu, Zhonghui wrote:
> From 2626594c03ca3b9884dd44073385c36f99a3651d Mon Sep 17 00:00:00 2001
> From: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> Date: Wed, 11 Feb 2015 16:20:21 +0800
> Subject: [PATCH] PM-Trace: add pm-trace support for suspending phase

Can you please avoid putting the above header lines into your patches?

The only one that may be necessary is the From: line, but that's only
needed if you submit from a different address.

Also please don't send To: mailing lists.  Use CC instead.  In fact, there
should be *one* address in the To: field when you're submitting a patch:
The address of the maintainer you want to apply the patch for you.

> Occasionally, the system can't come back up after suspend/resume
> due to problems of device suspending phase. This patch make
> PM_TRACE infrastructure cover device suspending phase of
> suspend/resume process, and the information in RTC can tell
> developers which device suspending function make system hang.

Do you have any examples of when this helped and no other debug methods did?

It seems odd to me that no one has ever asked for this for several years and
now you need it.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
