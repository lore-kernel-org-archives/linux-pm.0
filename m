From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] x86: PM: Make APM idle driver initialize polling state
Date: Wed, 7 Feb 2018 16:00:28 +0200
Message-ID: <20180207140028.GV5453@intel.com>
References: <20180122162747.19103-1-ville.syrjala@linux.intel.com>
 <1862424.1bTBpgPzTf@aspire.rjw.lan>
 <20180206182617.GQ5453@intel.com>
 <1595367.GFL0qxR379@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:3575 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753834AbeBGOAc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Feb 2018 09:00:32 -0500
Content-Disposition: inline
In-Reply-To: <1595367.GFL0qxR379@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, x86 <x86@kernel.org>, Jiri Koshina <jikos@kernel.org>

On Wed, Feb 07, 2018 at 10:20:58AM +0100, Rafael J. Wysocki wrote:
> On Tuesday, February 6, 2018 7:26:17 PM CET Ville Syrjälä wrote:
> > On Tue, Feb 06, 2018 at 07:02:58PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Update the APM driver overlooked by commit 1b39e3f813b4 (cpuidle: Make
> > > drivers initialize polling state) to initialize the polling state like
> > > the other cpuidle drivers modified by that commit to prevent cpuidle
> > > from crashing.
> > > 
> > > Fixes: 1b39e3f813b4 (cpuidle: Make drivers initialize polling state)
> > > Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > And maybe?
> > 
> > Cc: <stable@vger.kernel.org> # v4.14+
> 
> I add these when applying patches.
> 
> Actually, I've queued up the patch with this tag already.

Cool. Thanks.

-- 
Ville Syrjälä
Intel OTC
