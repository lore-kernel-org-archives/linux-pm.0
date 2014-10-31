From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: resume from hibernation without touching saved image?
Date: Sat, 01 Nov 2014 00:00:21 +0100
Message-ID: <1517304.61MqM8NHe8@vostro.rjw.lan>
References: <545379DA.8070701@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58432 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750918AbaJaWjl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Oct 2014 18:39:41 -0400
In-Reply-To: <545379DA.8070701@msgid.tls.msk.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-pm@vger.kernel.org

On Friday, October 31, 2014 03:00:26 PM Michael Tokarev wrote:
> Hello again.
> 
> Currently, linux kernel is able to resume from a previously saved
> image, and it basically clears up that image when done, so there's
> no way to resume from it once more.

Which is intentional.

> Is it possible to _not_ touch the image at all and keep it in the
> same state as before?  Maybe putting it to a readonly block device
> (like blockdev --setro, or mdadm readonly array) will help?

Keeping an image itself immutable doesn't help, because the state
recorded in the image has to match the state recorded in other
places, like fs superblocks and such.

As long as you can't guarantee that all of that is in sync, nothing helps.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
