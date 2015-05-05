From: Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Tue, 5 May 2015 13:58:12 -0700
Message-ID: <CAJFHJrpFAvQ7zZMj-Ap6rYU24Gy0fwca6WqqNSg6-rrS0mxASA@mail.gmail.com>
References: <CAJFHJrp=h=jxSNLTyszYs3Ac3PoZKFy-dVJXLehO36r-4p-8=w@mail.gmail.com>
	<Pine.LNX.4.44L0.1505051532000.1639-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1505051532000.1639-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 5, 2015 at 12:35 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 5 May 2015, Chirantan Ekbote wrote:
>
>> This is our plan for the next version (see my email earlier in this
>> thread).  Keeping a hybrid power state with hacks in the drivers isn't
>> really maintainable, scalable, or upstream-able and has caused us some
>> headaches already.  Unfortunately we were working with the 3.14 kernel
>> at the time, which didn't have the framework necessary to do anything
>> else.  The new version of lucid sleep will have the power manager
>> runtime suspend power-hungry devices before a suspend so that they
>> remain powered off at resume time.  The power manager can then decide
>> to resume those devices based on whether the wakeup event was
>> user-triggered.
>>
>> Being able to determine the wakeup type from userspace is the only
>> functionality we need from the kernel that doesn't already exist in
>> mainline.
>
> Maybe you can simplify the problem.  You don't really need to know the
> wakeup type, or to determine which device was responsible for the
> wakeup.  All you really need to know is whether the wakeup was
> user-triggered.  That may be much easier to discover.
>

You are, of course, correct.  Ultimately the only requirement we have
is that there exists a way for userspace to determine if the system
woke up because of a user-triggered event.  The actual mechanism by
which this determination is made isn't something I feel strongly
about.  The reason I had been focusing on exposing the actual wakeup
event to userspace is because classifying wakeup events as
user-triggered or not feels to me like a policy decision that should
be left to userspace.  If the kernel maintainers are ok with doing
this work in the kernel instead and only exposing a binary yes/no bit
to userspace for user-triggered wakeups, that's perfectly fine because
it still meets our requirements.

> Alan Stern
>
