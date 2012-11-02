From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: Linux 3.7-rc3
Date: Fri, 2 Nov 2012 22:43:02 +0100
Message-ID: <CAKMK7uENP_XWQ7UWjd+PnqTH-S-jYRjrnfY1TwocfbT6abL61w@mail.gmail.com>
References: <CA+55aFwwTc4QXKqiECgE9NOE2zjC6GsGHHydGP9YDbgQSbw9Aw@mail.gmail.com>
	<CA+55aFxm0D77c0RYJuAiq2EDJxn+hGKTEGYJnHXNM8XkVAYOTA@mail.gmail.com>
	<CAKMK7uEgnpTET0_VXWm7JyGePnXL-q_nHgSWq4g=qWodwrg38Q@mail.gmail.com>
	<4911582.xWBr8PDhoE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65348 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757014Ab2KBVnC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Nov 2012 17:43:02 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5673278iea.19
        for <linux-pm@vger.kernel.org>; Fri, 02 Nov 2012 14:43:02 -0700 (PDT)
In-Reply-To: <4911582.xWBr8PDhoE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Airlie <airlied@linux.ie>

On Fri, Nov 2, 2012 at 10:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Can you point me to a range of commits worth checking?

8c3f929b6147e142..57df2ae9df6e335a98969cac is the core rework (plus a
bit related follow-up) without any other merges interfering. Might
oops if you open/close the lid without a suspend/resume cycle (since
that's only fixed later on), should otherwise work.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
