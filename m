From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 3/8] core: platform: wakeup the parent before trying
 any driver operations
Date: Mon, 25 May 2015 13:36:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505251335350.21019-100000@netrider.rowland.org>
References: <1432570172-86963-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:50365 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750881AbbEYRgo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2015 13:36:44 -0400
In-Reply-To: <1432570172-86963-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Mon, 25 May 2015, Andy Shevchenko wrote:

> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> If the parent is still suspended when a driver probe,
> remove or shutdown is attempted, the result may be a
> failure.
> 
> For example, if the parent is a PCI MFD device that has been
> suspended when we try to probe our device, any register
> reads will return 0xffffffff.
> 
> To fix the problem, making sure the parent is always awake
> before using driver probe, remove or shutdown.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/platform.c | 21 ++++++++++++++++++++-

Why make the changes here rather than in dd.c?  Is there something 
special about platform devices?

Alan Stern

