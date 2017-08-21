From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] PM: docs: Delete the obsolete states.txt document
Date: Mon, 21 Aug 2017 15:03:38 +0200
Message-ID: <6985690.1N6x2ErZCO@aspire.rjw.lan>
References: <3053012.25nKXRPPaK@aspire.rjw.lan> <3193680.qV6TYsC78G@aspire.rjw.lan> <32BE8644-E9C9-44C9-A2CD-D833CFB611C6@darmarit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48949 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753110AbdHUNMK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2017 09:12:10 -0400
In-Reply-To: <32BE8644-E9C9-44C9-A2CD-D833CFB611C6@darmarit.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Heiser <markus.heiser@darmarit.de>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>

On Monday, August 21, 2017 9:39:17 AM CEST Markus Heiser wrote:
> 
> > Am 20.08.2017 um 18:06 schrieb Rafael J. Wysocki <rjw@rjwysocki.net>:
> > 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The Documentation/power/states.txt document is now redundant and
> > sonewhat outdated, so delete it.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > Documentation/power/states.txt |  127 -----------------------------------------
> > 1 file changed, 127 deletions(-)
> 
> strange, I tried to apply the series, 1/2 applied but with 2/2 I get a 
> "sha1 information is lacking or useless", did I miss something?

You need to apply this on top of linux-next, as some changes are made to
states.txt in one of the pending PM commits.

Thanks,
Rafael
