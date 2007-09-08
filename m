From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [4/4] 2.6.23-rc5: known regressions v2
Date: Sat, 8 Sep 2007 16:33:28 +0000
Message-ID: <20070908163328.GB4457__36805.6846702986$1189269375$gmane$org@ucw.cz>
References: <46E27DEF.7060109@googlemail.com> <46E2835E.9010408@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46E2835E.9010408@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Arkadiusz Miskiewicz <arekm@maven.pl>, Thomas Voegtle <tv@lio96.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Subject         : resume from ram much slower
> References      : http://lkml.org/lkml/2007/8/10/275
> Last known good : 2.6.23-rc1 ?
> Submitter       : Arkadiusz Miskiewicz <arekm@maven.pl>
> Caused-By       : ?
> Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
> Status          : problem is being debugged

Can you try unloading acpi_cpufreq? I seen similar bug in suse
kernel...

If that does not help, try unloading as many modules as possible...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
