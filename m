From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 4/5] arm64: dts: rockchip: make rk3368 grf syscons simple-mfds as well
Date: Sat, 21 May 2016 15:55:06 +0200
Message-ID: <2597247.kfueRAYi3v@phil>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de> <1459432126-6395-5-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:36207 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbcEUNzO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2016 09:55:14 -0400
In-Reply-To: <1459432126-6395-5-git-send-email-heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: khilman@kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Am Donnerstag, 31. M=E4rz 2016, 15:48:45 schrieb Heiko Stuebner:
> The general register files do contain a lot of separate functions and
> while some really are only registers with a lot of different 1-bit
> settings, there are also a lot of them containing some bigger functio=
n
> blocks. To be able to define these as sub-devices, make them simple-m=
fds.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: David Wu <david.wu@rock-chips.com>

applied for 4.8
