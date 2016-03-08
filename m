From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Do not modify MSR_IA32_ENERGY_PERF_BIAS in kernel
Date: Mon, 7 Mar 2016 19:50:57 -0500
Message-ID: <CAJvTdKnJSqCxVhriMUJfeRL=ogpG2GYgSJ5anvbjrbm_rNyKcQ@mail.gmail.com>
References: <4687430.mfM0GbdeDL@skinner>
	<16028318.H9OZ9hFYY1@skinner>
	<11753995.6ynq8tUiQx@vostro.rjw.lan>
	<1770444.1VxdmEr8lv@skinner>
	<CAJZ5v0ie-itnxERzA3nhd0VnQUo07MsoyS3+WL+3sm5V+sMTJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35717 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbcCHAu7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2016 19:50:59 -0500
In-Reply-To: <CAJZ5v0ie-itnxERzA3nhd0VnQUo07MsoyS3+WL+3sm5V+sMTJg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> But with Broadwell-EP processor (E5-2687W v4) the CPU will not enter turbo modes
> if this value is not set to performance

BDX-EP supports HWP.
Are these failing machines running in HWP mode?

(On BDX-EP, and only on BDX-EP, EPB acts to set the BIAS for HWP,
 because that processor doesn't yet have EPP.)

-- 
Len Brown, Intel Open Source Technology Center
