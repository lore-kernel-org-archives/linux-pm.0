From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Wakeup-events implementation
Date: Tue, 17 Aug 2010 15:19:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008171512360.1656-100000@iolanthe.rowland.org>
References: <324856.49167.qm@web180313.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <324856.49167.qm@web180313.mail.gq1.yahoo.com>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Aug 2010, David Brownell wrote:

> --- On Tue, 8/17/10, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> I wasn't
> > aware that memory cards could generate wakeup events.
> 
> Almost all MMC/SD hardware can generate reliable
> insert/remove events, in my experience.  So MMC/SD
> drivers I've modified tend to treat them as wake
> events ... userspace can respond without polling
> constantly "did it change yet, huh, did it???"

This is interesting in light of the fact that testing has shown many
USB card readers don't track insert/remove events while in low-power
mode.  When they return to full power, if a card is present they always
report a media change -- even if the card had been there all along.  
This makes autosuspend less useful than it might be.

> Unfortunately Pierre spent a lot of time hard-wiring
> UNSAFE_RESUME assumptions into the MMC core, so lots
> of that stuff is currently (and needlessly) broken.

There's a difference between generating wakeup events for insert/remove
and keeping track of media-change events.  I wouldn't want my sleeping
laptop to wake up when I insert or remove a memory card, but I would
like it to recognize when a card has been changed.  If the hardware can
do one but not the other then Pierre's choice is understandable
(although not in accord with Linus's preference).

Alan Stern
