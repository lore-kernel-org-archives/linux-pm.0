From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH 0/2] i2c: proper RuntimePM for the adapter device
Date: Thu, 24 Dec 2015 22:34:23 +0530
Message-ID: <CAKfKVtEmsrQT6x2p=Knz836iNXw3vwQyx1M_WJ=GJjVDgBjWFA@mail.gmail.com>
References: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
	<CAKfKVtHt8BpakkffRp=_2GUxqK5JO0WCsizCrjtwH5hv+TWvWg@mail.gmail.com>
	<20151224084105.GA1548@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20151224084105.GA1548@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org

>
>> Also maybe we can add a flag that the driver enables.
>> that way for a short period till the driver removes the call
>> the double call is not there.
>
> The only driver I found was the s3c2410 and I fixed it. Is there another
> one? Then, I'd update my series because I want a consistent state in one
> go.
>
I think the below drivers

drivers/i2c/busses/i2c-at91.c
drivers/i2c/busses/i2c-designware-core.c
drivers/i2c/busses/i2c-designware-platdrv.c
drivers/i2c/busses/i2c-rcar.c
drivers/i2c/busses/i2c-sh_mobile.c
drivers/i2c/busses/i2c-hix5hd2.c
drivers/i2c/busses/i2c-nomadik.c
drivers/i2c/busses/i2c-omap.c
drivers/i2c/busses/i2c-qup.c
drivers/i2c/busses/i2c-s3c2410.c
