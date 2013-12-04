From: Shuah Khan <shuahkhan@gmail.com>
Subject: Re: PROBLEM: [HP EliteBook 8740w] suspend/resume failure
Date: Wed, 4 Dec 2013 13:33:19 -0700
Message-ID: <CAKocOOPhm5QRpqguuB1D47LUJETX-L44ocTpq0oPt--pNMq4zQ@mail.gmail.com>
References: <529F6182.4040302@nexigon.net>
	<CAKocOONKun+JuFb5XcO_oOrf7LpSOyRJbsmqLc1CMSegHbuY=g@mail.gmail.com>
	<529F8A73.2010108@nexigon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:49279 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab3LDUdW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2013 15:33:22 -0500
Received: by mail-qa0-f52.google.com with SMTP id k4so7039732qaq.4
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2013 12:33:20 -0800 (PST)
In-Reply-To: <529F8A73.2010108@nexigon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michiel Janssens <michiel@nexigon.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Wed, Dec 4, 2013 at 1:02 PM, Michiel Janssens <michiel@nexigon.net> wrote:
> Thanks for your reply Shuah.
> Dmesg is beneath, I didn't find oops messages.
> Must say that I'm not familiar with kernel debugging.

Does /var/log/dmesg.0 have any suspend messages saves in it. If you
can see the crash messages on your console and take a picture and send
it. Also enabling earlyprink=vga kernel boot option will give you more
data.

-- Shuah
