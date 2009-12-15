From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Tue, 15 Dec 2009 10:55:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912151047410.3566-100000__8759.90281715549$1260892630$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912150722310.14385@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912150722310.14385@localhost.localdomain>
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

On Tue, 15 Dec 2009, Linus Torvalds wrote:

> My whole point was that by doing the whole "wait for children" in generic 
> code, you also made devices - such as PCI bridges - have to wait for 
> children, even though they don't need to, and don't want to.
> 
> So I suggested an admittedly ugly hack to take care of it - rather than 
> some complex infrastructure.

It doesn't feel like an ugly hack to me.  It seems like exactly the 
Right Thing To Do: Make as many devices as possible use async 
suspend/resume.

The only reason we don't make every device async is because we don't
know whether it's safe.  In the case of PCI bridges we _do_ know --
because they don't have any work to do outside of
late_suspend/early_resume -- and so they _should_ be async.

The same goes for devices that don't have suspend or resume methods.

There remains a separate question: Should async devices also be forced
to wait for their children?  I don't see why not.  For PCI bridges it
won't make any significant difference.  As long as the async code
doesn't have to do anything, who cares when it runs?

Alan Stern
