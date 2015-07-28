From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 03/16] x86/boot: Public getting random boot function
Date: Tue, 28 Jul 2015 14:21:33 +0200
Message-ID: <20150728122133.GA12681@amd>
References: <1437056730-15247-1-git-send-email-jlee@suse.com>
 <1437056730-15247-4-git-send-email-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43212 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbG1MVg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 08:21:36 -0400
Content-Disposition: inline
In-Reply-To: <1437056730-15247-4-git-send-email-jlee@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <matthew.garrett@nebula.com>, Len Brown <len.brown@intel.com>, Josh Boyer <jwboyer@redhat.com>, Vojtech Pavlik <vojtech@suse.cz>, Matt Fleming <matt.fleming@intel.com>, Jiri Kosina <jkosina@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, "Lee, Chun-Yi" <jlee@suse.com>

Hi!

>  int cmdline_find_option_bool(const char *option);
>  #endif
>  
> +#if CONFIG_RANDOMIZE_BASE

Not ifdef?

> +extern u16 i8254(void);

That's rather poor name for global function...

>  #if CONFIG_RANDOMIZE_BASE

Ok, maybe not, but I'm confused.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
