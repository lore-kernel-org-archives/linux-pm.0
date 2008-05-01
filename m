From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Some sort corruption of my Thermal Subsystem after
	suspend to ram
Date: Thu, 1 May 2008 19:14:37 +0200
Message-ID: <200805011914.38511.rjw__3038.794353097$1209662317$gmane$org@sisk.pl>
References: <4818D9AB.3040402@googlemail.com> <200805011457.51238.rjw@sisk.pl>
	<20080501130612.GB19922@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080501130612.GB19922@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: pavel@suse.cz, Gabriel C <nix.or.die@googlemail.com>, linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 1 of May 2008, Matthew Garrett wrote:
> On Thu, May 01, 2008 at 02:57:49PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, 1 of May 2008, Matthew Garrett wrote:
> > > Perhaps we should be more aggressive about restoring PCI config space if 
> > > there's no driver bound to a device. The alternative in this case would 
> > > seem to be to write a driver for this device that does nothing other 
> > > than handle suspend/resume.
> > 
> > Well, we have default suspend/resume for PCI devices.  They are called for
> > devices that have no drivers bound to them and execute
> > pci_restore_state()/pci_restore_state(), among other things.  Isn't that
> > sufficient?
> 
> That only saves the "standard" registers, not the rest of config space.

Hm, in that case I'd probably opt for writing a special driver for this
particular device.

Thanks,
Rafael
