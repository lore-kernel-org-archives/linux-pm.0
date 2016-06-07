From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/5] Add suspend-to-idle validation for Intel SoCs
Date: Tue, 7 Jun 2016 09:46:33 +0200
Message-ID: <20160607074632.GA13858@amd>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dbasehore@chromium.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

On Wed 2016-06-01 21:33:24, dbasehore@chromium.org wrote:
> From: Derek Basehore <dbasehore@chromium.org>
> 
> This patch set adds support for catching errors when entering freeze
> on Intel Skylake SoCs. Support for this can be added to newer SoCs in
> later patches.
> 
> Verification is done by waking up the CPU once every X (default 10)
> seconds to check the residency of S0ix. This can't be verified before
> attempting to enter S0ix through mwait, so we have to repeatedly
> verify entry into that state. Successfully entering S0ix is no
> guarantee that it will be entered on the next attempt, so we have to
> schedule another check. This has a minimal power impact of <1% of the
> total system power on our systems.

Dunno. Should this be protected with something like CONFIG_TEST_SLEEP?
People probably don't want this for production...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
