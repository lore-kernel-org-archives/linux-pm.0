From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] CPUIDLE - A Framework for Idle CPU PM
Date: Tue, 7 Aug 2007 21:02:38 +0200
Message-ID: <20070807190238.GA4273@elf.ucw.cz>
References: <1185428636.4013.75.camel@callisto.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1185428636.4013.75.camel@callisto.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adam Belay <abelay@novell.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Cpuidle is a generic framework for idle processor power management that
> Venki Pallipadi, Shaohua Li, and I developed collaboratively.  It is a
> layered architecture that separates platform-specific processor power
> drivers from higher level policy governors.  In this sense, it is
> analogous to cpufreq.  However, it manages nonoperative idle states
> rather than frequency and voltage operating points.
> 
> I've attached the most recent version of cpuidle as a stand alone patch
> against 2.6.22.  This new code is much lighter weight than the initial
> release.  It includes the core cpuidle infrastructure, an ACPI
> processor

Plus it is in -mm tree. Congratulations! :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
