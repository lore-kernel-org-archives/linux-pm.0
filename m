From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: generic runtime pm callbacks
Date: Mon, 6 Sep 2010 10:30:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009061025300.14908-100000__11422.5992620506$1283783549$gmane$org@netrider.rowland.org>
References: <20100906132241.GH8381@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100906132241.GH8381@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 6 Sep 2010, Mark Brown wrote:

> On Mon, Sep 06, 2010 at 03:32:09PM +0300, Ohad Ben-Cohen wrote:
> 
> > That may result in some drivers defining nop handlers, just to return
> > 0 (in case there's nothing else they need to do).
> 
> > Do we want that ?
> 
> Funnily enough I was about to report this issue too - it doesn't look
> great in the driver code.  My use case is using runtime PM in an MFD to
> communicate status to the parent devices.  The subdevices are just
> indicating that they are idle to the parent and have no reason to do
> anything in a suspend or resume callback.
> 
> > Alternatively, we may want to allow drivers to enable Runtime PM (by
> > taking the appropriate action for their subsystem, e.g. calling
> > put_noidle in probe and get_noresume in remove), but still not define
> > any runtime pm handlers (implicitly always returning a success), with
> > something like:
> 
> This would be my preferred solution.

Here's an excerpt from a message I posted recently:

-------------------------------------------------------------------
The real issue with USB interfaces is that they are only logical
sub-devices; they can't be power-managed separately from their parent.  
Indeed, the runtime_suspend and runtime_resume callbacks for interfaces
always return 0 immediately without doing anything, and the
runtime_idle callback always calls pm_runtime_suspend.

So why not tell the PM core about this behavior?  Let's put a
"no_callbacks" flag in dev_pm_info.  When this flag is set the core
won't bother invoking the runtime callbacks; it can always assume
success.  More importantly, an asynchronous request may never need to
use the workqueue:

	__pm_request_idle can directly call __pm_request_suspend.

	If the device's state is ACTIVE then __pm_request_suspend
	can switch the state directly to SUSPENDED.

	If the device's state is SUSPENDED and the parent's state
	is ACTIVE then __pm_request_resume can switch the device
	directly to ACTIVE.  (If the parent isn't ACTIVE then we
	need to proceed as we do now.)

With those shortcuts added there won't be any need to use delayed 
autosuspend for interfaces.  I don't know if any other subsystems would 
want to use the no_callbacks flag, but it's possible.
-------------------------------------------------------------------

Does that look like what you're talking about?

Alan Stern
