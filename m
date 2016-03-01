From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 06/16] tools/power turbostat: allow sub-sec intervals
Date: Tue, 1 Mar 2016 02:07:57 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C948469DFD5D@fmsmsx115.amr.corp.intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
 <24781860a144a6792cb7697307f36b4486b611da.1456563103.git.len.brown@intel.com>
 <001201d171da$22f11850$68d348f0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:25530 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbcCACIA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 21:08:00 -0500
In-Reply-To: <001201d171da$22f11850$68d348f0$@net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, 'Len Brown' <lenb@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> > From: Len Brown <len.brown@intel.com>
> >
> > turbostat -i interval_sec
> >
> > will sample and display statistics every interval_sec.
> > interval_sec used to be a whole number of seconds,
> > but now we accept a decimal, as small as 0.001 sec (1 ms).
> 
> Shouldn't you be cautious allowing this?
> At such a high sampling rate, the user can significantly
> effect the system being measured with turbostat's own overhead.
>
> I tried down to 1 millisecond, and noted greatly
> reduced C6 time (my processor only goes to C6), greatly increased
> busy% for all CPU's, over 4 watts extra package power, ...

turbostat provides a 5.000 second default sampling interval.
If a user chooses to explicitly change that default,
I have to trust that they are doing it for a good reason.

I agree, measuring deep idle state residency would not be a good reason.

cheers,
-Len

