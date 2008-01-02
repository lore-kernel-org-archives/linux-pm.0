From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while
	suspended (rev. 2)
Date: Wed, 2 Jan 2008 21:14:51 +0100
Message-ID: <20080102201451.GC3985__1392.6541236744$1199305100$gmane$org@elte.hu>
References: <200801020032.45529.rjw@sisk.pl> <20080102105217.GA14731@elte.hu>
	<200801021356.59865.rjw@sisk.pl> <20080102131529.GA32160@elte.hu>
	<3ae72650801020655h6ec31ce8n5cd9014c00c9f6ad@mail.gmail.com>
	<20080102160137.GA21046@elte.hu>
	<20080102175400.3C2E0EF588@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080102175400.3C2E0EF588@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: a.zummo@towertech.it, gregkh@suse.de, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org


* David Brownell <david-b@pacbell.net> wrote:

> I've been trying to make sure the x86 world could realistically switch 
> to the RTC framework used by other Linux platforms, hence e.g. the 
> util-unix-ng updates, but never assumed there would be no userspace 
> changes.  After all, userspace was using a mishmash of tools that were 
> far from platform-agnostic, and moving away from x86-dependency 
> implies such things will change.
> 
> However I *do* think that symlinking rtc to /dev/rtc0 should make it 
> practical to use most older binaries.

then please provide a kernel config option for the new driver to take 
over 10:135 too. There's nothing worse to the adoption of new kernel 
features necessiating user-space attention. I've got several images of 
old distros that i dont want to reconfigure in any way, and it would be 
nice to have a drop-in /dev/rtc replacement for them. Really. This is 
how we do it for just about everything else too.

	Ingo
