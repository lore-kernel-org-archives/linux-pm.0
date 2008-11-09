From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix __pfn_to_page(pfn) for
	CONFIG_DISCONTIGMEM=y
Date: Sat, 8 Nov 2008 21:54:58 -0800
Message-ID: <20081108215458.1799896b.akpm__8213.23090135611$1226210263$gmane$org@linux-foundation.org>
References: <200811081353.34442.rjw@sisk.pl>
	<20081108125952.GB21405@elf.ucw.cz>
	<200811081412.21736.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200811081412.21736.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, list <linux-pm@lists.linux-foundation.org>, pm@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 8 Nov 2008 14:12:21 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Saturday, 8 of November 2008, Pavel Machek wrote:
> > Hi!
> > 
> > > This would be good to have in .28 IMO.
> > 
> > Actually, this makes sense even for .27-stable, AFAICT.
> 
> Yes, it does, but it has to be merged first. :-)

It applies to 2.6.26 (at least).  Is there no need for it in kernels
earlier than 2.6.27.x?
