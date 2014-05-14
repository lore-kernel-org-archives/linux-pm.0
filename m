From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / OPP: discard duplicate OPP additions
Date: Wed, 14 May 2014 17:02:56 +0200
Message-ID: <20140514150255.GA8330@amd.pavel.ucw.cz>
References: <1399966890-22926-1-git-send-email-k.chander@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399966890-22926-1-git-send-email-k.chander@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "[Chander Kashyap" <chander.kashyap@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Chander Kashyap <k.chander@samsung.com>
> 
> It may be possible to unregister and re-register the cpufreq driver.
> One such example is arm big-little IKS cpufreq driver. While
> re-registering the driver, same OPPs may get added again.

Hmm. Would it be better to actually delete stale OPPs?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
