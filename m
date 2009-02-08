From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Mon, 9 Feb 2009 00:44:48 +0100
Message-ID: <200902090044.49034.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0902081628340.22400-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902081628340.22400-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 08 February 2009, Alan Stern wrote:
> On Sun, 8 Feb 2009, Pavel Machek wrote:
> 
> > Well, it is true that wakelocks could be single atomic_t ... but they
> > would make them undebuggable. Ok, wakelock interface sucks. But I
> > believe something like that is neccessary.
> 
> krefs don't have name strings for keeping track of who has been 
> incrementing or decrementing their counters.  And it's true that krefs 
> are nearly undebuggable.  But somehow we've managed to struggle along 
> without adding names to krefs.  Why should wakelocks be any different?

Yeah, I don't really see why.

Thanks,
Rafael
