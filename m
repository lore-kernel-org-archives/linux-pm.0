From: Oliver Neukum <oliver@neukum.org>
Subject: Re: suggestion on resumption
Date: Fri, 27 Nov 2009 23:37:17 +0100
Message-ID: <200911272337.17519.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0911271237220.30903-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0911271237220.30903-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, 27. November 2009 18:43:12 schrieb Alan Stern:
> > But the resume method in the driver doesn't learn. It is an extrem hassle
> > not to know whether you are called synchronously (ie from open which
> > already holds a lock) or asynchronously (which means you need to guard
> > against open)
> 
> With the new Runtime PM framework, there isn't always a one-to-one 
> correspondence between resume requests and method callbacks.  So the 
> "reason" for a callback isn't always well defined.  And even if it 
> were, the callback might happen in a different thread from the request.

That is exactly what I need to know.

> The way to guard against open from an asynchronous context is to 
> approach the problem the other way around: Guard against async contexts 
> while open is running.  In other words, have open do an autoresume.

That is the problem locking requirements are different when I do that
and I don't know what's the case.

	Regards
		Oliver
