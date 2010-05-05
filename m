From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 15:13:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005051511040.1885-100000__22005.9615596712$1273090411$gmane$org@iolanthe.rowland.org>
References: <20100505185225.GA4411@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505185225.GA4411@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 5 May 2010, Matthew Garrett wrote:

> > Clearly if there's a call in progress you don't want to shut the codec
> > down.  Are there any other circumstances?  Would they vary according to
> > whether the suspend was forced or opportunistic?
> 
> Yeah, ok. We probably do need to figure this out.
> 
> (Cc:ing Rebecca to see how this got handled on Droid)
> 
> The current state of affairs is that a system suspend request is 
> expected to put the device in as low a power state as possible given the 
> required wakeup events. Runtime power management is expected to put the 
> device in as low a power state as possible given its usage constraints. 
> If opportunistic suspend does the former then it'll tear down devices 
> that may be in use, but we don't have any real way to indicate usage 
> constraints other than the phone app taking a wakelock - and that means 
> leaving userspace running during calls, which seems excessive.
> 
> Mark's right in that the only case I can think of that's really relevant 
> right now is the audio hardware, so the inelegant solution is that this 
> is something that could be provided at the audio level. Is this 
> something we want a generic solution for? If so, what should it look 
> like?

Should the audio driver be smart enough to know that the codec needs to
remain powered up during every opportunistic suspend?

Or only during opportunistic suspends while a call is in progress?  

Does it know when a call is in progress?

Does Android use forced suspends?

If it does, are they supposed to shut down the codec?

Alan Stern
