From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 12:10:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912091204550.4120-100000__21933.9670068168$1260378752$gmane$org@iolanthe.rowland.org>
References: <20091209164653.GI9018@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091209164653.GI9018@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Dec 2009, Mark Brown wrote:

> > How long does it take to bring down the entire embedded audio 
> > subsystem?  And how critical is the timing for typical systems?
> 
> Worst case is about a second for both resume and suspend which means two
> seconds total but it's very hardware dependant.  

A second seems awfully long.  What happens if audio isn't being played
when the suspend occurs?  Can't you shorten things with no artifacts in
that case?

If audio _is_ being played when a suspend occurs, users probably don't 
mind audible artifacts.  In fact, they probably expect some.

Alan Stern
