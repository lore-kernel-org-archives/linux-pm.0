From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 4/8] power: bq27x00_battery: Checkpatch fixes
Date: Thu, 23 Jul 2015 18:01:33 +0200
Message-ID: <20150723160133.GE29125@pali>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
 <1437601920-13045-5-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33987 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbbGWQBn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 12:01:43 -0400
Content-Disposition: inline
In-Reply-To: <1437601920-13045-5-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 22 July 2015 16:51:56 Andrew F. Davis wrote:
> Remove space before tab.
> Remove unnecessary line continuations.
> Add braces to else statement.
> Remove unnecessary parentheses.
> Remove unneeded blank lines.
> Remove unnecessary 'out of memory' message.
> Add missing line after declarations.
> Change use of printk to pr_err.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/power/bq27x00_battery.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>=20

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
