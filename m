From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [RFD] How to tell ACPI drivers what the target
	sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 11:56:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706211148210.3547-100000@iolanthe.rowland.org>
References: <200706210004.03544.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706210004.03544.david-b@pacbell.net>
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
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 21 Jun 2007, David Brownell wrote:

> If drivers actually need a handle on that state, that'd be a fair
> approach; make it an opaque type though, platform-specific.
> 
> But actually I don't see much point to having such a struct.  What
> matters is the attributes of the target state (what resources will
> be present, especially), and that rarely needs to be indicated by
> any kind of cookie.

Your meaning isn't clear.  You just said there isn't much point in 
having a struct, and now you say that there rarely needs to be a 
cookie.  Did you mean to say that a cookie can do a better job of 
encapsulating the information than a struct can?

System suspend is different from runtime suspend in that the 
requirements are passed from the top down: "The whole system is going 
to enter this state, so prepare yourself".  Not "All your children are 
in low-power states, so feel free to reduce your own power level".  A 
driver can't rely on purely local information to know what will happen.

If a driver wants to find out whether some resource will be available
in the target system state, the only way is to ask the resource's
provider.  Hence the driver needs to have some cookie (representing the
target state) that it can pass to the provider.

Alan Stern
