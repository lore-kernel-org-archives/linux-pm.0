From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] speedstep-smi: enable interrupts when waiting
Date: Wed, 11 Feb 2015 15:18:32 +0100
Message-ID: <1752773.hF78BPjAlO@vostro.rjw.lan>
References: <alpine.LRH.2.02.1502091337090.18363@file01.intranet.prod.int.rdu2.redhat.com> <CAKohpomf0R9ufRFCe9bwoZLox=sqwbVwgk5Nv5V1CFv58kaK4g@mail.gmail.com> <alpine.LRH.2.02.1502110558400.4608@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50245 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752374AbbBKNz1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 08:55:27 -0500
In-Reply-To: <alpine.LRH.2.02.1502110558400.4608@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wednesday, February 11, 2015 06:01:27 AM Mikulas Patocka wrote:
> 
> On Wed, 11 Feb 2015, Viresh Kumar wrote:
> 
> > On 10 February 2015 at 02:38, Mikulas Patocka <mpatocka@redhat.com> wrote:
> > > On Dell Latitude C600 laptop with Pentium 3 850MHz processor, the
> > > speedstep-smi driver sometimes loads and sometimes doesn't load with
> > > "change to state X failed" message.
> > >
> > > The hardware sometimes refuses to change frequency and in this case, we
> > > need to retry later. I found out that we need to enable interrupts while
> > > waiting. When we enable interrupts, the hardware blockage that prevents
> > > frequency transition resolves and the transition is possible. With
> > > disabled interrupts, the blockage doesn't resolve (no matter how long do
> > > we wait). The exact reasons for this hardware behavior are unknown.
> > >
> > > This patch enables interrupts in the function speedstep_set_state that can
> > > be called with disabled interrupts. However, this function is called with
> > > disabled interrupts only from speedstep_get_freqs, so it shouldn't cause
> > > any problem.
> > >
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com
> > > Cc: stable@vger.kernel.org
> > >
> > > ---
> > >  drivers/cpufreq/speedstep-lib.c |    3 +++
> > >  drivers/cpufreq/speedstep-smi.c |   12 ++++++++++++
> > >  2 files changed, 15 insertions(+)
> > 
> > It looks it was reviewed/Acked long time back, what happened
> > then ?
> 
> I don't know. You acknowledged it, but didn't put it upstream.

That's probably my fault then, because I didn't apply it.

OK, I'll queue it up for the next pull request with an ACK from Viresh.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
