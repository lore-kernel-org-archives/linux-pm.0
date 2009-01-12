From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression] USB wakeup problem on Toshiba Portege
	R500
Date: Mon, 12 Jan 2009 23:53:59 +0100
Message-ID: <200901122353.59887.rjw__4548.1193963953$1231801377$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0901121649470.13021-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901121649470.13021-100000@netrider.rowland.org>
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
Cc: gregkh@suse.de, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pavel@suse.cz, linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 12 January 2009, Alan Stern wrote:
> On Fri, 9 Jan 2009, Rafael J. Wysocki wrote:
> 
> > > My proposal:
> > > 
> > > 	Devices and events that are clearly associated with system
> > > 	wakeup should be enabled by default.  For example: Power
> > > 	button and laptop lid.
> > 
> > Agreed.
> > 
> > > 	All other devices capable of waking up the system should be
> > > 	disabled by default.  This presumably includes every PCI
> > > 	device.  If users want keyboard or mouse events to cause
> > > 	a system resume then they will have to configure their
> > > 	desktop management program to enable it.
> > 
> > I generally agree, with one exception.  There are network adapters which
> > can be enabled to wake up by the BIOS and their drivers set them up for WoL
> > currently on this basis.  These should remain enabled IMO.
> 
> How do we know which adapters these are?  IMO the PCI core should
> disable wakeup by default for all devices when they are detected.

This is what we do.

> Is it sufficient to have the adapter drivers enable wakeup during
> their probe routines?

Yes, it is.

Thanks,
Rafael
