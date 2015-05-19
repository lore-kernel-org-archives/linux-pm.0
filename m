From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Wed, 20 May 2015 01:39:25 +0200
Message-ID: <26522847.rzj8GpQKux@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1505191345480.1453-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56435 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751714AbbESXOF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 19:14:05 -0400
In-Reply-To: <Pine.LNX.4.44L0.1505191345480.1453-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-kernel@vger.kernel.org

On Tuesday, May 19, 2015 01:49:15 PM Alan Stern wrote:
> On Tue, 19 May 2015, Tomeu Vizoso wrote:
> 
> > This function makes less cumbersome to enable runtime PM in a device and
> > its descendants.
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> I don't see the point of this.  In the scenario you have in mind, are
> the device and all its descendants registered by the same
> subsystem/driver?  If they are, can't the subsystem/driver code enable
> runtime PM for each of them when they are registered, by adding a
> single call in the right spot?
> 
> If they don't all belong to the same subsystem/driver, who is going to 
> call your pm_runtime_enable_recursive routine?  No single caller will 
> have the right to enable runtime PM for all these devices.

Agreed.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
