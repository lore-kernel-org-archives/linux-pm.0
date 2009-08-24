From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PME# for add-on cards
Date: Mon, 24 Aug 2009 20:39:07 +0200
Message-ID: <200908242039.07607.rjw__21053.0231743634$1251139291$gmane$org@sisk.pl>
References: <200908240112.39424.rjw@sisk.pl>
	<20090824094429.GB1134@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090824094429.GB1134@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 24 August 2009, Matthew Garrett wrote:
> On Mon, Aug 24, 2009 at 01:12:39AM +0200, Rafael J. Wysocki wrote:
> 
> > After some debugging it turned out that PCI0 is the PCI host bridge
> > (no-bus:pci0000:00), so apparently echoing PCI0 to /proc/acpi/wakeup causes
> > a wake-up GPE to be set up for the host bridge which triggers wake-up once
> > eth0 signals PME#.
> 
> Mm. That sounds entirely plausible. If it were a built-in card then the 
> DSDT would provide that GPE, but as an add-in...
> 
> > First, I wonder if that's the case in general (anybody knows?).  Second, if
> > that is the case, would it be a good idea to set up the host bridge wake-up GPE
> > by default?
> 
> I'd expect this to be the case in general, yes. Systems that work 
> without this probably have the BIOS enable it themselves on suspend. I 
> suspect we'll have to set it to make sure.

OK, Matthew, Alan, thanks for your opinions.

I'll try to implement this, then.

Best,
Rafael
