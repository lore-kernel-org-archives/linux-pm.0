From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 19:52:25 +0100
Message-ID: <20100505185225.GA4411__35772.6681897931$1273085701$gmane$org@srcf.ucam.org>
References: <20100505173337.GA1671@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051432120.1885-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005051432120.1885-100000@iolanthe.rowland.org>
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 02:36:10PM -0400, Alan Stern wrote:

> This particular question could use a little more discussion.  I'm
> interested to know, for example, under what conditions you would or
> would not want to shut down an autonomous codec while going into system 
> suspend on a cell phone.
> 
> Clearly if there's a call in progress you don't want to shut the codec
> down.  Are there any other circumstances?  Would they vary according to
> whether the suspend was forced or opportunistic?

Yeah, ok. We probably do need to figure this out.

(Cc:ing Rebecca to see how this got handled on Droid)

The current state of affairs is that a system suspend request is 
expected to put the device in as low a power state as possible given the 
required wakeup events. Runtime power management is expected to put the 
device in as low a power state as possible given its usage constraints. 
If opportunistic suspend does the former then it'll tear down devices 
that may be in use, but we don't have any real way to indicate usage 
constraints other than the phone app taking a wakelock - and that means 
leaving userspace running during calls, which seems excessive.

Mark's right in that the only case I can think of that's really relevant 
right now is the audio hardware, so the inelegant solution is that this 
is something that could be provided at the audio level. Is this 
something we want a generic solution for? If so, what should it look 
like?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
