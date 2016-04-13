From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/5] PM / AVS: rockchip-io: make io-domains a child of
 the GRF
Date: Wed, 13 Apr 2016 06:55:03 +0200
Message-ID: <CAJZ5v0gi_EBnL+M6iEAkgYHNkFQOG5OT=6fABQtvCyQY4=GcQQ@mail.gmail.com>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de>
	<1459432126-6395-2-git-send-email-heiko@sntech.de>
	<3991738.xMQYlxyb28@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32794 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757824AbcDMEzG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 00:55:06 -0400
Received: by mail-lf0-f68.google.com with SMTP id p64so5495356lfg.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2016 21:55:04 -0700 (PDT)
In-Reply-To: <3991738.xMQYlxyb28@phil>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-rockchip@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Apr 12, 2016 at 4:23 AM, Heiko Stuebner <heiko@sntech.de> wrote=
:
> Hi Rafael,
>
> Am Donnerstag, 31. M=C3=A4rz 2016, 15:48:42 schrieb Heiko Stuebner:
>> IO-domain handling is part of the general register files, so should =
live
>> under the grf directly. This change allows the grf to be a simple-mf=
d and
>> the io-domains fetching the syscon regmap from that parent-node.
>>
>> The old binding is of course preserved, though deprecated.
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> Acked-by: Kevin Hilman <khilman@baylibre.com>
>> Tested-by: David Wu <david.wu@rock-chips.com>
>
> could you look into picking up this patch 1/5 please?
>
> The others are to much interwined into other devicetree changes, so I=
'll
> apply them for 4.8, but it would be nice if you could pick up this on=
e for
> 4.7 so the code change becomes available at 4.8-rc1

OK, I'll pick it up, but I'm traveling this week, so that'll take a
few days more.

Thanks,
Rafael
