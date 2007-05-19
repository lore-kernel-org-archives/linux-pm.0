From: Mattia Dongili <malattia@linux.it>
Subject: Re: 2.6.22-rc1 regression: tifm prevents suspending
	[was: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR]
Date: Sun, 20 May 2007 01:43:29 +0900
Message-ID: <20070519164329.GA3224__41741.768064867$1179593153$gmane$org@inferi.kami.home>
References: <20070518071523.GA3195@inferi.kami.home>
	<20070518002240.bc08e811.akpm@linux-foundation.org>
	<20070519064829.GA15518@inferi.kami.home>
	<20070519000413.75badb6f.akpm@linux-foundation.org>
	<20070519151110.GA3393@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070519151110.GA3393@inferi.kami.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Alex Dubov <oakad@yahoo.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre Ossman <drzeus@drzeus.cx>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, May 20, 2007 at 12:11:10AM +0900, Mattia Dongili wrote:
...
> I'm now seeing if avoiding the tifm stuff in -mm1 fixes the
> immediately-resumes-after-str problem (unfortunately the commint doesn't
> revert cleanly).

as (almost) expected it is not related... tomorrow is another bisecting
day...

-- 
mattia
:wq!
