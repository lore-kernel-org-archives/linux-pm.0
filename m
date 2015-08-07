From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 2/2] PM / AVS: rockchip-io: add io selectors and supplies for rk3368
Date: Fri, 07 Aug 2015 16:04:53 -0700
Message-ID: <7hlhdmwvhm.fsf@deeprootsystems.com>
References: <3371948.nX6iqYbHnA@diego> <1481228.KhoIt654ID@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33763 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946350AbbHGXE4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 19:04:56 -0400
Received: by pdrh1 with SMTP id h1so31949657pdr.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2015 16:04:55 -0700 (PDT)
In-Reply-To: <1481228.KhoIt654ID@diego> ("Heiko =?utf-8?Q?St=C3=BCbner=22'?=
 =?utf-8?Q?s?= message of "Tue, 04
	Aug 2015 21:37:01 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org

Heiko St=C3=BCbner <heiko@sntech.de> writes:

> This adds the necessary data for handling io voltage domains on the r=
k3368.
> As interesting tidbit, the rk3368 contains two separate iodomain area=
s.
> One in the regular General Register Files (GRF) and one in PMUGRF in =
the
> pmu power domain.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Kevin Hilman <khilman@linaro.org>

Rafael, feel free to take this series directly, or let me know if you
want a pull request.  I don't have anything other AVS stuff queued up
for v4.3.

Kevin
