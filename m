From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: intel_soc_dts_thermal binding issues
Date: Mon, 9 Mar 2015 09:11:54 -0400
Message-ID: <CA+5PVA5tAkdf2=YOpq3qu1i8azTu=+kbQBsyB4Ze+qRzcE3KjQ@mail.gmail.com>
References: <CA+5PVA7SZ+csY8WwMkwRa-nOmsHP8SdVe4v=mUmq38RJ4LSsyA@mail.gmail.com>
	<744357E9AAD1214791ACBA4B0B90926301491FCF@SHSMSX101.ccr.corp.intel.com>
	<CA+5PVA58q==ieDyfoMEsJ=TxLXXRdNPoKC5gNWAg0MdTv4Eq+g@mail.gmail.com>
	<744357E9AAD1214791ACBA4B0B9092630149275F@SHSMSX101.ccr.corp.intel.com>
	<CA+5PVA6oBotk-SLnwYvpAp-U+sPt+pRP-0AtyAD2H+qnekEqAg@mail.gmail.com>
	<1425868993.3944.30.camel@spandruv-mobl2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:41436 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239AbbCINLz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2015 09:11:55 -0400
In-Reply-To: <1425868993.3944.30.camel@spandruv-mobl2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sun, Mar 8, 2015 at 10:43 PM, Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
> On Fri, 2015-03-06 at 08:51 -0500, Josh Boyer wrote:
>> On Thu, Mar 5, 2015 at 8:37 PM, Zhang, Rui <rui.zhang@intel.com> wrote:
>> > Please attach the acpidump output.
>>
>> Attached for my machine.
>>
> There is no INT3401 in the acpi dump. Also no one registered IRQ 86.
> So the request_irq failing.
> It is not a problem, this platform can't support.
> Do we want to silently bail out?

That's what I was originally suggesting, yes.  People see the failing
request_irq in dmesg and think it's an error.

josh
