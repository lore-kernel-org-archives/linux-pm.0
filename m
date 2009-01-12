From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Regression] USB wakeup problem on Toshiba Portege
	R500
Date: Mon, 12 Jan 2009 16:53:47 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901121649470.13021-100000__12953.402932226$1231797518$gmane$org@netrider.rowland.org>
References: <200901091853.42700.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901091853.42700.rjw@sisk.pl>
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
Cc: gregkh@suse.de, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pavel@suse.cz, linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 9 Jan 2009, Rafael J. Wysocki wrote:

> > My proposal:
> > 
> > 	Devices and events that are clearly associated with system
> > 	wakeup should be enabled by default.  For example: Power
> > 	button and laptop lid.
> 
> Agreed.
> 
> > 	All other devices capable of waking up the system should be
> > 	disabled by default.  This presumably includes every PCI
> > 	device.  If users want keyboard or mouse events to cause
> > 	a system resume then they will have to configure their
> > 	desktop management program to enable it.
> 
> I generally agree, with one exception.  There are network adapters which
> can be enabled to wake up by the BIOS and their drivers set them up for WoL
> currently on this basis.  These should remain enabled IMO.

How do we know which adapters these are?  IMO the PCI core should
disable wakeup by default for all devices when they are detected.
Is it sufficient to have the adapter drivers enable wakeup during
their probe routines?

> > 	Devices not capable of directly waking the system can be
> > 	enabled.  This includes things like USB devices, which
> > 	have to pass a wakeup request through their parent and
> > 	therefore can't wake up the system unless the parent is
> > 	also enabled for wakeup.
> 
> Agreed.

Alan Stern
