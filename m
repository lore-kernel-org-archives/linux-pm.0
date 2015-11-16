From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 10/11] PM / Hibernate: clean cached pages on architectures
 that require it
Date: Mon, 16 Nov 2015 12:27:07 +0000
Message-ID: <5649CB9B.30102@arm.com>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com> <1445966960-31724-11-git-send-email-james.morse@arm.com> <20151114202623.GC20429@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49042 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbbKPM1y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 16 Nov 2015 07:27:54 -0500
In-Reply-To: <20151114202623.GC20429@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>

On 14/11/15 20:26, Pavel Machek wrote:
> On Tue 2015-10-27 17:29:19, James Morse wrote:
>> Some architectures require code written to memory as if it were data=
 to be
>> 'cleaned' from any data caches so that the processor can fetch them =
as new
>> instructions.
>>
>> During resume from hibernate, the snapshot code copies some pages di=
rectly,
>> meaning these architectures do not get a chance to perform their cac=
he
>> maintenance. Add a call to flush_icache_range(), which is provided b=
y
>> architectures that require it, to perform the maintenance.
>>
>> This mirrors the kernel's behaviour when loading kernel modules and =
when
>> mapping executable pages to user space.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>=20
> Looks reasonable.
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks!

>=20
>> ---
>>  kernel/power/snapshot.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
>> index 5235dd4e1e2f..139fc449ad75 100644
>> --- a/kernel/power/snapshot.c
>> +++ b/kernel/power/snapshot.c
>> @@ -1196,9 +1197,12 @@ static unsigned int count_data_pages(void)
>>  static inline void do_copy_page(long *dst, long *src)
>>  {
>>  	int n;
>> +	unsigned long __maybe_unused start =3D (unsigned long)dst;
>=20
> Why the "maybe unused"?

To avoid a build warning on x86_64, and any other architectures that do=
n't
use the arguments in their flush_icache_range() implementation.

Without __maybe_unused, gcc 4.9.2, building for x86_64:
> ../kernel/power/snapshot.c: In function =91do_copy_page=92:
> ../kernel/power/snapshot.c:1200:16: warning: unused variable =91start=
=92
> [-Wunused-variable]
>  unsigned long start =3D (unsigned long)dst;


>>  	for (n =3D PAGE_SIZE / sizeof(long); n; n--)
>>  		*dst++ =3D *src++;
>> +
>> +	flush_icache_range(start, start+PAGE_SIZE);
>>  }


Thanks,

James

