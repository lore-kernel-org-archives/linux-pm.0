From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Thu, 20 Aug 2009 10:03:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908201000510.3048-100000@iolanthe.rowland.org>
References: <20090820010528.GA9596@zhen-devel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090820010528.GA9596@zhen-devel.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@redhat.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Aug 2009, Zhenyu Wang wrote:

> On 2009.08.19 10:42:07 -0400, Alan Stern wrote:
> > On Wed, 19 Aug 2009, Zhenyu Wang wrote:
> > 
> > > Rafael, as I added this restore long time ago, pci core has changed in some way?
> > > We had problem when reconfigure agp GTT space in resume, as we must be sure
> > > gfx device's config space has been restored properly, and as 02:00 gfx device
> > > restored later than host bridge 00:00 device, that came to my origin patch to
> > > restore it earlier.
> > 
> > Why did you do it that way?  I mean, why not restore the gfx device's 
> > config space in its own resume routine instead of in the host bridge's 
> > resume routine?
> > 
> 
> That's the order issue I have mentioned. intel_agp is the pci driver for
> host bridge (dev 00:00), and drm/i915 is the pci driver for gfx device
> (dev 00:02). Host bridge will always resume earlier than gfx device, but
> for intel_agp we need to access gfx device when reconfigure GTT in resume,
> we can't wait until restore happen in i915 driver.
> 
> So there might be a conflict here, as i915 driver also do pci_restore_state()
> after we did reconfigure in intel_agp driver, some configs may be corrupted 
> then. Although I haven't seen it in real testing. 

This might be a silly question, but why don't you see the same problem 
during system initialization?  The host bridge will be probed before 
the gfx device, so you can't access the gfx device while initializing 
the GTT.

Alan Stern
