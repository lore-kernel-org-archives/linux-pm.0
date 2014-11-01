From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: resume from hibernation without touching saved image?
Date: Sat, 01 Nov 2014 08:16:00 +0300
Message-ID: <54546C90.2000500@msgid.tls.msk.ru>
References: <545379DA.8070701@msgid.tls.msk.ru> <1517304.61MqM8NHe8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([86.62.121.231]:49312 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580AbaKAFQD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 1 Nov 2014 01:16:03 -0400
In-Reply-To: <1517304.61MqM8NHe8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

01.11.2014 02:00, Rafael J. Wysocki wrote:
> On Friday, October 31, 2014 03:00:26 PM Michael Tokarev wrote:
>> Hello again.
>>
>> Currently, linux kernel is able to resume from a previously saved
>> image, and it basically clears up that image when done, so there's
>> no way to resume from it once more.
> 
> Which is intentional.

Sure, I understand.

>> Is it possible to _not_ touch the image at all and keep it in the
>> same state as before?  Maybe putting it to a readonly block device
>> (like blockdev --setro, or mdadm readonly array) will help?
> 
> Keeping an image itself immutable doesn't help, because the state
> recorded in the image has to match the state recorded in other
> places, like fs superblocks and such.

As I mentioned before, all the filesystems are readonly so does not
change no matter how many times you resume, and there's no other state.

The only thing that changes is the swap/image and its signature -- it
can't be made read-only because it must be read-only for the kernel
which is being resumed, but it's impossible since it is the kernel who
writes this image to start with.

> As long as you can't guarantee that all of that is in sync, nothing helps.

No one can guarantee this - eg, usb devices might be removed or added
while the system is sleeping, and so on.

In my case it is easy to guarantee there's no state changes, because
there really aren't.  But ofcourse this is a rather rare situation.

Thanks,

/mjt

