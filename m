From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH V3 08/11] power: charger-manager: Make chraging decision
 focusing on battery status.
Date: Mon, 22 Dec 2014 11:10:04 +0900
Message-ID: <54977D7C.9040307@samsung.com>
References: <1418979323-7188-1-git-send-email-jonghwa3.lee@samsung.com>
 <1418979323-7188-9-git-send-email-jonghwa3.lee@samsung.com>
 <20141220002440.GC1694@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52668 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbaLVCKI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Dec 2014 21:10:08 -0500
In-reply-to: <20141220002440.GC1694@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com

On 2014=EB=85=84 12=EC=9B=94 20=EC=9D=BC 09:24, Pavel Machek wrote:

> Subject: charging.
>=20


(snip..)


>> --- a/include/linux/power/charger-manager.h
>> +++ b/include/linux/power/charger-manager.h
>> @@ -220,6 +220,7 @@ struct charger_desc {
>>   *	saved status of battery before entering suspend-to-RAM
>>   * @charging_start_time: saved start time of enabling charging
>>   * @charging_end_time: saved end time of disabling charging
>> + * @battery_status: Current battery status
>=20
> "current" for consistency.
>=20
>>   */
>>  struct charger_manager {
>>  	struct list_head entry;
>> @@ -237,6 +238,8 @@ struct charger_manager {
>> =20
>>  	u64 charging_start_time;
>>  	u64 charging_end_time;
>> +
>> +	int battery_status;
>>  };
>=20
> Should battery_status be some kind of enum?


Currently, it stores only enum of power_supply class's and it doesn't h=
ave
specified type. And also, I didn't want to make additional private enum=
s.
I'd let it to be as it was.

Thanks,
Jonghwa

> 									Pavel
> --					=09
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
>=20


