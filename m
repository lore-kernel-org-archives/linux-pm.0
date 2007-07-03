From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 21:23:29 +0100
Message-ID: <20070703202329.GA27927__10392.2835937285$1183494503$gmane$org@srcf.ucam.org>
References: <20070703194247.GB27098@srcf.ucam.org>
	<Pine.LNX.4.44L0.0707031553020.7671-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0707031553020.7671-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 03, 2007 at 03:54:55PM -0400, Alan Stern wrote:
> On Tue, 3 Jul 2007, Matthew Garrett wrote:
> > There's nothing wrong with it as such, it's just that our implementation 
> > appears to suck in a myriad of small ways that keep cropping up and 
> > biting people. Even without the sys_sync(), freezing processes results 
> > in the suspend failing because syslog is stuck in D state and won't go 
> > into the refrigerator.
> 
> Okay, I can believe that.  The proper response then is to fix the 
> freezer, not eliminate it.  Has the syslog problem been reported on 
> linux-pm?  I don't recall hearing of it before.

See the start of this thread. It's just not clear what the freezer buys 
us - removing it gets rid of a load of subtle issues and complexity, and 
turns system suspend into something that looks more like runtime 
suspend (which might then encourage people to get runtime suspend 
right...)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
