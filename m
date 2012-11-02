From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 3.7-rc3
Date: Fri, 2 Nov 2012 13:25:37 -0700
Message-ID: <CA+55aFxm0D77c0RYJuAiq2EDJxn+hGKTEGYJnHXNM8XkVAYOTA@mail.gmail.com>
References: <CA+55aFwwTc4QXKqiECgE9NOE2zjC6GsGHHydGP9YDbgQSbw9Aw@mail.gmail.com>
 <26004880.qboZkUVCy9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:52757 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab2KBUZ7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Nov 2012 16:25:59 -0400
In-Reply-To: <26004880.qboZkUVCy9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>

On Mon, Oct 29, 2012 at 5:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> Unfortunately, s2disk is broken with this one and previous -rc.  In the
> majority of cases it just hangs the machine during hibernation, although
> sometimes it returns to user space reporting freezing problems, suspicions
> RCU usage and similar stuff, pretty much without any useful debug information.

Ugh. I was hoping that we'd get more reports on this, right now
there's not enough information to even make a guess about what's up.

I also note that no actual i915 people were cc'd, despite your
graphics driver suspect. Adding Daniel and Dave (one of the millions)
to the cc since they probably do have lkml but probably don't react
unless something gets pointed out.

Daniel/Dave, do you have any reports of hibernation failing (or VT
switching problems) with i915 after 3.6?

Rafael, do you have logs of the suspicious RCU usage etc reports?

               Linus
