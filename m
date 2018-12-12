From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI / PM: Allow runtime PM without callback functions
Date: Wed, 12 Dec 2018 15:49:37 -0600
Message-ID: <20181212214937.GI99796@google.com>
References: <20181023114552.22958-1-jarkko.nikula@linux.intel.com>
 <CAJZ5v0gna-KvmezNGmCJZTwMrSBHyxbXqPZi12aKjEkxkr=YPQ@mail.gmail.com>
 <14190b11-f7f1-3a27-1476-8b043bd72555@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <14190b11-f7f1-3a27-1476-8b043bd72555@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 12, 2018 at 01:42:29PM +0200, Jarkko Nikula wrote:
> Hi
> 
> On 10/25/18 4:57 PM, Rafael J. Wysocki wrote:
> > On Tue, Oct 23, 2018 at 1:46 PM Jarkko Nikula
> > <jarkko.nikula@linux.intel.com> wrote:
> > > 
> > > Commit a9c8088c7988 ("i2c: i801: Don't restore config registers on
> > > runtime PM") nullified the runtime PM suspend/resume callback pointers
> > > while keeping the runtime PM enabled.
> > > 
> > > This causes that SMBus PCI device stays in D0 power state and sysfs
> > > /sys/bus/pci/devices/[SMBus PCI ID]/power/runtime_status shows "error"
> > > when the runtime PM framework attempts to autosuspend the device. This
> > > is due PCI bus runtime PM which checks for driver runtime PM callbacks
> > > and returns with -ENOSYS if they are not set.
> > > 
> > > Since i2c-i801.c don't need to do anything device specific beyond PCI
> > > device power state management Jean Delvare proposed if this can be fixed
> > > in the PCI subsystem core level rather than adding dummy runtime PM
> > > callback functions in the PCI drivers.
> > > 
> > > Change the pci_pm_runtime_suspend()/pci_pm_runtime_resume() semantics so
> > > that they allow change the PCI device power state during runtime PM
> > > transitions even if no runtime PM callback functions are defined.
> > > 
> > > This change fixes the runtime PM regression on i2c-i801.c.
> > > 
> > > It is not obvious why the code had hard requirements for the runtime PM
> > > callbacks. Test has been here since the code was introduced by the
> > > commit 6cbf82148ff2 ("PCI PM: Run-time callbacks for PCI bus type").
> > > 
> > > On the other hand similar change than this was done to generic runtime
> > > PM callbacks way back in the commit 05aa55dddb9e ("PM / Runtime: Lenient
> > > generic runtime pm callbacks").
> > > 
> > > Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> > > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Cc: <stable@vger.kernel.org> # 4.18+
> > > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> I guess this patch with Reviewed-by tags from Rafael and Jean got buried
> under other list traffic as I don't find this from pci.git or linux-next?

Sorry, I totally dropped the ball on this.  I normally would interpret
Rafael's reviewed-by as an indication that he intends me to pick it
up.  My only excuse is some travel and unexpected sick time that has
put me behind.

I applied this to pci/pm for v4.21, with Reviewed-by tags from Jean
and Rafael, thanks!

Bjorn
