From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 1/2 linux-next] cpufreq: pxa: replace typedef pxa_freqs_t by structure
Date: Fri, 15 May 2015 02:12:02 +0200
Message-ID: <3235672.1qyoOA5Ogh@vostro.rjw.lan>
References: <1430469241-30556-1-git-send-email-fabf@skynet.be> <CAKohpo=tgE95M-DeNub0z-ZBqW3vi_4nMzBtyDXKh13AJP9NbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59968 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933283AbbENXqu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 19:46:50 -0400
In-Reply-To: <CAKohpo=tgE95M-DeNub0z-ZBqW3vi_4nMzBtyDXKh13AJP9NbA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Fabian Frederick <fabf@skynet.be>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Friday, May 01, 2015 08:31:19 PM Viresh Kumar wrote:
> On 1 May 2015 at 14:04, Fabian Frederick <fabf@skynet.be> wrote:
> > typedef is not really useful here. Replace it by structure
> > to improve readability. typedef should only be used in some cases.
> > (See Documentation/CodingStyle Chapter 5 for details).
> >
> > Signed-off-by: Fabian Frederick <fabf@skynet.be>
> > ---
> > Compiled but untested.
> >
> > V3: -constify arrays(patch 2) (suggested by Joe Perches)
> >     -fix typo in changelog (thanks to Viresh Kumar)
> > V2: -verbose changelog.
> >
> >  drivers/cpufreq/pxa2xx-cpufreq.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> For both patches:
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Both queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
