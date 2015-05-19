From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/2] PM / sleep: Add power.direct_complete_default flag
Date: Wed, 20 May 2015 01:38:35 +0200
Message-ID: <4578201.PxaKqbF0aJ@vostro.rjw.lan>
References: <1432044679-10256-1-git-send-email-tomeu.vizoso@collabora.com> <1432044679-10256-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49208 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752144AbbESXNP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 19:13:15 -0400
In-Reply-To: <1432044679-10256-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On Tuesday, May 19, 2015 04:11:15 PM Tomeu Vizoso wrote:
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

The code changes look good, but please change the doc/changelog as
already suggested by Ulf.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
