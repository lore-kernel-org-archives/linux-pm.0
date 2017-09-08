From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing
 capacity values for bq27421
Date: Fri, 8 Sep 2017 19:40:33 +0200
Message-ID: <20170908174033.GC23140@pali>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com>
 <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com>
 <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com>
 <CAKvHMgT8MDpussUYJ_AKELXzCbQxz2BYrF0ZM-S_on=9+oatEQ@mail.gmail.com>
 <3A487394-3755-4EA0-86C6-6855DA0AC547@goldelico.com>
 <CAKvHMgT6AHfjnXvD5jeWP_9wAm_GQNJxm=Nm1jH32NeaVZjdYw@mail.gmail.com>
 <A3715C96-BA15-4F3F-B0F1-017A5D31FFB0@goldelico.com>
 <CAKvHMgTGDb=JVCMpTo4ZXwRVc9s4BweAFzwGGNoewZwaT3=4LA@mail.gmail.com>
 <9903AE74-6BAA-4051-ADFC-0DB5972AF26E@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:43536 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbdIHRkg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2017 13:40:36 -0400
Content-Disposition: inline
In-Reply-To: <9903AE74-6BAA-4051-ADFC-0DB5972AF26E@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com

On Friday 08 September 2017 19:38:37 H. Nikolaus Schaller wrote:
> and here is the result:
> 
> > root@letux:~# dmesg|fgrep bq27
> > [   10.391235] bq27xxx_battery_setup
> > [   10.391265] bq27xxx_battery_setup: dm_regs=bf0520e0
> > [   10.393798] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name attribute, please fix

Hi! IIRC hwmon name cannot contain '-'. Use '_' instead.

-- 
Pali Rohár
pali.rohar@gmail.com
