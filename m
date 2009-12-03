From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: System sleep vs. runtime PM
Date: Thu, 3 Dec 2009 10:25:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912031020140.4795-100000@iolanthe.rowland.org>
References: <200912030002.46692.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912030002.46692.oliver@neukum.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Dec 2009, Oliver Neukum wrote:

> An evil thought, do we have devices that will always request remote wakeup,
> without an option to switch it off? What about OTG?

I don't know of any such devices.  USB OTG will depend on the 
controller design, but I would be surprised to find a controller that 
didn't let you turn off wakeup-IRQ generation.

> > There's yet another issue to discuss.  Suppose a device is
> > runtime-suspended when a system sleep starts.  When the system wakes
> > up, should the device be runtime-resumed?  (Assume that the wakeup
> > settings don't differ; otherwise it has to be.)
> 
> That depends on how sure we are to never drop a remote wakeup,
> not even if requests race or for any other reason. And we must always
> know what woke us up.

This is a complicated question and I will discuss it at greater length 
in another email.

However, I don't see any reason to know what woke us up.  All we really 
need to know is what devices have wakeup requests outstanding when the 
system resume is finished.  It doesn't matter which request came first 
(presumably that was the one which woke us up).

Alan Stern
