From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Fri, 5 Feb 2016 07:54:04 +0100
Message-ID: <CAPDyKFoawbrj3w_+2p5ugjByrwxwmA1S2God1VAvkRbh2rUtjg@mail.gmail.com>
References: <CAPDyKFpRnmn+h_VH3jtC3u-BOf7-00nbzD30omaxaaZOOAK8Gg@mail.gmail.com>
	<Pine.LNX.4.44L0.1602041702550.1515-100000@iolanthe.rowland.org>
	<CAPDyKFrMZYdeun67FBXdWL16DBOuO16qqOxRsks3QBJhNB8SoQ@mail.gmail.com>
	<20160205010810.GR19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33865 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbcBEGyG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 01:54:06 -0500
Received: by mail-yk0-f174.google.com with SMTP id u9so55701340ykd.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 22:54:05 -0800 (PST)
In-Reply-To: <20160205010810.GR19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 5 February 2016 at 02:08, Tony Lindgren <tony@atomide.com> wrote:
> * Ulf Hansson <ulf.hansson@linaro.org> [160204 14:35]:
>> On 4 February 2016 at 23:09, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Thu, 4 Feb 2016, Ulf Hansson wrote:
>> >
>> >> I am really not questioning the autosuspend feature at all, it's a
>> >> really great feature!
>> >>
>> >> Now, I question the minor benefit we actually gain from having the
>> >> runtime PM core to update the mark in rpm_resume().
>> >
>> > As Tony pointed out, it prevents some devices from going to sleep right
>> > away.
>>
>> Because their drivers don't care to update the last busy mark!?
>
> Nope. Without that devices may never resume at all so the drivers
> can't do anything about it.

I don't get it. Why not? Because of another abuse of the runtime PM API?

Or we should probably continue to focus on fixing the regression. :-)

Kind regards
Uffe
