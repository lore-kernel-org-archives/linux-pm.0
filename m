From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Wed, 22 Oct 2008 14:01:52 +0200
Message-ID: <200810221401.53211.rjw__31054.8811140054$1224677208$gmane$org@sisk.pl>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
	<200810192150.41305.rjw@sisk.pl>
	<20081022053444.GC15271@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081022053444.GC15271@sli10-desk.sh.intel.com>
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
To: Shaohua Li <shaohua.li@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 22 of October 2008, Shaohua Li wrote:
> On Mon, Oct 20, 2008 at 03:50:40AM +0800, Rafael J. Wysocki wrote:
> > On Thursday, 11 of September 2008, Shaohua Li wrote:
> > > pci subsystem wakeup handler.
> > 
> > Perhaps add a bit more explanation here - what is introduced, why and why this
> > particular way.
> I'll add a kernel doc in later post.
> 
> > > +static bool pci_handle_one_wakeup_event(struct pci_dev *pdev)
> > > +{
> > 
> > I don't really like that being a boolean function.  I'd make it return 0 on
> > success and error code on failure.
> Oh, in my previous post, somebody like a boolean and then you like an int
> in the mail list. Either is ok to me, but I'd like to have a reason
> instead of a 'like' or 'unlike'.

That was probably me, but in a different context. ;-)

Use 'bool' for functions that are intended as boolean, eg.
'system_entering_hibernation()' will return 'true' if the system is entering
hibernation at the moment and 'false' otherwise, but for functions like
pci_handle_one_wakeup_event() the standard it to return 0 on success, so IMO
we should follow the standard.

HTH
