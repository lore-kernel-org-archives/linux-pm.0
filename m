From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/4] AnalyzeSuspend v4.5
Date: Mon, 13 Feb 2017 12:52:14 +0100
Message-ID: <2204506.DJS1CnVxSj@aspire.rjw.lan>
References: <cover.1486675333.git.todd.e.brandt@linux.intel.com> <CAJZ5v0hPYRWwjwR=pRcLL1oazvxv40iF6GztGY9kApUBkxGJJQ@mail.gmail.com> <1486771563.13784.1.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52947 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751964AbdBML5J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2017 06:57:09 -0500
In-Reply-To: <1486771563.13784.1.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: todd.e.brandt@linux.intel.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, todd.e.brandt@intel.com, Rafael Wysocki <rafael.j.wysocki@intel.com>

On Friday, February 10, 2017 04:06:03 PM Todd Brandt wrote:
> On Thu, 2017-02-09 at 22:42 +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 9, 2017 at 10:27 PM, Todd Brandt
> > <todd.e.brandt@linux.intel.com> wrote:
> > > This patch series updates the tool from v4.2 to v4.5. The patches
> > > can be combined into a single commit for brevity.
> > >
> > > Todd Brandt (4):
> > >   AnalyzeSuspend v4.3
> > >   AnalyzeSuspend v4.4
> > >   AnalyzeSuspend v4.5
> > >   AnalyzeSuspend v4.5: fix drag and zoom bug in javascript
> > >
> > > v2 changes:
> > >  - added v4.5 fixes since initial upstream attempt
> > > v3 changes:
> > >  - resubmit with fixes to v2 submit errors
> > >
> > >  scripts/analyze_suspend.py | 1933 ++++++++++++++++++++++++++------------------
> > >  1 file changed, 1135 insertions(+), 798 deletions(-)
> > >
> > > --
> > 
> > I applied the previous iteration.
> > 
> > Have patches [1-3/4] changed since then?
> 
> Ahh ok, then ignore this then. Nothing changed in patches 1-3/4, there's
> just the small addition in 4/4. Thanks.

OK, so I applied the [4/4] on top of what I had previously.

Thanks,
Rafael

