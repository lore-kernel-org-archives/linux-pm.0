From: Tobiasz 'dotnokato' Jarczyk <dotnokato@prokonto.pl>
Subject: Re: [Hewlett-Packard HP Compaq nx6325 (EY349EA#AKD)] suspend/resume
 failure
Date: Wed, 14 Aug 2013 11:20:21 +0200
Message-ID: <520B4BD5.80706@prokonto.pl>
References: <520A2358.6090804@prokonto.pl> <2413831.lgLFglVszz@vostro.rjw.lan> <520A34CB.9040809@prokonto.pl> <3916887.XVsMrcXZta@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moh1-ve1.go2.pl ([193.17.41.131]:49317 "EHLO moh1-ve1.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024Ab3HNJU2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Aug 2013 05:20:28 -0400
Received: from moh1-ve1.go2.pl (unknown [10.0.0.131])
	by moh1-ve1.go2.pl (Postfix) with ESMTP id 69D1491C88C
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2013 11:20:24 +0200 (CEST)
Received: from unknown (unknown [10.0.0.108])
	by moh1-ve1.go2.pl (Postfix) with SMTP
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2013 11:20:24 +0200 (CEST)
In-Reply-To: <3916887.XVsMrcXZta@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, 1175504@bugs.launchpad.net

W dniu 14.08.2013 00:42, Rafael J. Wysocki pisze:
> On Tuesday, August 13, 2013 03:29:47 PM Tobiasz 'dotnokato' Jarczyk wrote:
>> Hi,
>> I have tested it with the most recent kernel (3.11.rc5) and I am still
>> experiencing this issue.
> Well, for me suspend with 3.11-rc5 breaks on that box too, but with 3.10.6 it
> actually works up to a VT switch that doesn't (it resumes to a black screen,
> but switching to VT1 and back to X helps).  A couple of other things don't
> work on it with 3.10.6, sadly.
>
> I have openSUSE 12.3 installed on it.
>
> Thanks,
> Rafael
>
I get the same behavior when using 3.10.6 and 3.11.rc5. The system fails 
to suspend for the second time (first time always works fine).
When waking from the first suspend I get screen flickering and just like 
you wrote, switching to VT1 and back to X helps.

I have Ubuntu Gnome 13.10.

Pozdrawiam / Regards
Tobiasz "dotnokato" Jarczyk

