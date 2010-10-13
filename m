From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 13/23] Hibernation: Partial page I/O support.
Date: Wed, 13 Oct 2010 22:28:22 +0200
Message-ID: <201010132228.22604.rjw__35797.2751175568$1287001801$gmane$org@sisk.pl>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<1285566238-10966-14-git-send-email-nigel@tuxonice.net>
	<20101013071008.GA1610@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101013071008.GA1610@ucw.cz>
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
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 13, 2010, Pavel Machek wrote:
> Hi!
> 
> > Add functions that can be used for coalescing and splitting buffers
> > that are smaller than PAGE_SIZE. These functions provide no method
> > of determining where the boundaries of the smaller buffers are to
> > be found - that is the caller's problem.
> 
> I don't get it; why do we need that support?

This is related to compression.  This way we can put data from two or more
compressed pages into one page frame.

Thanks,
Rafael
