From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Mon, 09 Jul 2007 07:21:48 +1000
Message-ID: <1183929708.3388.306.camel__5167.86449957198$1183929986$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707081619090.11049-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707081619090.11049-100000@netrider.rowland.org>
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

On Sun, 2007-07-08 at 16:22 -0400, Alan Stern wrote:
> On Sun, 8 Jul 2007, Rafael J. Wysocki wrote:
> 
> > I'm all for changing this infrastructure, but in an organized way (ie. we
> > discuss what to do next, we do that and then we go to the next step) and in
> > the order that everyone will be comfortable with.
> > 
> > So, let's finish this thread and start over from discussing what needs to be
> > done, how (ie. in what order etc.) we are going to do that and who is going to
> > do what.  Shall we?
> 
> IMO we should start by using the new notifier chain and by implementing 
> a central "icebox" routine.  Then we can forbid device registration 
> during suspend.
> 
> It might also be a good idea to add a freezable keventd-like workqueue 
> specifically intended for things that need to block during a suspend.  
> Although maybe this will end up being unnecessary; it's too soon to 
> tell.

I think looking at the kmallo/gfp issue I mentioned earlier should be
done asap. I can try to spare some time for it this week but I can't
promise, I'm actually swamped by something totally unrelated at the
moment.

Another issue that's been a problem forever with suspend is the
synchronous request_firmware interface. Lots of drivers do that in
resume() which will generally not work.

Ben.
