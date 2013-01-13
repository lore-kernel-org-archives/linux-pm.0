From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hibernation fails from kexec'ed kernel
Date: Sun, 13 Jan 2013 21:35:08 +0100
Message-ID: <50F31A7C.1040406@gmail.com>
References: <50F18577.3030506@gmail.com> <4354889.LUp82ppzIy@vostro.rjw.lan> <50F1C244.9000209@gmail.com> <5896329.N3V4ImDAv7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:52569 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303Ab3AMUfM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Jan 2013 15:35:12 -0500
Received: by mail-ee0-f52.google.com with SMTP id b15so1191166eek.25
        for <linux-pm@vger.kernel.org>; Sun, 13 Jan 2013 12:35:11 -0800 (PST)
In-Reply-To: <5896329.N3V4ImDAv7@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On 01/12/2013 10:32 PM, Rafael J. Wysocki wrote:
> The symptom seems to indicate that the image header is in a wrong place.

Or a memory corruption which I saw today (without hibernation) -- data
which should have gone to the video memory appeared in struct hid_device
:/. I suggest to suspend this thread unless the corruption gets
resolved. (I suppose the corruption won't affect this issue, because I
haven't ever seen a problem with hibernation unless kexec was used. But
who knows...)

-- 
js
