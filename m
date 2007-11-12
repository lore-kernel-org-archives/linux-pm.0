From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [RFC] powermac: proper sleep management
Date: Mon, 12 Nov 2007 16:52:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711121641320.5531-100000__27899.599055718$1194904501$gmane$org@netrider.rowland.org>
References: <1194900998.18185.57.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194900998.18185.57.camel@pasglop>
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
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Johannes Berg <johannes@sipsolutions.net>, David Woodhouse <dwmw2@infradead.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 13 Nov 2007, Benjamin Herrenschmidt wrote:

> I remember fixing various issues so that khubd would be safe when non
> frozen (among other things) a while ago. Did you guys break it all
> again ?

Sorry, I don't know what fixes you're referring to.  But come to 
think of it, some changes I added to the PM core a few months ago 
(locking every device prior to system sleep) would also make khubd 
and ksuspend_usbd safe, since they acquire the device lock before 
trying to resume anything.

So I take back what I said.  It's no longer true that those two USB 
kernel threads need to be frozen for system sleep.  (I should test and 
make sure that really works...)

But aren't there other kernel threads scattered around that still 
want to be frozen?  For instance, drivers/misc/tifm_core.c calls 
create_freezeable_workqueue().  And set_freezable() gets called in lots 
of places.

Alan Stern
