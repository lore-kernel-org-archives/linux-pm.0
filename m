From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/4][RFC v2] PM / sleep: Introduce arch-specific hook for
 disable/enable nonboot cpus
Date: Sat, 25 Jun 2016 18:51:59 +0200
Message-ID: <20160625165159.GB4362@amd>
References: <cover.1466844557.git.yu.c.chen@intel.com>
 <fb78859e5c1ea061ce4e35e200821ed170e6658d.1466844557.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45504 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbcFYQwC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jun 2016 12:52:02 -0400
Content-Disposition: inline
In-Reply-To: <fb78859e5c1ea061ce4e35e200821ed170e6658d.1466844557.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, linux-kernel@vger.kernel.org

On Sun 2016-06-26 00:18:41, Chen Yu wrote:
> There is requirement that we need to do some arch-specific
> operations before putting the nonboot CPUs offline/online.
> One of the requirements comes from the hibernation resume
> process on x86_64, we need to kick all the offlin-CPUs
> online and offline again, in order to put them in a safe
> state, thus to avoid possible unwilling wake up during
> hibernation resume.

You may want to check english here.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
