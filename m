From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/8] Add support for additional bq27xxx devices
Date: Thu, 23 Jul 2015 18:27:48 +0200
Message-ID: <20150723162748.GJ29125@pali>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36799 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbbGWQ1v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 12:27:51 -0400
Content-Disposition: inline
In-Reply-To: <1437601920-13045-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 22 July 2015 16:51:52 Andrew F. Davis wrote:
> This series adds support for several additional bq27xxx devices and=20
> makes a few related fixes.
>=20

Thanks for some cleanup of bq27xxx battery driver! Did you tested your
patches? On which devices (with which bq chips)?

And I have another question for you: I see that there are now more
bq24*_charger.c drivers for TI BQ charger chips. Do you think if it is
possible to do some cleanup & merge? Or all those charger chips
different and every one should live in own kernel module?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
