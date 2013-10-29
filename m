From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] power_supply: Fix documentation for TEMP_*ALERT*
 properties
Date: Mon, 28 Oct 2013 20:13:33 -0700
Message-ID: <20131029031333.GA4269@teo>
References: <1382676798-27835-1-git-send-email-jonghwa3.lee@samsung.com>
 <20131025231720.GB9015@teo>
 <526DC554.30506@samsung.com>
 <20131028052743.GA31070@teo>
 <20131028172008.GA29544@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:46030 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756783Ab3J2DNh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2013 23:13:37 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so6307286pad.27
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2013 20:13:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131028172008.GA29544@animalcreek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: jonghwa3.lee@samsung.com, linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Ramakrishna Pallala <ramakrishna.pallala@intel.com>

On Mon, Oct 28, 2013 at 10:20:08AM -0700, Mark A. Greer wrote:
> On Sun, Oct 27, 2013 at 10:27:43PM -0700, Anton Vorontsov wrote:
> > All temperatures should be in tenth degrees Celsius.
> 
> > bq24190_charger.c probably should be fixed.
...
> I missed the beginning of this thread so I may be missing something but
> the bq24190_charger driver already uses tenth of degrees Celcius for
> POWER_SUPPLY_PROP_TEMP_ALERT_MAX.  IIUC, that's correct so there's is
> nothing to fix in the bq24190_charger.c driver, correct?

Yup, correct. Thanks a lot for confirming!

Anton
