From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/5] PM / AVS: rockchip-io: make io-domains a child of
 the GRF
Date: Tue, 26 Apr 2016 19:13:38 +0200
Message-ID: <CAJZ5v0gMEX+5fKgrhHPTZh1GW4FB7QWSOB_ZARL0O8n47cep5w@mail.gmail.com>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de>
	<3991738.xMQYlxyb28@phil>
	<CAJZ5v0gi_EBnL+M6iEAkgYHNkFQOG5OT=6fABQtvCyQY4=GcQQ@mail.gmail.com>
	<15890066.zZg7hiMmi2@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34633 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbcDZRNl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 13:13:41 -0400
Received: by mail-lf0-f67.google.com with SMTP id m101so3366604lfi.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2016 10:13:40 -0700 (PDT)
In-Reply-To: <15890066.zZg7hiMmi2@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-rockchip@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Apr 26, 2016 at 6:25 PM, Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> Hi Rafael,
>
> Am Mittwoch, 13. April 2016, 06:55:03 schrieb Rafael J. Wysocki:
>> On Tue, Apr 12, 2016 at 4:23 AM, Heiko Stuebner <heiko@sntech.de> wr=
ote:
>> > Am Donnerstag, 31. M=C3=A4rz 2016, 15:48:42 schrieb Heiko Stuebner=
:
>> >> IO-domain handling is part of the general register files, so shou=
ld live
>> >> under the grf directly. This change allows the grf to be a simple=
-mfd and
>> >> the io-domains fetching the syscon regmap from that parent-node.
>> >>
>> >> The old binding is of course preserved, though deprecated.
>> >>
>> >> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> >> Acked-by: Kevin Hilman <khilman@baylibre.com>
>> >> Tested-by: David Wu <david.wu@rock-chips.com>
>> >
>> > could you look into picking up this patch 1/5 please?
>> >
>> > The others are to much interwined into other devicetree changes, s=
o I'll
>> > apply them for 4.8, but it would be nice if you could pick up this=
 one for
>> > 4.7 so the code change becomes available at 4.8-rc1
>>
>> OK, I'll pick it up, but I'm traveling this week, so that'll take a
>> few days more.
>
> I just checked kernel/git/rafael/linux-pm.git and didn't find this pa=
tch there,
> so I guess it might be time for a ping ;-) .

My bad, sorry.

Queued up for 4.7 now, will show up in linux-next in the next few days.
