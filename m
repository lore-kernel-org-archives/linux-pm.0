From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 20:42:47 +0100
Message-ID: <20070703194247.GB27098@srcf.ucam.org>
References: <20070703170233.GA25129@srcf.ucam.org>
	<Pine.LNX.4.44L0.0707031529130.7671-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0707031529130.7671-100000@iolanthe.rowland.org>
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

On Tue, Jul 03, 2007 at 03:33:40PM -0400, Alan Stern wrote:
> On Tue, 3 Jul 2007, Matthew Garrett wrote:
> 
> > On Tue, Jul 03, 2007 at 12:57:17PM -0400, Alan Stern wrote:
> > > On Tue, 3 Jul 2007, Matthew Garrett wrote:
> > > > For the suspend to RAM case, that sounds absolutely fine.
> > > 
> > > It's not so good when your suspend process has to wait for the call to 
> > > complete!
> > 
> > Why would it have to? Sorry, I suspect I'm missing something obvious 
> > here.
> 
> Well, the sys_sync() that caused your original problem did exactly 
> that.  It's the reason you get deadlocks, right?

The sys_sync is unnecessary in the first case. There shouldn't be 
anything in the suspend path that's going to require userspace access to 
a device after that device has been suspended.

> I agree that in general the suspend process should not have to wait for 
> a userspace callback to complete.  Indeed, there's no particular 
> reason that anything running during STR should have to wait for 
> something in userspace to complete.  Given that fact, I don't see 
> anything wrong with freezing userspace when doing STR.

There's nothing wrong with it as such, it's just that our implementation 
appears to suck in a myriad of small ways that keep cropping up and 
biting people. Even without the sys_sync(), freezing processes results 
in the suspend failing because syslog is stuck in D state and won't go 
into the refrigerator.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
