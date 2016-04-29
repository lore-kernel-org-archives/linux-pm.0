From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/1] cpupower: Add cpuidle library
Date: Fri, 29 Apr 2016 08:57:50 +0200
Message-ID: <31806757.JiaQphXfhu@skinner>
References: <1685056.NeGEfvDZMv@skinner> <9049803.y9XhT0fdX4@skinner> <CAJZ5v0hpwK=G=HCRk17f1v=nNtKGoVqc77cbRPtiGVpy2Tfg2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32953 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbcD2G5w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 29 Apr 2016 02:57:52 -0400
In-Reply-To: <CAJZ5v0hpwK=G=HCRk17f1v=nNtKGoVqc77cbRPtiGVpy2Tfg2A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arjun Sreedharan <arjun024@gmail.com>

On Thursday, April 28, 2016 05:37:38 PM Rafael J. Wysocki wrote:
> On Thu, Apr 28, 2016 at 3:23 PM, Thomas Renninger <trenn@suse.de> wrote:
> > On Tuesday, April 26, 2
...

> > This should now more or less match with what patchwork
> > gives you?
> 
> That's about right.  There is one more patch in Patchwork that is not
> present in your series:
> 
> https://patchwork.kernel.org/patch/8301391/

Thanks, I have overseen this one.
 
> I've queued up your series for 4.7, but I'm still unsure about the above
> one.

Ah, I also wanted to fix this and then decided it's not worth it.
But now that we have a patch (compile tested from my side, looks
correct).

This fixes cppcheck error:

Checking bench/parse.c...
[bench/parse.c:91]: (error) Common realloc mistake: 'filename' nulled but not 
freed upon failure

I had to merge this one on top of the others, I'll send the adjusted
version in a minute.

Thanks!

       Thomas
