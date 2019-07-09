Return-Path: <SRS0=yg//=VG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29855C73C46
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jul 2019 16:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F9F21670
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jul 2019 16:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGIQ1m (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:27:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:20664 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfGIQ1m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jul 2019 12:27:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 09:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="317075549"
Received: from spandruv-mobl3.jf.intel.com ([10.252.137.76])
  by orsmga004.jf.intel.com with ESMTP; 09 Jul 2019 09:27:41 -0700
Message-ID: <b0639de126d88fe9ee758b4ffac62b2e11874434.camel@linux.intel.com>
Subject: Re: [PATCH v2] tools/power/x86/intel-speed-select: Add .gitignore
 file
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Arcari <darcari@redhat.com>,
        platform-driver-x86@vger.kernel.org
Date:   Tue, 09 Jul 2019 09:27:41 -0700
In-Reply-To: <699e770258725ae8e7c9597e0e4a4cb17e08de5e.camel@linux.intel.com>
References: <20190708231725.11353-1-prarit@redhat.com>
         <CAJZ5v0j4fsqK=AwqtytDM-T-HwcsCzmyGamQ3ZOMNZngh=2oeQ@mail.gmail.com>
         <699e770258725ae8e7c9597e0e4a4cb17e08de5e.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+platform-driver-x86@vger.kernel.org

On Tue, 2019-07-09 at 09:18 -0700, Srinivas Pandruvada wrote:
> On Tue, 2019-07-09 at 10:17 +0200, Rafael J. Wysocki wrote:
> > On Tue, Jul 9, 2019 at 1:17 AM Prarit Bhargava <prarit@redhat.com>
> > wrote:
> > > 
> > > Add a .gitignore file for build include/ and final binary.
> > > 
> > > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Cc: David Arcari <darcari@redhat.com>
> > 
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> > 
> > > ---
> > >  tools/power/x86/intel-speed-select/.gitignore | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >  create mode 100644 tools/power/x86/intel-speed-select/.gitignore
> > > 
> > > diff --git a/tools/power/x86/intel-speed-select/.gitignore
> > > b/tools/power/x86/intel-speed-select/.gitignore
> > > new file mode 100644
> > > index 000000000000..f61145925ce9
> > > --- /dev/null
> > > +++ b/tools/power/x86/intel-speed-select/.gitignore
> > > @@ -0,0 +1,2 @@
> > > +include/
> > > +intel-speed-select
> > > --
> > > 2.21.0
> > > 
> 
> 

