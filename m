From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: linux-pm build failure
Date: Sat, 10 May 2014 09:22:05 +0300
Message-ID: <536DC58D.6010707@semaphore.gr>
References: <536BBAF8.6040601@semaphore.gr> <2930403.UViFFypGRj@vostro.rjw.lan> <536C3337.40402@intel.com> <12185110.9TpRMrqnbe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:60062 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751024AbaEJGWJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 10 May 2014 02:22:09 -0400
In-Reply-To: <12185110.9TpRMrqnbe@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lan Tianyu <tianyu.lan@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 10/05/2014 12:36 =CF=80=CE=BC, Rafael J. Wysocki wrote:
> On Friday, May 09, 2014 09:45:27 AM Lan Tianyu wrote:
>> On 2014=E5=B9=B405=E6=9C=8809=E6=97=A5 03:44, Rafael J. Wysocki wrot=
e:
>>> On Thursday, May 08, 2014 08:12:24 PM Stratos Karafotis wrote:
>>>> Hi all,
>>>
>>> Hi,
>>>
>>> Thanks for the report!
>>>
>>> This is caused by commit
>>>
>>> 0e23847d5ee4 ACPICA: Export acpi_buffer_to_resource symbol
>>>
>>> merged on top of the recent ACPICA material.
>>>
>>> Lv, Tianyu, care to take care of this?
>>
>> Hi Rafael:
>> 	Just check commit 51e35823eb57 and find it also exports
>> acpi_buffer_to_resource symbol which commit 0e23847d5ee4 has already
>> done. I think you can drop commit 0e23847d5ee4 which only exports sy=
mbol
>> without any other changes.
>=20
> Done, thanks!
>=20

Now it builds fine!

Thank you!
Stratos
