From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Thu, 7 May 2015 18:03:36 +0100
Message-ID: <20150507180336.77b44005@lxorguk.ukuu.org.uk>
References: <CAJFHJrp=h=jxSNLTyszYs3Ac3PoZKFy-dVJXLehO36r-4p-8=w@mail.gmail.com>
	<Pine.LNX.4.44L0.1505051532000.1639-100000@iolanthe.rowland.org>
	<CAJFHJrpFAvQ7zZMj-Ap6rYU24Gy0fwca6WqqNSg6-rrS0mxASA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:44739 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbEGREL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 13:04:11 -0400
In-Reply-To: <CAJFHJrpFAvQ7zZMj-Ap6rYU24Gy0fwca6WqqNSg6-rrS0mxASA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chirantan Ekbote <chirantan@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>

> You are, of course, correct.  Ultimately the only requirement we have
> is that there exists a way for userspace to determine if the system
> woke up because of a user-triggered event.  The actual mechanism by

No. That is irrelevant. You need a way to ascertain if a user triggered
event has occurred since you suspended.

The two are not the same thing.

If your box wakes up due to something like a wireless card deciding it
needs to poke the base station and the user hits a key a microsecond
after wakeup then you want the display on.

The question is never "did the user wake the machine" the question is "did
the user do something that takes me out of 'lucid sleep/snooze/whatever'
since I suspended". Every user event could equally occur a microsecond
after a wakeup from a non user source, so every time you must ask the
"since suspend" question.

In fact if you had some kind of hypoethetical event counter incremented
by the device on it causing a wakeup event *or* an event while active
(and no way to tell them apat) that would provide a correct race free
interface to figure out if the display ought to be on

It doesn't solve the powering off as a key is hit race but that's a
different beast.

Alan
