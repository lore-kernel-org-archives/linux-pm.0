From: Ian Malone <ibmalone@gmail.com>
Subject: Re: kernels 3.9.5 to 3.10.6 fail to boot on battery, vaio vgn-c2m/w
Date: Mon, 28 Oct 2013 15:24:22 +0000
Message-ID: <CAL3-7MrJ0BOHK+Hb8jzALE=2njoKCwUY3uwoV522zpkzxpdVfQ@mail.gmail.com>
References: <CAL3-7MrExuRWc-ugzU4c4y-trQaCfO_UU2c6tt+P4-8fwiWmUg@mail.gmail.com>
	<Pine.LNX.4.44L0.1310281033090.1246-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:58749 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757118Ab3J1PYX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2013 11:24:23 -0400
Received: by mail-ve0-f179.google.com with SMTP id cz12so5007134veb.24
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2013 08:24:22 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1310281033090.1246-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

On 28 October 2013 14:33, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sun, 27 Oct 2013, Ian Malone wrote:
>
>> Hi,
>>
>> Is there anything I can do that will help to resolve this bug?
>>
>> > https://bugzilla.kernel.org/show_bug.cgi?id=60770
>> >
>>
>> Quick summary: removal of idle=mwait has led to laptop failing to boot
>> on battery. Only known workaround so far is to use idle=poll which
>> drains battery at an amazing rate.
>
> You can try bringing this to the attention of the person who wrote the
> commit removing idle=mwait.
>

Thanks. The commit was Len Brown @ intel, the bug was re-assigned to
him by the original assignee, though I've just noticed he's not on the
CC list and also the commit is under an @intel address while his
bugzilla is @kernel. Wonder if one of those factors have caused this
to be missed. I'll try forwarding this on to him.

-- 
imalone
http://ibmalone.blogspot.co.uk
