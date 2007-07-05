From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Wakeup settings for USB hubs?
Date: Thu, 5 Jul 2007 09:20:43 +0200
Message-ID: <200707050920.43618.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0707041432250.9446-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707041432250.9446-100000@netrider.rowland.org>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 4. Juli 2007 schrieb Alan Stern:
> Here's a question that has been bothering me for a while.  Should we 
> enable remote wakeup on USB hubs?
> 
> On the face of it the answer is obviously Yes.  And certainly we want
> remote wakeup enabled during a runtime suspend; otherwise the system
> would never know when the user unplugged a device from the hub or
> plugged in a new one.

I agree. Runtime suspend needs remote wakeup.

> But consider STR, say in the case of a laptop with a USB mouse
> attached.  The user suspends the laptop.  Then he prepares to pack it
> away and in the process unplugs the mouse.  Pow! -- the laptop
> springs back to life.  That's not what we want.

We might want attaching a device to wake the laptop. OR we might
not. The choice is not makeable in kernel space.

> On the other hand, the user might indeed want to awaken the laptop by
> clicking the USB mouse.  So what should we do?  The question is made
> even more difficult by the fact that, if the hub is already
> runtime-suspended when the system suspend occurs, we would have to
> resume the hub just in order to turn off remote wakeup!

I don't think this can be helped. We cannot leave the setting of remote
wakeup in the STR case to chance. We'd do so if we let stand the setting
caused by autosuspend.
If that means waking up a hub about to be suspended again, so be it.

> Right now we more or less ignore all these issues by relying on the 
> wakeup settings in sysfs.  Is that a reasonable approach?  Is there 
> anything else we can do?

I don't think so. It is the most reasonable approach.

	Regards
		Oliver
