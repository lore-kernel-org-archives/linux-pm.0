From: Valdis.Kletnieks@vt.edu
Subject: Re: [RFC PATCH 07/16] efi: Public the function of transferring EFI status to kernel error
Date: Sat, 01 Aug 2015 20:23:18 -0400
Message-ID: <37520.1438474998@turing-police.cc.vt.edu>
References: <1437056730-15247-1-git-send-email-jlee@suse.com> <1437056730-15247-8-git-send-email-jlee@suse.com>
            <1438273402.11322.17.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:53268 "EHLO
	omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754757AbbHBAXm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Aug 2015 20:23:42 -0400
In-reply-to: Your message of "Thu, 30 Jul 2015 17:23:22 +0100."
             <1438273402.11322.17.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Fleming <matt.fleming@intel.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <matthew.garrett@nebula.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Josh Boyer <jwboyer@redhat.com>, Vojtech Pavlik <vojtech@suse.cz>, Jiri Kosina <jkosina@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, "Lee, Chun-Yi" <jlee@suse.com>

On Thu, 30 Jul 2015 17:23:22 +0100, Matt Fleming said:
> On Thu, 2015-07-16 at 22:25 +0800, Lee, Chun-Yi wrote:
> > Moved the function of transferring EFI status to kernel error for
> > later used by EFI stub.
> > 
> > Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
> > ---
> >  drivers/firmware/efi/vars.c | 33 ---------------------------------
> >  include/linux/efi.h         | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+), 33 deletions(-)
>
> The patch contents are fine but the title could do with some work,
> "public" isn't a verb.

In English, any noun can be verbed. :)

