From: Michiel Janssens <michiel@nexigon.net>
Subject: Re: PROBLEM: [HP EliteBook 8740w] suspend/resume failure
Date: Wed, 04 Dec 2013 22:35:02 +0100
Message-ID: <529FA006.4030802@nexigon.net>
References: <529F6182.4040302@nexigon.net>	<CAKocOONKun+JuFb5XcO_oOrf7LpSOyRJbsmqLc1CMSegHbuY=g@mail.gmail.com>	<529F8A73.2010108@nexigon.net> <CAKocOOPhm5QRpqguuB1D47LUJETX-L44ocTpq0oPt--pNMq4zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:36180 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756Ab3LDVfE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2013 16:35:04 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so15573810wes.41
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2013 13:35:03 -0800 (PST)
In-Reply-To: <CAKocOOPhm5QRpqguuB1D47LUJETX-L44ocTpq0oPt--pNMq4zQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuahkhan@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

No suspend messages in dmesg.0
Tried earlyprintk=vga (incl keep) but nothing.
The screen does not go on, the system crashes before anything is 
displayed, so it even does not get to the point of the password screen 
for decrypting the drive.
Also followed the ubuntu debugging guide and tried sudo sh -c "sync && 
echo 1 > /sys/power/pm_trace && pm-suspend", but only lines found are:
[    2.080414]   Magic number: 9:73:293
[    2.080445] tty tty26: hash matches

op 04-12-13 21:33, Shuah Khan schreef:
> On Wed, Dec 4, 2013 at 1:02 PM, Michiel Janssens <michiel@nexigon.net> wrote:
>> Thanks for your reply Shuah.
>> Dmesg is beneath, I didn't find oops messages.
>> Must say that I'm not familiar with kernel debugging.
> Does /var/log/dmesg.0 have any suspend messages saves in it. If you
> can see the crash messages on your console and take a picture and send
> it. Also enabling earlyprink=vga kernel boot option will give you more
> data.
>
> -- Shuah

