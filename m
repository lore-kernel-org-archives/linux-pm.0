From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 21:03:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204122059500.10558-100000@netrider.rowland.org>
References: <20120412202132.GH12852@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120412202132.GH12852@belkar.wrar.name>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Apr 2012, Andrey Rahmatullin wrote:

> On Thu, Apr 12, 2012 at 04:09:43PM -0400, Alan Stern wrote:
> > > Do this with the ehci_reset added and all the other changes present as 
> > > well.
> > 
> > More precisely, keep the ehci_reset call (in both places),
> Which both places?
> 
> > the dev_info call, and the pci_prepare_to_sleep call.  You don't need to
> > set the configflag register to 0; the reset will do that anyway.

Sorry, that was an editing error.  I meant to say the
pci_prepare_to_sleep calls should be kept in both places: the existing 
on in hcd-pci.c and the one added to pci-driver.c.  You got the right 
idea, though.

Alan Stern
