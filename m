From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Subject: Re: [patch 2.6.13-rc3] pci: restore BAR values after
	D3hot->D0 for devices that need it
Date: Tue, 2 Aug 2005 09:41:32 -0700
Message-ID: <4807377b05080209417c7f5c40@mail.gmail.com>
References: <20050708095104.A612@den.park.msu.ru>
	<20050707.233530.85417983.davem@davemloft.net>
	<20050708110358.A8491@jurassic.park.msu.ru>
	<20050708.003333.28789082.davem@davemloft.net>
	<20050708122043.A8779@jurassic.park.msu.ru>
	<20050708183452.GB13445@tuxdriver.com>
	<20050726234934.GA6584@kroah.com>
	<20050727013601.GA13958@tuxdriver.com>
	<20050727141202.GA22686@tuxdriver.com>
	<20050727141942.GB22686@tuxdriver.com>
Reply-To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050727141942.GB22686@tuxdriver.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 7/27/05, John W. Linville <linville@tuxdriver.com> wrote:
> Some PCI devices (e.g. 3c905B, 3c556B) lose all configuration
> (including BARs) when transitioning from D3hot->D0.  This leaves such
> a device in an inaccessible state.  The patch below causes the BARs
> to be restored when enabling such a device, so that its driver will
> be able to access it.
> 

Is it just me or will this stuff help the kexec guys as well?  They seem 
to have lots of problems because drivers put the device into D3 before the 
reload of the new kernel.  I think this might help.

Jesse
