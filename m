From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/5] PM: Enable option of re-use runtime PM callbacks at
 system suspend
Date: Thu, 5 Dec 2013 16:46:40 -0500
Message-ID: <CAJvTdKnqD3ccPUzh7kNMNqrEYFfD93Vh9hgFuKyHz+pjGNHdtA@mail.gmail.com>
References: <Pine.LNX.4.44L0.1311291014020.27250-100000@netrider.rowland.org>
	<4994754.y6gINBtP7i@vostro.rjw.lan>
	<CAPDyKFpf58CRKUhFPKHyg4S9oaUR=XHJQs=hK7p63Hkv8gnbbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:54087 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab3LEVqm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2013 16:46:42 -0500
In-Reply-To: <CAPDyKFpf58CRKUhFPKHyg4S9oaUR=XHJQs=hK7p63Hkv8gnbbw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>

This thread raises the question...

Do we still need to have PM_RUNTIME apart from PM_SLEEP?

What is the benefit of being able to build-in one one without the other?
If that benefit is not significant, perhaps the time has come to
replace them both with CONFIG_PM...

cheers,
-Len Brown, Intel Open Source Technology Center
