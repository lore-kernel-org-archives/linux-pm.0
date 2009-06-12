From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 19/19] PM: Add empty suspend/resume device
	irq functions
Date: Fri, 12 Jun 2009 13:32:18 +0200
Message-ID: <20090612113218.GB6355__27133.2047450871$1244829490$gmane$org@osiris.boeblingen.de.ibm.com>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
	<S4AoGnG.A.AI.ZjYMKB@chimera> <20090612111317.GP18682@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090612111317.GP18682@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Magnus Damm <damm@igel.co.jp>, Linux PM List <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 12, 2009 at 01:13:17PM +0200, Pavel Machek wrote:
> On Thu 2009-06-11 22:42:09, Rafael J. Wysocki wrote:
> > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > 
> > git commit 0a0c5168 "PM: Introduce functions for suspending and resuming
> > device interrupts" introduced some helper functions. However these
> > functions are only available for architectures which support
> > GENERIC_HARDIRQS.
> 
> I believe architectures that do not use GENERIC_HARDIRQs should just
> provide the empty functions themselves.
> 
> If we want to help them, perhaps few attribute((weak)) functions in
> the core are the way to go...

We can still do that when there actually is an architecture that doesn't
support GENERIC_HARDIRQs _and_ needs non-empty functions.
