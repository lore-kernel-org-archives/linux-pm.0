From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Tue, 19 May 2015 13:49:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505191345480.1453-100000@iolanthe.rowland.org>
References: <1432044679-10256-3-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39432 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750865AbbESRtQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 13:49:16 -0400
In-Reply-To: <1432044679-10256-3-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-kernel@vger.kernel.org

On Tue, 19 May 2015, Tomeu Vizoso wrote:

> This function makes less cumbersome to enable runtime PM in a device and
> its descendants.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

I don't see the point of this.  In the scenario you have in mind, are
the device and all its descendants registered by the same
subsystem/driver?  If they are, can't the subsystem/driver code enable
runtime PM for each of them when they are registered, by adding a
single call in the right spot?

If they don't all belong to the same subsystem/driver, who is going to 
call your pm_runtime_enable_recursive routine?  No single caller will 
have the right to enable runtime PM for all these devices.

Alan Stern

