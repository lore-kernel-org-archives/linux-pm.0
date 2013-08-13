From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Hewlett-Packard HP Compaq nx6325 (EY349EA#AKD)] suspend/resume failure
Date: Wed, 14 Aug 2013 00:42:33 +0200
Message-ID: <3916887.XVsMrcXZta@vostro.rjw.lan>
References: <520A2358.6090804@prokonto.pl> <2413831.lgLFglVszz@vostro.rjw.lan> <520A34CB.9040809@prokonto.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41606 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759357Ab3HMWcI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Aug 2013 18:32:08 -0400
In-Reply-To: <520A34CB.9040809@prokonto.pl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tobiasz 'dotnokato' Jarczyk <dotnokato@prokonto.pl>
Cc: linux-pm@vger.kernel.org, 1175504@bugs.launchpad.net

On Tuesday, August 13, 2013 03:29:47 PM Tobiasz 'dotnokato' Jarczyk wrote:
> Hi,
> I have tested it with the most recent kernel (3.11.rc5) and I am still 
> experiencing this issue.

Well, for me suspend with 3.11-rc5 breaks on that box too, but with 3.10.6 it
actually works up to a VT switch that doesn't (it resumes to a black screen,
but switching to VT1 and back to X helps).  A couple of other things don't
work on it with 3.10.6, sadly.

I have openSUSE 12.3 installed on it.

Thanks,
Rafael

