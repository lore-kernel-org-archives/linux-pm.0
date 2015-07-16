From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: enable hwp per cpu
Date: Thu, 16 Jul 2015 02:36:33 +0200
Message-ID: <7139661.QXFVRl2gk6@vostro.rjw.lan>
References: <1436892383-4217-1-git-send-email-kristen@linux.intel.com> <CADjb_WSyVQNeeKEoC+MEUfwZTEpzuAO8-Bwae24Z49vJCKewTQ@mail.gmail.com> <20150715074145.686897b7@kcaccard-desk.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43285 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753827AbbGPAJz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 20:09:55 -0400
In-Reply-To: <20150715074145.686897b7@kcaccard-desk.amr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: yu chen <yu.chen.surf@gmail.com>, linux-pm@vger.kernel.org

On Wednesday, July 15, 2015 07:41:45 AM Kristen Carlson Accardi wrote:
> On Wed, 15 Jul 2015 19:17:53 +0800
> yu chen <yu.chen.surf@gmail.com> wrote:
> 
> > On Wed, Jul 15, 2015 at 1:58 AM, Kristen Carlson Accardi
> > <kristen@linux.intel.com> wrote:
> > 
> > >
> > > Oops - don't apply this one yet please.  I think I
> > > might have broken S3 resume.
> > >
> > 
> > Hi, Kristen
> > This patch will fix the S3 resume panic bug.
> > We encountered panic on kernel without this patch applied last week.
> > After this patch applied,  each cpu will get a chance to
> > re-enable HWP in intel_pstate_cpu_init, after resuming.
> > 
> > Yu
> 
> Ok.  Rafael, would you mind applying the patch after all?  False
> alarm :).

OK, queuing up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
