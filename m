From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Thu, 31 Mar 2016 00:29:22 +0200
Message-ID: <CAJZ5v0jcyj17Z9Arhc7vA5Vx2EotK_jUnnjvDwC2gS_1CxbAoA@mail.gmail.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
	<56FC4C11.40405@intel.com>
	<CA+icZUXC05FASispPxHfCe2WwtkUFdhgetnrbCNogzcjoK3ECQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33086 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbcC3W3Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 18:29:24 -0400
In-Reply-To: <CA+icZUXC05FASispPxHfCe2WwtkUFdhgetnrbCNogzcjoK3ECQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>, =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>, Linux PM List <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>

On Thu, Mar 31, 2016 at 12:23 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Wed, Mar 30, 2016 at 11:58 PM, Rafael J. Wysocki
> <rafael.j.wysocki@intel.com> wrote:
>> On 3/30/2016 11:41 PM, Sedat Dilek wrote:
>>>
>>> Hi,
>>>
>>> I am using Intel-PState-Driver here with v4.6-rc1 and
>>> Intel-SandyBridge-CPU.
>>>
>>> Here are my turbostat results attached.
>>>
>>> $ cd $BUILD_DIR
>>> $ LC_ALL=C make -C tools/ turbostat
>>>
>>> $ sudo ./turbostat -i 1 --msr=0x199 --debug --out
>>> /tmp/turbostat-i-1-msr-0x199-debug.txt
>>>
>>> Will try <https://patchwork.kernel.org/patch/8702071/>.
>>>
>>> Please see attached files.
>>
>>
>> Thanks for the report.
>>
>> The address of linux-pm in your original message was incorrect.  Can you
>> please resend the turbostat output in reply to this message?
>>
>
> Sorry for the wrong ML.
>
> Attached are new (-12 with your simplified revert) and old turbostat outputs.

So the simplified revert doesn't help - or does it?
