From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup
	and fixes
Date: Sat, 22 Mar 2008 11:29:34 -0700
Message-ID: <200803221129.34982.david-b__47429.2365638123$1206210688$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0803202053270.11234-100000@netrider.rowland.org>
	<200803221055.12541.david-b@pacbell.net>
	<200803221911.01670.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803221911.01670.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 22 March 2008, Rafael J. Wysocki wrote:
> 
> > It seems to me that your objection boils down to the concern
> > that those drivers may just have pushed their bug out a level,
> > rather than actually fixing their bugs.
> 
> Or, the authors of the drivers looked at what the code in
> pci_choose_state() actually did and used it on that basis.

That sounds like *exactly* the same thing.
