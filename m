From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH 01/10] power: charger-manager: Use thermal subsystem
 interface only to get temperature.
Date: Fri, 31 Oct 2014 11:25:51 +0900
Message-ID: <5452F32F.8010103@samsung.com>
References: <1414672996-28355-1-git-send-email-jonghwa3.lee@samsung.com>
 <1414672996-28355-2-git-send-email-jonghwa3.lee@samsung.com>
 <54523907.4030609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:14352 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161558AbaJaCZy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 22:25:54 -0400
In-reply-to: <54523907.4030609@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, myungjoo.ham@samsung.com, cw00.choi@samsung.com

Hi,
On 2014=EB=85=84 10=EC=9B=94 30=EC=9D=BC 22:11, Krzysztof Koz=C5=82owsk=
i wrote:

> On 30.10.2014 13:43, Jonghwa Lee wrote:
>> It drops the way of using power_supply interface to reference batter=
y's
>> temperature. Then it tries to use thermal subsystem's only. This mak=
es driver
>> more simple and also can remove ifdeferies.
>>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> ---
>>  drivers/power/Kconfig                 |    1 +
>>  drivers/power/charger-manager.c       |  113 ++++++++--------------=
-----------
>>  include/linux/power/charger-manager.h |    3 +-
>>  3 files changed, 28 insertions(+), 89 deletions(-)
>>
>> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
>> index 8ff2511..115d153 100644
>> --- a/drivers/power/Kconfig
>> +++ b/drivers/power/Kconfig
>> @@ -317,6 +317,7 @@ config CHARGER_MANAGER
>>  	bool "Battery charger manager for multiple chargers"
>>  	depends on REGULATOR
>>  	select EXTCON
>> +	select THERMAL
>=20
> I think both of "select" here could be dangerous. Select should rathe=
r
> be used for non-visible errors. Just use "depends on".
>=20
>>  }
>> @@ -623,7 +594,7 @@ static int cm_check_thermal_status(struct charge=
r_manager *cm)
>>  		 * occur hazadous result. We have to handle it
>>  		 * depending on battery type.
>>  		 */
>> -		dev_err(cm->dev, "Failed to get battery temperature\n");
>> +		dev_dbg(cm->dev, "Failed to get battery temperature\n");
>=20
> A valuable change but not strictly related to the commit. Additionall=
y
> that is a user-visible change. Could you split it to separate patch?
>=20
> Best regards,
> Krzysztof
>=20
>=20


All your comments are acceptable. I'll fix them all.
Thanks for your comments.

Thanks,
Jonghwa
