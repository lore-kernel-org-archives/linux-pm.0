From: Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Thu, 7 May 2015 11:21:49 -0700
Message-ID: <CAJFHJrqdSykB4p8AVAHj9hjQCjHdk2fmtMSBkshw_eu4kbyo6Q@mail.gmail.com>
References: <CAJFHJrp=h=jxSNLTyszYs3Ac3PoZKFy-dVJXLehO36r-4p-8=w@mail.gmail.com>
	<Pine.LNX.4.44L0.1505051532000.1639-100000@iolanthe.rowland.org>
	<CAJFHJrpFAvQ7zZMj-Ap6rYU24Gy0fwca6WqqNSg6-rrS0mxASA@mail.gmail.com>
	<20150507180336.77b44005@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36232 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbbEGSVu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 14:21:50 -0400
Received: by qku63 with SMTP id 63so33230188qku.3
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 11:21:49 -0700 (PDT)
In-Reply-To: <20150507180336.77b44005@lxorguk.ukuu.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, May 7, 2015 at 10:03 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
>> You are, of course, correct.  Ultimately the only requirement we have
>> is that there exists a way for userspace to determine if the system
>> woke up because of a user-triggered event.  The actual mechanism by
>
> No. That is irrelevant. You need a way to ascertain if a user triggered
> event has occurred since you suspended.
>
> The two are not the same thing.
>
> If your box wakes up due to something like a wireless card deciding it
> needs to poke the base station and the user hits a key a microsecond
> after wakeup then you want the display on.
>
> The question is never "did the user wake the machine" the question is "did
> the user do something that takes me out of 'lucid sleep/snooze/whatever'
> since I suspended". Every user event could equally occur a microsecond
> after a wakeup from a non user source, so every time you must ask the
> "since suspend" question.
>

Yes, this is what Rafael said earlier and if you had read my reply,
you would have seen that I have already admitted that this is a
situation that our current implementation does not handle properly.
However, this hasn't been a very big issue for us in practice because
1) the window during which an event could get dropped like this is
presumably very small and 2) the standard user behavior when their
computer doesn't wake up is to start pressing random keys, which we do
end up catching.  No, this is not a great user experience and we want
to fix it for the next version.

> In fact if you had some kind of hypoethetical event counter incremented
> by the device on it causing a wakeup event *or* an event while active
> (and no way to tell them apat) that would provide a correct race free
> interface to figure out if the display ought to be on
>

Again, this is basically what Rafael suggested earlier and I've
already said that it sounds like a perfectly reasonable solution to
me.

> It doesn't solve the powering off as a key is hit race but that's a
> different beast.
>
> Alan
