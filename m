From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Thu, 31 Mar 2016 01:28:59 +0200
Message-ID: <CAJZ5v0iZB0Peb3ReupM0sr3MfKgCWAgH1eNvjNd2uyZS9gptkg@mail.gmail.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
	<1459376311.13525.108.camel@linux.intel.com>
	<56FC5277.9050906@intel.com>
	<1459378003.13525.117.camel@linux.intel.com>
	<1459379847.13525.129.camel@intel.com>
	<CA+icZUVXtba6eK3pC42V68Y1c_rXzzTcK36uhAAOz58_9yJNfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:35927 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbcC3X3B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 19:29:01 -0400
In-Reply-To: <CA+icZUVXtba6eK3pC42V68Y1c_rXzzTcK36uhAAOz58_9yJNfg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "dsmythies@telus.net" <dsmythies@telus.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jrg.otte@gmail.com" <jrg.otte@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>

On Thu, Mar 31, 2016 at 1:25 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Thu, Mar 31, 2016 at 1:17 AM, Pandruvada, Srinivas
> <srinivas.pandruvada@intel.com> wrote:
>> On Wed, 2016-03-30 at 15:46 -0700, Srinivas Pandruvada wrote:
>>> On Thu, 2016-03-31 at 00:25 +0200, Rafael J. Wysocki wrote:
>>> >
>>> > On 3/31/2016 12:18 AM, Srinivas Pandruvada wrote:
>>> > >
>>> > >
>>> > > On Wed, 2016-03-30 at 23:41 +0200, Sedat Dilek wrote:
>>> > > >
>>> > > >
>>> > > > Hi,
>>> > > >
>>> > > > I am using Intel-PState-Driver here with v4.6-rc1 and Intel-
>>> > > > SandyBridge-CPU.
>>> > > >
>>> > > > Here are my turbostat results attached.
>>> > > >
>>> > > > $ cd $BUILD_DIR
>>> > > > $ LC_ALL=C make -C tools/ turbostat
>>> > > >
>>> > > > $ sudo ./turbostat -i 1 --msr=0x199 --debug --out
>>> > > > /tmp/turbostat-i-1-msr-0x199-debug.txt
>>> > > >
>>> > > > Will try <https://patchwork.kernel.org/patch/8702071/>.
>>> > > >
>>> > > > Please see attached files.
>>> > > >
>>> > > Thanks. Your logs make sense. You have config set to performance
>>> > > mode
>>> > > by default (Which I believe default in all kernel Ubuntu). So as
>>> > > expected Intel P state was asking for max. So there is no issue
>>> > > here.
>>> > But the behavior is different from what it used to be, isn't it?
>>> >

[cut]

>
> Too much questions.

OK

> I switched to CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y and tested with
> the simplified revert-patch of Rafael.

Why do you need the revert patch in the first place?
