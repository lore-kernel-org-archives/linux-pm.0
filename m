From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Some sort corruption of my Thermal Subsystem after
	suspend to ram
Date: Thu, 1 May 2008 14:06:12 +0100
Message-ID: <20080501130612.GB19922__46185.5997368277$1209647306$gmane$org@srcf.ucam.org>
References: <4818D9AB.3040402@googlemail.com>
	<200805010157.58607.lenb@kernel.org>
	<20080501125348.GA19922@srcf.ucam.org>
	<200805011457.51238.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200805011457.51238.rjw@sisk.pl>
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
Cc: pavel@suse.cz, Gabriel C <nix.or.die@googlemail.com>, linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 01, 2008 at 02:57:49PM +0200, Rafael J. Wysocki wrote:
> On Thursday, 1 of May 2008, Matthew Garrett wrote:
> > Perhaps we should be more aggressive about restoring PCI config space if 
> > there's no driver bound to a device. The alternative in this case would 
> > seem to be to write a driver for this device that does nothing other 
> > than handle suspend/resume.
> 
> Well, we have default suspend/resume for PCI devices.  They are called for
> devices that have no drivers bound to them and execute
> pci_restore_state()/pci_restore_state(), among other things.  Isn't that
> sufficient?

That only saves the "standard" registers, not the rest of config space.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
