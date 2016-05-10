From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 0/3] power: Remove the deprecated extcon functions
Date: Tue, 10 May 2016 09:54:58 +0900
Message-ID: <57313162.20208@samsung.com>
References: <1461232535-3959-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60325 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbcEJAzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 20:55:08 -0400
In-reply-to: <1461232535-3959-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Ping.

Could you review this patch?

Thanks,
Chanwoo Choi

On 2016=EB=85=84 04=EC=9B=94 21=EC=9D=BC 18:55, Chanwoo Choi wrote:
> This patch-set removes the deprecated notifier API of extcon framewor=
k and
> then use the new extcon API[2] with the unique id[1] to indicate the =
each
> external connector. Alter deprecated API as following:
> - extcon_register_interest() -> extcon_register_notifier()
> - extcon_unregister_interest() -> extcon_unregister_notifier()
> - extcon_set_cable_state() -> extcon_set_cable_state_()
> - extcon_get_cable_state() -> extcon_get_cable_state_()
>=20
> And, extcon alters the name of USB charger connector in patch[3] as f=
ollowing:
> - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
> - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
> - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
> - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
>=20
> [1] Commit 2a9de9c0f08d61
> - ("extcon: Use the unique id for external connector instead of strin=
g)
> [2] Commit 046050f6e623e4
> - ("extcon: Update the prototype of extcon_register_notifier() with e=
num extcon
> [3] Commit 11eecf910bd81d
> - ("extcon: Modify the id and name of external connector")
>=20
> Changes from v1:
> - Fix the typo (EXTCON_CHG_USB_SDP -> EXTCON_CHG_USB_CDP) on axp288_c=
harger.c
>=20
> Chanwoo Choi (3):
>   power: charger-manager: Replace deprecatd API of extcon
>   power: axp288_charger: Replace deprecatd API of extcon
>   extcon: Remove the deprecated extcon functions
>=20
>  .../bindings/power_supply/charger-manager.txt      |   4 +-
>  drivers/extcon/extcon.c                            | 201 +++--------=
----------
>  drivers/power/axp288_charger.c                     |  77 +++++---
>  drivers/power/charger-manager.c                    |  31 ++--
>  include/linux/extcon.h                             |  59 ------
>  include/linux/power/charger-manager.h              |   4 +-
>  6 files changed, 101 insertions(+), 275 deletions(-)
>=20

