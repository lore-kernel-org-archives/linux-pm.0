From: Zoran Markovic <zoran.markovic@linaro.org>
Subject: Re: [RFC PATCHv3] drivers: power: Detect device suspend/resume lockup
 and log event in pstore.
Date: Wed, 28 Aug 2013 15:06:31 -0700
Message-ID: <CAME+o4mKnbF+PzEC=JWLE+Tm=4p-1pegcnaKGYTcT07URzCPGQ@mail.gmail.com>
References: <1375216733-6740-1-git-send-email-zoran.markovic@linaro.org>
	<3196266.rMZQj4Yosc@vostro.rjw.lan>
	<CAME+o4n8HqvGtAGX0wO+Zs_pdanKuhai6T3jg2V1Q4nWzxKk9A@mail.gmail.com>
	<1761440.cq52yMKNRv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:57540 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab3H1WGb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 18:06:31 -0400
Received: by mail-ob0-f169.google.com with SMTP id es8so3741665obc.28
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2013 15:06:31 -0700 (PDT)
In-Reply-To: <1761440.cq52yMKNRv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Benoit Goby <benoit@android.com>, Android Kernel Team <kernel-team@android.com>, Colin Cross <ccross@android.com>, Todd Poynor <toddpoynor@google.com>, San Mehat <san@google.com>, John Stultz <john.stultz@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> Is there any practical reason why it should go into the next release?

Android folks find this useful, albeit a debug feature.

Zoran
