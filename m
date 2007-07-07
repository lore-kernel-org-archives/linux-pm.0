From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sat, 7 Jul 2007 12:17:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707071215140.19734-100000@netrider.rowland.org>
References: <1183779845.3388.206.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183779845.3388.206.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 7 Jul 2007, Benjamin Herrenschmidt wrote:

> > > And guess what ? It's what we do on powerbooks, and it works fine,
> > > without a freezer :-)

> If you remember, one of the things I've been advocating has always been
> that we should put on hold all plug activity (unplug might be alright as
> long as the user events are just delayed) when we start suspending. No
> new devices, no new bindings. "hub" type devices are respondible for
> bringing in the new stuff after resume.

Which is exactly my point.  It _doesn't_ work fine without a freezer, 
because the USB stack currently relies on the freezer to prevent plug 
activity.

Alan Stern
