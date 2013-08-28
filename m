From: Zoran Markovic <zoran.markovic@linaro.org>
Subject: Re: [RFC PATCHv3] drivers: power: Detect device suspend/resume lockup
 and log event in pstore.
Date: Wed, 28 Aug 2013 10:45:45 -0700
Message-ID: <CAME+o4n8HqvGtAGX0wO+Zs_pdanKuhai6T3jg2V1Q4nWzxKk9A@mail.gmail.com>
References: <1375216733-6740-1-git-send-email-zoran.markovic@linaro.org>
	<CAME+o4=uNFDjz8yFJEQR8P4dwki4U0iBv-FrixTA_TFxWctDSA@mail.gmail.com>
	<3196266.rMZQj4Yosc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:38235 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab3H1Rpr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 13:45:47 -0400
Received: by mail-bk0-f41.google.com with SMTP id na10so2380142bkb.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2013 10:45:46 -0700 (PDT)
In-Reply-To: <3196266.rMZQj4Yosc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Benoit Goby <benoit@android.com>, Android Kernel Team <kernel-team@android.com>, Colin Cross <ccross@android.com>, Todd Poynor <toddpoynor@google.com>, San Mehat <san@google.com>, John Stultz <john.stultz@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Rafael,
> It doesn't look too bad from a quick look, but there's a couple of things
> I don't like in it still (relatively minor).

If there are things you would like changed in this patch, please let
me know. It would be nice to catch the 3.12 merge window.
Thanks,
- Zoran
