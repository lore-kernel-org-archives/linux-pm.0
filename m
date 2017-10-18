From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/3] tools/thermal: tmon: Makefile improvements
Date: Wed, 18 Oct 2017 10:19:03 +0800
Message-ID: <1508293143.2746.46.camel@intel.com>
References: <20170927230237.62199-1-code@mmayer.net>
         <CAGt4E5tmKCLD_bcHe6_vTxqG=UApdfZZNTQOFh_d2VY2gKW7TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:52341 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756362AbdJRCTH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Oct 2017 22:19:07 -0400
In-Reply-To: <CAGt4E5tmKCLD_bcHe6_vTxqG=UApdfZZNTQOFh_d2VY2gKW7TQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <markus.mayer@broadcom.com>
Cc: Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 2017-10-13 at 13:39 -0700, Markus Mayer wrote:
> On 27 September 2017 at 16:02, Markus Mayer <code@mmayer.net> wrote:
> > 
> > From: Markus Mayer <mmayer@broadcom.com>
> > 
> > This series introduces a number of improvements to tmon's Makefile.
> > The
> > changes are meant to make it easier to cross-compile tmon on a
> > greater
> > number of platforms by giving more control to the person performing
> > the
> > build.
> > 
> > At the same time, sensible defaults are retained so that building
> > tmon
> > will continue to work without any customizations on platforms on
> > which
> > it currently builds.
> Rui, is there any chance you would be able to take this?
> 
yes, patches applied.

thanks,
rui
> Thanks,
> -Markus
> 
> > 
> > Markus Mayer (3):
> >   tools/thermal: tmon: use "-fstack-protector" only if supported
> >   tools/thermal: tmon: allow $(CC) to be defined externally
> >   tools/thermal: tmon: use $(PKG_CONFIG) instead of hard-coding
> >     pkg-config
> > 
> >  tools/thermal/tmon/Makefile | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > --
> > 2.7.4
> > 
