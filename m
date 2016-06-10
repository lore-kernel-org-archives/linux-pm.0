From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 1/2] power: axp288_charger: Replace deprecatd API of
 extcon
Date: Fri, 10 Jun 2016 10:51:40 +0900
Message-ID: <575A1D2C.5060101@samsung.com>
References: <1464687280-8155-1-git-send-email-cw00.choi@samsung.com>
 <1464687280-8155-2-git-send-email-cw00.choi@samsung.com>
 <CGME20160610014651epcas1p373fb21c1ee8aa034b4be8df4b43815ff@epcas1p3.samsung.com>
 <20160610014643.GC5848@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:39102 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcFJBvn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 21:51:43 -0400
In-reply-to: <20160610014643.GC5848@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, wens@csie.org, myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 2016=EB=85=84 06=EC=9B=94 10=EC=9D=BC 10:46, Sebastian Reichel wrote=
:
> Hi,
>=20
> On Tue, May 31, 2016 at 06:34:39PM +0900, Chanwoo Choi wrote:
>> This patch removes the deprecated notifier API of extcon framework a=
nd then use
>> the new extcon API[2] with the unique id[1] to indicate the each ext=
ernal
>> connector. Alter deprecated API as following:
>> - extcon_register_interest() -> extcon_register_notifier()
>> - extcon_unregister_interest() -> extcon_unregister_notifier()
>> - extcon_get_cable_state() -> extcon_get_cable_state_()
>>
>> And, extcon alters the name of USB charger connector in patch[3] as =
following:
>> - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
>> - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
>> - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
>> - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
>>
>> [1] Commit 2a9de9c0f08d61
>> - ("extcon: Use the unique id for external connector instead of stri=
ng)
>> [2] Commit 046050f6e623e4
>> - ("extcon: Update the prototype of extcon_register_notifier() with =
enum extcon
>> [3] Commit 11eecf910bd81d
>> - ("extcon: Modify the id and name of external connector")
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/power/axp288_charger.c | 77 +++++++++++++++++++++++++++++--=
-----------
>>  1 file changed, 53 insertions(+), 24 deletions(-)
>=20
> Acked-By: Sebastian Reichel <sre@kernel.org>
>=20

To prevent the build error on linux-next, this patchset should be merge=
d on one repository.
So, I think that there are two solution.
=46irst, I'll make the immutable branch for them and send pull request =
to you.
Second, I'll apply this patchset on extcon git repository.

Which would you prefer? If you answer, I'll do right now.

Thanks,
Chanwoo Choi

