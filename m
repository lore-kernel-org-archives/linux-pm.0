From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 6)
Date: Tue, 1 Apr 2008 23:50:00 +0200
Message-ID: <200804012350.01407.rjw__25545.9850923673$1207086806$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0804011653140.9362-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0804011653140.9362-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 1 of April 2008, Alan Stern wrote:
> On Tue, 1 Apr 2008, Rafael J. Wysocki wrote:
> 
> > > Does ..._ext_... mean extended? (external?) If 'extended' (or if not),
> > > does that imply that they're mutually exclusive alternatives for drivers
> > > to use?
> > 
> > 'ext' means 'extended'.  The idea is that the 'extended' version will be used
> > by bus types / driver types that don't need to implement the _noirq callbacks.
> 
> Something's wrong here.  This seems to say that the "extended" version
> has _fewer_ method pointers -- in which case it should be called 
> "restricted" instead.

No, it has more pointers.  Specifically, it is like

struct pm_ext_ops {
	struct pm_ops base;
	--additional pointers go here--
}
 
> > > So drivers can never validly fail to resume. That sounds fair enough. If
> > > the hardware has gone away while in lower power mode (USB, say), should
> > > the driver then just printk an error and return success?
> > 
> > I think so.
> > 
> > IMO, an error code returned by a driver's ->resume() should mean "the device
> > hasn't resumed and is presumably dead".  Otherwise, ->resume() should return
> > success.
> 
> If the device is gone, it doesn't much matter what resume() returns.

Yes, it does.  In that cases, the error code would tell the PM core not to attempt
to resume the device's children etc.  Otherwise, it's quite meaningless to the
PM core, because it really can mean anything and how's the PM core supposed
to handle _that_?

Either we decide that the error codes returned by ->resume() mean critical
errors or there's no point in returning error codes from ->resume() at all
(other than logging the errors by the core).

Well, that's getting confused.  I think I'll have to rework the patch not to
really handle the errors returned by ->resume() and friends, after all, but
I'll keep the reporting of them.

However, I'd like to add a recommendation that the _new_ "resume" callbacks
should only return errors in critical situations as the indication to the PM
core that something went _really_ wrong and the device in question is quite
surely unusable.

Thanks,
Rafael
