From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] power_supply: Fix documentation for TEMP_*ALERT*
 properties
Date: Sun, 27 Oct 2013 23:43:44 -0700
Message-ID: <20131028064344.GA2290@teo>
References: <1382676798-27835-1-git-send-email-jonghwa3.lee@samsung.com>
 <20131025231720.GB9015@teo>
 <526DC554.30506@samsung.com>
 <20131028052743.GA31070@teo>
 <526E02BD.5080107@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:50511 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab3J1Gns (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2013 02:43:48 -0400
Received: by mail-pb0-f42.google.com with SMTP id jt11so6050803pbb.29
        for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2013 23:43:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <526E02BD.5080107@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jonghwa3.lee@samsung.com
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Ramakrishna Pallala <ramakrishna.pallala@intel.com>

On Mon, Oct 28, 2013 at 03:22:53PM +0900, jonghwa3.lee@samsung.com wrote:
> > All temperatures should be in tenth degrees Celsius.
> 
> Let me tell you one thing that thermal framework uses milli centigrade for
> temperature. And also we have some relation with thermal framework already in
> power suppply core. So, what do think of using milli centigrade in power supply
> class either?

Since tenth degrees stuff has been exposed to the userland for 5+ years we
can't just change it. So, no.

If for any reason you need a higher precision temperatures (do you?), then
you are welcome to introduce a set of new properties with a _MILLI affix.

Anton
