From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] kernel: power: snapshot: Remove unused function
Date: Mon, 12 Jan 2015 09:09:10 +0100
Message-ID: <20150112080910.GB27501@amd>
References: <1421015258-24472-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52724 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbbALIJN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 03:09:13 -0500
Content-Disposition: inline
In-Reply-To: <1421015258-24472-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun 2015-01-11 23:27:38, Rickard Strandqvist wrote:
> Remove the function get_safe_write_buffer() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Acked-by: Pavel Machek <pavel@ucw.cz>

Rafael should take this, I guess...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
