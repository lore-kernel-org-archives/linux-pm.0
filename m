From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 15:54:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707031553020.7671-100000@iolanthe.rowland.org>
References: <20070703194247.GB27098@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703194247.GB27098@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 3 Jul 2007, Matthew Garrett wrote:

> > I agree that in general the suspend process should not have to wait for 
> > a userspace callback to complete.  Indeed, there's no particular 
> > reason that anything running during STR should have to wait for 
> > something in userspace to complete.  Given that fact, I don't see 
> > anything wrong with freezing userspace when doing STR.
> 
> There's nothing wrong with it as such, it's just that our implementation 
> appears to suck in a myriad of small ways that keep cropping up and 
> biting people. Even without the sys_sync(), freezing processes results 
> in the suspend failing because syslog is stuck in D state and won't go 
> into the refrigerator.

Okay, I can believe that.  The proper response then is to fix the 
freezer, not eliminate it.  Has the syslog problem been reported on 
linux-pm?  I don't recall hearing of it before.

Alan Stern
