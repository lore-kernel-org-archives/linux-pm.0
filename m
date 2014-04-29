From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 0/4] RAPL driver updates
Date: Tue, 29 Apr 2014 16:38:28 -0700
Message-ID: <20140429163828.040c0f97@ultegra>
References: <1398693880-13428-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1398810789-2301-1-git-send-email-david.e.box@linux.intel.com>
	<2848366.d6jLR9v0Ov@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36375 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703AbaD2Xid (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Apr 2014 19:38:33 -0400
In-Reply-To: <2848366.d6jLR9v0Ov@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "David E. Box" <david.e.box@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, hpa@linux.intel.com, alan@linux.intel.com, durgadoss.r@intel.com, kristen.c.accardi@intel.com

On Wed, 30 Apr 2014 01:02:36 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Tuesday, April 29, 2014 03:33:05 PM David E. Box wrote:
> > From: "David E. Box" <david.e.box@linux.intel.com>
> > 
> > v2: iosf: Remove Kconfig exposure. Make mailbox driver a module.
> > 
> > David E. Box (1):
> >   x86/iosf: Make IOSF driver modular and usable by more drivers
> > 
> > Jacob Pan (3):
> >   powercap/rapl: further relax energy counter checks
> >   powercap/rapl: add new cpu ids
> >   powercap/rapl: change floor frequency for vallewview
> 
> I'm fine with [1-2/4].
> 
> [3/4] has to go via the x86 tree and [4/4] probably too, because it
> depends on [3/4].
> 
OK. I will update [4/4] to be submitted to x86 tree with [3/4].
> So would you like me to queue up [1-2/4] without the remaining two
> for 3.16?
> 
Sure. thanks.

> 

[Jacob Pan]
