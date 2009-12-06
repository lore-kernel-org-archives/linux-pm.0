From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 16:46:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912061636170.9457-100000__48548.1501360939$1260136042$gmane$org@netrider.rowland.org>
References: <20091206131702.7d6cdc57@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091206131702.7d6cdc57@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 6 Dec 2009, Arjan van de Ven wrote:

> > Arjan, can you try testing the USB timings again with the patch below 
> > (for vanilla 2.6.32)?
> > 
> > Fair warning: I just composed this and haven't tried it out myself.
> 
> unfortunately it does not make a difference that I can notice in the
> graphs.
> 
> http://www.fenrus.org/graphs/resume2.svg

Disappointing...

> the resume problem seems to be that we resume all the hubs sequentially,
> much like we used to discover them sequentially during boot....

But the patch should have reduced the time required to resume each 
non-root hub.  So the fact that they go sequentially shouldn't matter 
as much.

For root hubs the patch won't help.  Their delays can't be reduced.

> I do not know how much I'm asking for, but would it be sensible to do a
> similar thing for hub resume as we did for boot? eg start resuming them
> all at the same time, so that the mandatory delays of these hubs will
> overlap ?

For one thing, there shouldn't be any mandatory delays for non-root
hubs during resume-from-RAM (although this depends to some extent on
your system firmware -- and it probably helps to have USB-2.0 hubs
rather than USB-1.1).

More importantly, what you're asking is impossible given the way the PM
core is structured.  The hub-resume routine can't return early because
then it wouldn't be possible to resume devices plugged into that hub.

(Ironically, your request is essentially what Rafael was trying to 
accomplish in the patches that provoked this email conversation.)

Guess I'll just have to try out your timing log addition for myself and
see what's going on...

Alan Stern
