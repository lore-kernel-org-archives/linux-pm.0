From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM: Calling Device runtime PM callbacks?
Date: Sun, 13 Dec 2009 19:36:45 +0100
Message-ID: <200912131936.46046.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912131155120.1111-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912131155120.1111-100000@netrider.rowland.org>
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 13 December 2009, Alan Stern wrote:
> On Sun, 13 Dec 2009, Rafael J. Wysocki wrote:
> 
> > On Sunday 13 December 2009, Mahalingam, Nithish wrote:
> > > Hi Rafael,
> > > 
> > > I was wondering why PM Runtime Core cannot call the device PM callbacks when 
> > > its device's bus does not support runtime PM (if such a scenario is valid)?
> > 
> > The assumption was it wouldn't be necessary, but the approach can be extended
> > to device types and device classes.
> > 
> > > Regards,	
> > > Nithish Mahalingam
> > > P.S. Alan, Not sure if you are askin the a similar question in the 
> > > "System sleep vs. runtime PM" mail thread.
> > 
> > I guess so.
> 
> Yes.  I mistakenly used the wrong words, but I meant the device type
> and device class.

So, I guess we need something like device_suspend() and device_resume()
for run-time PM, but we also will need to update the documentation.

I'll try to prepare a patch for that, unless you already have one ready or
in the works.

Rafael
