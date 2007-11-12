From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [RFC] powermac: proper sleep management
Date: Mon, 12 Nov 2007 14:52:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711121451210.1567-100000@netrider.rowland.org>
References: <1194885177.5229.45.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194885177.5229.45.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Scott Wood <scottwood@freescale.com>, linux-pm <linux-pm@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 12 Nov 2007, Johannes Berg wrote:

> > Looks good to me, +/- a couple of things:
> > 
> >  - We _REALLY_ want the freezer to be optional and not enabled by
> > default on PowerPC. Maybe make it a compile option ?
> 
> Well, Alan is going to tell you that USB will break. If we need
> confirmation for that I can do the test he suggested to you or Paul a
> while ago.

Isn't it true that the freezer _already_ isn't enabled on PPC?  So 
leaving it off wouldn't break anything more than it is broken now.

Alan Stern
