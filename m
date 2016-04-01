From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Fri, 1 Apr 2016 22:24:00 +0200
Message-ID: <CAJZ5v0iFgWFs+pMCJQgeiTH=zTg1pfSUa4gPGX7q2jB40dcUHA@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<8393335.Q1cjiaGecN@vostro.rjw.lan>
	<CADDKRnBE==ea7YvXH+YL_m1v8E1zNHsZnXJgc58OQ=vrcs+cKQ@mail.gmail.com>
	<2727017.UmaUvtBLeX@vostro.rjw.lan>
	<CADDKRnAYPXip0EG0Y7ADuyt9L=FL-Nd1giHBVvPexs4kGkRj4g@mail.gmail.com>
	<1459446905.4569.76.camel@linux.intel.com>
	<CADDKRnCy9frh3CZcz+4WhiFJHk1GmMbPB847iUKW2wOex7hGSw@mail.gmail.com>
	<1459523120.5912.20.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35184 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbcDAUYD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 16:24:03 -0400
In-Reply-To: <1459523120.5912.20.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

On Fri, Apr 1, 2016 at 5:05 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Fri, 2016-04-01 at 11:42 +0200, J=C3=B6rg Otte wrote:
>> 2016-03-31 19:55 GMT+02:00 Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com>:
>> > On Thu, 2016-03-31 at 19:27 +0200, J=C3=B6rg Otte wrote:
>> > > 2016-03-31 17:43 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>=
:
>> > > > On Thursday, March 31, 2016 05:25:18 PM J=C3=B6rg Otte wrote:
>> > > > > 2016-03-31 13:42 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.=
n
>> > > > > et>:
>> > > > > > On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wro=
te:
> [cut]
>
>> I compile a minimum kernel for my notebook. The hardware is fix and
>> will never change. So I don't need thousends of modules to compile.
>> Kbuild supports this with target "localmodconfig".
>> In the rare cases where I get new usb-hardware I add a new driver
>> and compile a new kernel which takes only a minute.
>>
> With this minimum config, I am not able to properly run my laptop to
> reproduce.
> May be something odd in this config is triggering this issue, we are
> not going to idle on some CPUs.

You can use ./scripts/diffconfig (in the kernel source tree) to find
differences between your working config and the J=C3=B6rg's one and try=
 to
flip the bits that may matter in your config.
