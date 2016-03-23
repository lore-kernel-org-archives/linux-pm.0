From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / AVS: rockchip-io: add io selectors and supplies for rk3399
Date: Wed, 23 Mar 2016 14:44:11 -0700
Message-ID: <CAOi56cUPGFfbDO8j7QvdNieebmWqLJnbANOAavd2t76cjQr7Kg@mail.gmail.com>
References: <1458067526-11319-1-git-send-email-david.wu@rock-chips.com>
	<4748955.K1DVHdsoLd@diego>
	<7h8u19q6dw.fsf@baylibre.com>
	<3859377.YHUlbhqqCy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3859377.YHUlbhqqCy@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, David Wu <david.wu@rock-chips.com>, Nishanth Menon <nm@ti.com>, Tao Huang <huangtao@rock-chips.com>, cf@rock-chips.com, Chris Zhong <zyw@rock-chips.com>, xjq@rock-chips.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 23, 2016 at 2:24 PM, Rafael J. Wysocki <rjw@rjwysocki.net> =
wrote:
> On Wednesday, March 23, 2016 01:35:55 PM Kevin Hilman wrote:
>> Heiko St=C3=BCbner <heiko@sntech.de> writes:
>>
>> > Hi David,
>> >
>> > Am Mittwoch, 16. M=C3=A4rz 2016, 02:45:26 schrieb David Wu:
>> >> This adds the necessary data for handling io voltage domains on t=
he rk3399.
>> >> As interesting tidbit, the rk3399 contains two separate iodomain =
areas.
>> >> One in the regular General Register Files (GRF) and one in PMUGRF=
 in the
>> >> pmu power domain.
>> >>
>> >> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> >
>> > looks good, so
>> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>>
>> Acked-by: Kevin Hilman <khilman@baylibre.com>
>>
>> Rafael, can you queue this directly?  I don't currently have any oth=
er
>> AVS patches in the queue.
>
> OK, applied.
>
> That said it's the last minute for this to get into 4.6, so I'd appre=
ciate
> getting ACKs earlier during merge windows.

Oh, I knew it was late so I assumed it would be queued for the next
merge window.

Kevin
