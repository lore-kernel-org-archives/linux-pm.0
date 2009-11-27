From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suggestion on resumption
Date: Fri, 27 Nov 2009 12:43:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911271237220.30903-100000@netrider.rowland.org>
References: <200911270918.20029.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911270918.20029.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 27 Nov 2009, Oliver Neukum wrote:

> Am Freitag, 27. November 2009 01:47:44 schrieb Rafael J. Wysocki:
> > On Thursday 26 November 2009, Oliver Neukum wrote:
> > > Hi,
> > >
> > > using the USB autosuspend framework I've often faced characteristic
> > > problems coding resume() methods. This has led me to an idea. Resume()
> > > would be much easier to code if I knew about the reason of resumption,
> > > especially about the code path resume() is called in. I wonder whether
> > > we could introduce a message argument to resume and give it a few
> > > bits from the caller.
> > 
> > Each of the callbacks in struct dev_pm_ops is executed in exactly one
> >  context, so for each of them it is known why it was called.
> 
> But the resume method in the driver doesn't learn. It is an extrem hassle
> not to know whether you are called synchronously (ie from open which
> already holds a lock) or asynchronously (which means you need to guard
> against open)

With the new Runtime PM framework, there isn't always a one-to-one 
correspondence between resume requests and method callbacks.  So the 
"reason" for a callback isn't always well defined.  And even if it 
were, the callback might happen in a different thread from the request.

The way to guard against open from an asynchronous context is to 
approach the problem the other way around: Guard against async contexts 
while open is running.  In other words, have open do an autoresume.

Exactly what situation are you concerned about?

Alan Stern
