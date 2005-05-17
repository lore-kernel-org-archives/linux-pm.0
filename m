From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Tue, 17 May 2005 21:28:10 +0200
Message-ID: <200505172128.10344.rjw@sisk.pl>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
	<200505171110.47030.rjw@sisk.pl>
	<200505171135.09928.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505171135.09928.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 17 of May 2005 20:35, David Brownell wrote:
> On Tuesday 17 May 2005 2:10 am, Rafael J. Wysocki wrote:
> 
> > Could you please have a look at http://bugzilla.kernel.org/show_bug.cgi?id=4416
> 
> Sorry, I don't have much time for such things; especially for
> problems that only appear in the MM tree (with so many non-USB
> changes) ... and which already appear to be board-specific, and
> tied to ACPI changes.

Never mind.  :-)

> > There seems to be a problem with OHCI and EHCI drivers wrt suspend/resume
> > (swsusp) in the current -mm on that box.
> 
> Is that with or without those ACPI fixes?

Both ...

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
