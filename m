From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] intel powerclamp: support Knights Landing
Date: Tue, 23 Jun 2015 21:51:32 +0200
Message-ID: <CAJZ5v0iZ5ectdQ0c+YnXqoTABMBR8FgL=ZSH+341535uP==fpg@mail.gmail.com>
References: <1429309866-63063-1-git-send-email-dasaratharaman.chandramouli@intel.com>
	<20150424145835.53888d75@ultegra>
	<56FD0D4EC3679746A2BD9228E7E608363E2A974D@ORSMSX114.amr.corp.intel.com>
	<1461618.eAjGphZVRG@vostro.rjw.lan>
	<1435085188.29834.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33286 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbbFWTvd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 15:51:33 -0400
In-Reply-To: <1435085188.29834.9.camel@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Rao, Nikhil" <nikhil.rao@intel.com>

On Tue, Jun 23, 2015 at 8:46 PM, Dasaratharaman Chandramouli
<dasaratharaman.chandramouli@intel.com> wrote:
> On Tue, 2015-06-23 at 01:39 +0200, Rafael J. Wysocki wrote:
>> On Monday, June 22, 2015 04:51:13 PM Chandramouli, Dasaratharaman wrote:
>> > Can we make this patch available for 4.2
>>
>> It is included in the power management and ACPI pull request for 4.1-rc1
>> I've just sent.
>
> I just checked the branch pm+acpi-4.2-rc1 and i don't see the Knights
> Landing patch for the powerclamp driver in that. Kindly verify that it
> was added.
>
> https://lkml.org/lkml/2015/4/17/795

I was talking about the RAPL driver, sorry for the noise.

The powerclamp one is the Rui's area.  Rui, what's the status of this one?

Rafael
