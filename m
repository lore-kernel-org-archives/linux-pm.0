From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: Fix KELVIN_TO_CELSIUS macro
Date: Thu, 03 Apr 2014 10:40:41 +0800
Message-ID: <1396492841.2357.21.camel@rzhang1-mobl4>
References: <1395634496-25040-1-git-send-email-linux@roeck-us.net>
	 <1395635132.13968.40.camel@joe-AO722> <532FC307.7050202@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23250 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932656AbaDCCku (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Apr 2014 22:40:50 -0400
In-Reply-To: <532FC307.7050202@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Joe Perches <joe@perches.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

On Sun, 2014-03-23 at 22:30 -0700, Guenter Roeck wrote:
> On 03/23/2014 09:25 PM, Joe Perches wrote:
> > On Sun, 2014-03-23 at 21:14 -0700, Guenter Roeck wrote:
> >> It is always a good idea to use paranthesis around macro parameters
> >> to avoid undesired side effects.
> >>
> >> In this specific case, KELVIN_TO_CELSIUS() is used in
> >> drivers/platform/x86/asus-wmi.c with parameter "value & 0xFFFF",
> >> which due to operator evaluation order causes more or less random
> >> results.
> >
> > Maybe it's better to use a statement expression to avoid
> > multiple calculations of t
> >
> > Maybe;
> >
> > #define KELVIN_TO_CELSIUS(t)				\
> > ({							\
> > 	long _t = (long)(t) - 2732;			\
> > 	_t >= 0 ? (_t + 5) / 10 : (_t - 5) / 10;	\
> > })
> >
> >
> 
> Possibly, but I only want to have a bug fixed which should possibly be applied
> to -stable at some point. As such, I prefer the minimalistic approach.
> Anything more fancy on top of that can be submitted as separate patch.
> 
I agreed. I will take this patch and push it for stable kernel.

thanks,
rui

