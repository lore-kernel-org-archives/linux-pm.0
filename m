From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/2] PM: Print pending wakeup IRQ preventing suspend
 to dmesg
Date: Tue, 19 Aug 2014 10:59:33 +0200
Message-ID: <20140819085933.GA7862@amd>
References: <1406910649-4028-1-git-send-email-amit.pundir@linaro.org>
 <1406910649-4028-2-git-send-email-amit.pundir@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406910649-4028-2-git-send-email-amit.pundir@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Pundir <amit.pundir@linaro.org>
Cc: linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Android Kernel Team <kernel-team@android.com>, John Stultz <john.stultz@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2014-08-01 22:00:48, Amit Pundir wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Currently when a pending wakeup irq stops suspend, it can be difficult
> to determine why suspend was prevented and which IRQ was actually
> responsible.
> 
> In order to help debug these situations, this patch prints the IRQ
> number and action name of that pending wakeup irq which prevents suspend.
> This patch comes from the Android patch set, where its been used to debug
> suspend problems.
> 

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
