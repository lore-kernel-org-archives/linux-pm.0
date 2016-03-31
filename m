From: "Navin P.S" <navinp1912@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Thu, 31 Mar 2016 12:58:44 +0530
Message-ID: <CAA=4087EuSwTH1hivdrw_vGsyTtD8buMCZ9vHuf3x0J0q-697A@mail.gmail.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
 <1459376311.13525.108.camel@linux.intel.com> <56FC5277.9050906@intel.com>
 <1459378003.13525.117.camel@linux.intel.com> <1459379847.13525.129.camel@intel.com>
 <CA+icZUVXtba6eK3pC42V68Y1c_rXzzTcK36uhAAOz58_9yJNfg@mail.gmail.com>
 <CAJZ5v0iZB0Peb3ReupM0sr3MfKgCWAgH1eNvjNd2uyZS9gptkg@mail.gmail.com>
 <CA+icZUUaGdeRLnvLRN6L1FXuf_cpQStRsEOmZr9Sm+YPZsR=kA@mail.gmail.com>
 <CAJZ5v0h7bvhWkCAcvGQ=QjDOmV6D0X0rc9zGLQUOwCtHp021UQ@mail.gmail.com> <CAA=4085Mmv7gRpJid8UGQ4ti6c1HhaENnogd8aPrg6E-w68QWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35303 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbcCaH3Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 03:29:25 -0400
In-Reply-To: <CAA=4085Mmv7gRpJid8UGQ4ti6c1HhaENnogd8aPrg6E-w68QWg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, sedat.dilek@gmail.com
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "dsmythies@telus.net" <dsmythies@telus.net>, "jrg.otte@gmail.com" <jrg.otte@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

>
> On Thu, Mar 31, 2016, 5:12 AM Rafael J. Wysocki <rafael@kernel.org> w=
rote:
>>
>> On Thu, Mar 31, 2016 at 1:32 AM, Sedat Dilek <sedat.dilek@gmail.com>
>> wrote:
>> > On Thu, Mar 31, 2016 at 1:28 AM, Rafael J. Wysocki <rafael@kernel.=
org>
>> > wrote:
>> >> On Thu, Mar 31, 2016 at 1:25 AM, Sedat Dilek <sedat.dilek@gmail.c=
om>
>> >> wrote:
>> >>> On Thu, Mar 31, 2016 at 1:17 AM, Pandruvada, Srinivas
>> >>> <srinivas.pandruvada@intel.com> wrote:
>> >>>> On Wed, 2016-03-30 at 15:46 -0700, Srinivas Pandruvada wrote:
>> >>>>> On Thu, 2016-03-31 at 00:25 +0200, Rafael J. Wysocki wrote:
>> >>>>> >
>> >>>>> > On 3/31/2016 12:18 AM, Srinivas Pandruvada wrote:
>> >>>>> > >
>> >>>>> > >
>> >>>>> > > On Wed, 2016-03-30 at 23:41 +0200, Sedat Dilek wrote:
>> >>>>> > > >
>> >>>>> > > >
>> >>>>> > > > Hi,
>> >>>>> > > >
>> >>>>> > > > (snipped)
>>
>> But it is not clear to us whether or not your system has regressed
>> with respect to 4.5, which is the whole point of this thread.  Do yo=
u
>> see a regression here?
>>
>> J=C3=B6rg in particular is saying that he sees the problem with both
>> performance and powersave settings.  What about you?

Resend.


 https://bugzilla.kernel.org/show_bug.cgi?id=3D114741

I was looking through ubsan and found this relevant.Hp envy runs on
x64 but the bug seems to mention (ia64).

 I see two versions rdmsrl and rdmsrl_safe.
These values are filled by rdmsrl .Does changing to safe function help =
=2E

 Can an exception ever happen in case of  MSR_IA32_APERF ?

Those values certainly cannot be negative and so huge.
