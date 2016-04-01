From: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Subject: Re: [PATCH] x86: Calculate MHz using APERF/MPERF for cpuinfo and scaling_cur_freq
Date: Fri, 1 Apr 2016 11:30:48 +0200
Message-ID: <7239BF36-2C27-4325-A5B8-01BC4CA58B4C@linux.intel.com>
References: <6e0c25e64e0fb65a42dfc63ad5f660302e07cd87.1459485198.git.len.brown@intel.com> <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com> <20160401080328.GC3448@twins.programming.kicks-ass.net> <9222CD56-C603-449C-A049-E518DAFA6883@linux.intel.com> <20160401082323.GE3448@twins.programming.kicks-ass.net> <20160401082923.GH11035@twins.programming.kicks-ass.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:29385 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbcDAJav convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 05:30:51 -0400
In-Reply-To: <20160401082923.GH11035@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

my comment was about your comment that MSR have wrapped however many ti=
mes



> On Apr 1, 2016, at 10:03 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
>=20
> That is; if userspace doesn't request a freq reading we can go withou=
t
> reading this for a very long time.
>=20
>> +
>> +	rdmsrl(MSR_IA32_APERF, aperf);
>> +	rdmsrl(MSR_IA32_MPERF, mperf);
>> +
>> +	aperf_delta =3D aperf - s->aperf;
>> +	mperf_delta =3D mperf - s->mperf;
>=20
> That means these delta's can be arbitrarily large, in fact the MSRs c=
an
> have wrapped however many times.

The MSRs will not wrap that often.

=E2=80=94
Steph




> On Apr 1, 2016, at 10:29 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
>=20
> On Fri, Apr 01, 2016 at 10:23:23AM +0200, Peter Zijlstra wrote:
>>=20
>> Trim your emails
>>=20
>> On Fri, Apr 01, 2016 at 10:16:42AM +0200, Stephane Gasparini wrote:
>>=20
>>>> That means these delta's can be arbitrarily large, in fact the MSR=
s can
>>>> have wrapped however many times.
>>>=20
>>> 64 bits is 18 446 744 073 709 551 615
>>>=20
>>> so even assuming a 10 GHz frequency if my math are good this is mor=
e than
>>> 58 years before the MSR wrap around, assuming the device ran always=
 at max
>>> freq.
>>=20
>> fair enough.. but going with 10Ghz, cpu_khz would be 10e6 ~ 33 bits,
>=20
> I can't do maths this morning; 23 bits
>=20
>> which effectively reduces the wrap/overflow time to just 31 bits, wh=
ich
>> per that frequency is just ~1/4th of a second.
>=20
> 41 giving lots more, but a reasonable time to wrap/overflow.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

