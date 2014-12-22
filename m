From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH V3 11/11] power: charger-manager: Support to change polling
 rate in runtime.
Date: Mon, 22 Dec 2014 10:57:17 +0900
Message-ID: <54977A7D.2060301@samsung.com>
References: <1418979323-7188-1-git-send-email-jonghwa3.lee@samsung.com>
 <1418979323-7188-12-git-send-email-jonghwa3.lee@samsung.com>
 <20141220002908.GD1694@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37587 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbaLVB5T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Dec 2014 20:57:19 -0500
In-reply-to: <20141220002908.GD1694@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com

On 2014=EB=85=84 12=EC=9B=94 20=EC=9D=BC 09:29, Pavel Machek wrote:

>=20
>> Add 'polling_ms' sysfs node to change charger-manager's monitoring r=
ate
>> in runtime. It can set only bigger than 2 jiffies (for 200 HZ system=
 it
>> is 10 msecs.) as it's allowed for minimum poling rate in previous.
>=20
> New sysfs filesneed documentation.
>=20
>> It resets poller and re-configure polling rate based on new input if=
 next
>=20
> re-configures...", if"
>=20
>> polling time is far enough. Otherwise, it just waits expiration of t=
imer
>=20
> "waits for"
>=20
>> and new polling rate will affects the next scheduling.
>=20
> "affect"?
>=20


Sorry for so many typos.. including above typos I'll revise all of them=
=2E

>=20
>> +static ssize_t show_polling_ms(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	struct charger_manager *cm;
>> +	ssize_t len;
>> +
>> +	list_for_each_entry(cm, &cm_list, entry)
>> +		if (cm->charger_psy.dev =3D=3D dev)
>> +			break;
>> +
>> +	if (cm->charger_psy.dev !=3D dev)
>> +		return -EINVAL;
>=20
> Any chance to reorganize data structures so that this kind of list
> walking is not neccessary?
>=20


No need to reorganize, I'll fix it to get target data without unnecessa=
ry
iteration.

>> +static ssize_t store_polling_ms(struct device *dev,
>> +				struct device_attribute *attr, const char *buf,
>> +				size_t count)
>> +{
>> +	struct charger_manager *cm;
>> +	int polling_ms;
>> +	int ret;
>> +
>> +	ret =3D sscanf(buf, "%d", &polling_ms);
>=20
> "kstrtoul"?
>=20


Yes, it would be better. I'll modify it either.

Thanks for reviewing.
Jonghwa

> 									Pavel


