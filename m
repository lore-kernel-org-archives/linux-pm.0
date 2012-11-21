From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PM QOS flags
Date: Wed, 21 Nov 2012 01:55:20 +0100
Message-ID: <2876701.4CzVHrvfSF@vostro.rjw.lan>
References: <1905473.JbZu5BcXPL@linux-lqwf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:56845 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754Ab2KUAuw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 Nov 2012 19:50:52 -0500
In-Reply-To: <1905473.JbZu5BcXPL@linux-lqwf.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-pm@vger.kernel.org

Hi,

On Wednesday, November 14, 2012 09:22:13 AM Oliver Neukum wrote:
> Hi,
> 
> it seems to me that we are missing some flags. I would propose
> 
> PM_QOS_FLAG_NO_EXTERNAL_EFFECT
> 	in some cases going to powersave has externally visible effects
> 	modems hang up, LEDs on keyboards extinguish, screens blank
> 
> PM_QOS_FLAG_NO_HOTPLUG_DETECT
> 	hotplug is not detected while in powersave
> 
> PM_QOS_FLAG_NO_MEDIUM_CHANGE
> 	the device does not detect medium change events in powersave
> 	USB storage devices are prime candidates for this

I'm fine with these, but please add them along with the users, so that
it is clear how you're planning to utilize them.

Thanks,
Rafael

 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
