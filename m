From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 1/2] PM / sleep: Add power.direct_complete_default
 flag
Date: Tue, 19 May 2015 13:50:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505191349180.1453-100000@iolanthe.rowland.org>
References: <1432044679-10256-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39460 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752955AbbESRu1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 13:50:27 -0400
In-Reply-To: <1432044679-10256-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

On Tue, 19 May 2015, Tomeu Vizoso wrote:

> Introduce a new per-device flag power.direct_complete_default that will
> instruct the PM core to let that device remain in runtime suspend when
> the system goes into a sleep power state, without it having to implement
> the prepare() callback.
> 
> This is useful because otherwise it would be needed to get dozens of
> drivers to implement the prepare() callback even if they don't have a
> 1-to-1 relationship with a piece of HW.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

This seems to be a very reasonable approach, and much like what I 
envisioned from Rafael's original suggestion.

Alan Stern

