From: Oliver Neukum <oneukum@suse.com>
Subject: Re: Huawei integrated modem causes instant resume from suspend on
 Acer P648-G3
Date: Wed, 04 Oct 2017 15:31:43 +0200
Message-ID: <1507123903.9577.13.camel@suse.com>
References: <20170927061446.15512-1-drake@endlessm.com>
         <1506496379.28482.1.camel@suse.com>
         <CAD8Lp44pcN_GE0qKLioYH2dPpvEFLx604bvSVen4xR5ph=QEtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752317AbdJDNcA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Oct 2017 09:32:00 -0400
In-Reply-To: <CAD8Lp44pcN_GE0qKLioYH2dPpvEFLx604bvSVen4xR5ph=QEtg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-pm@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>

Am Montag, den 02.10.2017, 10:23 +0800 schrieb Daniel Drake:
> On Wed, Sep 27, 2017 at 3:12 PM, Oliver Neukum <oneukum@suse.com> wrote:
> > 
> > 1) kernel version?
> 
> Currently testing 4.14.0-rc2 but reproduced on multiple older versions
> too going back to 4.8. (Have not found a working kernel version)
> 
> > 
> > 2) driver used?
> 
> The problem is reproducible just with the base usb driver, without any
> USB modem drivers loaded. (It would ordinarily load option and
> cdc-ether)

Hi,

this sucks in a major way. I am dismayed at the quality of some hardware.
It looks like your patch, which is a brutal sledge hammer, is indeed
needed and the correct approach.

It suggest you resubmit it with an updated change log containing
the what you wrote in your last mail.

	Regards
		Oliver
