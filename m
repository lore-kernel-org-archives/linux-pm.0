From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] kernel: power: snapshot: Remove unused function
Date: Fri, 30 Jan 2015 01:19:15 +0100
Message-ID: <5562800.mUrS4CZKkC@vostro.rjw.lan>
References: <1421015258-24472-1-git-send-email-rickard_strandqvist@spectrumdigital.se> <20150112080910.GB27501@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61065 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751856AbbA2X41 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 18:56:27 -0500
In-Reply-To: <20150112080910.GB27501@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, January 12, 2015 09:09:10 AM Pavel Machek wrote:
> On Sun 2015-01-11 23:27:38, Rickard Strandqvist wrote:
> > Remove the function get_safe_write_buffer() that is not used anywhere.
> > 
> > This was partially found by using a static code analysis program called cppcheck.
> > 
> > Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> Rafael should take this, I guess...

Queued up for 3.20, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
