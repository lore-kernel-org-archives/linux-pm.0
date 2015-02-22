From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 06/27] power: wakeup: Remove use of seq_printf return
 value
Date: Sun, 22 Feb 2015 13:52:58 -0800
Message-ID: <1424641978.20944.20.camel@perches.com>
References: <cover.1424573328.git.joe@perches.com>
	 <1b5eb664ab9313f1c5b9868819e1960d5dc597ac.1424573328.git.joe@perches.com>
	 <20150222213835.GA7817@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:54231 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752107AbbBVVxE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Feb 2015 16:53:04 -0500
In-Reply-To: <20150222213835.GA7817@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2015-02-22 at 22:38 +0100, Pavel Machek wrote:
> On Sat 2015-02-21 18:53:33, Joe Perches wrote:
> > The seq_printf return value, because it's frequently misused,
> > will eventually be converted to void. 
> > 
> > See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
> >      seq_has_overflowed() and make public")
> 
> You've just removed overflow handling from
> print_wakeup_source_stats.
> 
>  Can you explain why that is good idea?

If overflow occurs, the seq_file subsystem allocates
a bigger buffer and calls the show function again.

See Al's comment in the 0/n patch and here:
https://lkml.org/lkml/2015/2/17/642


