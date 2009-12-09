From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 10:24:04 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912090959230.4120-100000__14280.8450189934$1260372338$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912081852320.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912081852320.3560@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Dec 2009, Linus Torvalds wrote:

> On Tue, 8 Dec 2009, Alan Stern wrote:
> > 
> > You mean, if A comes before B in the list and A must suspend after B?  
> 
> But if they are not topologically ordered, then A wouldn't necessarily be 
> before B on the list in the first place.

Okay, I see what you're getting at.  Yes, this is quite true -- if A
doesn't precede B in dpm_list then A can't safely wait for B to
suspend.  To put it another way, only list-compatible constraints are
feasible.

This shouldn't be a problem.  If it were we'd be seeing it right now, 
because A would _always_ suspend before B.

> Of course, if we've mucked with the list by hand and made sure the 
> ordering is ok, then that's a different issue. But your whole point seemed 
> to be that the device could impose its own ordering in its suspend 
> callback, which is not true on its own without external ordering.

No, sorry for not making it clearer.  I was assuming all long that the 
non-tree constraints were compatible with the list ordering.

In fact these considerations already affect the USB resume operations, 
even without asynchronous resume.  The code relies on the fact that the 
PCI layer registers sibling devices on a slot in order of increasing 
function number.  There's no guarantee this will remain true in the 
future (it may already be wrong AFAIK), so putting in some explicit 
list manipulation is the prudent thing to do.

Alan Stern
