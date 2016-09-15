From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 0/8] =?iso-8859-1?Q?Support_?=
 =?iso-8859-1?Q?Intel=AE?= Turbo Boost Max Technology 3.0
Date: Thu, 15 Sep 2016 14:14:30 +0200
Message-ID: <20160915121430.GD13132@amd>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com
List-Id: linux-pm@vger.kernel.org

Hi!

> - Feature is enabled by default for single socket systems
> 
> With Intel® Turbo Boost Max Technology 3.0 (ITMT), single-threaded performance is
> optimized by identifying processor's fastest core and running critical workloads
> on it.
> Refere to:
> http://www.intel.com/content/www/us/en/architecture-and-technology/turbo-boost/turbo-boost-max-technology.html

That does not really explain much.

How does it work? Do the different cores have different max
frequencies due to manufacturing differences? Ot is it running the
workload on coldest core?

Thanks,
								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
