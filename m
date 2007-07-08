From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sun, 08 Jul 2007 14:39:36 +1000
Message-ID: <1183869576.3388.250.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707072218030.10912-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707072218030.10912-100000@netrider.rowland.org>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> In my defense, you should realize that until Rafael's notifier chain
> was added (just a few weeks ago, still not in mainline I believe) there
> was no other way to do it.  Plug activity needs to be stopped before
> the child devices are suspended, and the PM core does not send any
> notification to drivers at that time.  All it does is activate the 
> freezer.

That's true. That was one of the reason I've always wanted the
pre-suspend and post-resume hooks. (I prefer keeping the ordering there
too, rather than a notifier, but a notifier is fine I suppose).

Among the clients we want here the firmware stuff, the allocators,
etc... to get themselves in conditions that won't deadlock during
suspend cycle.

I think that's a much bigger issue overall than freezer vs. no
freezer :-)

Ben.
