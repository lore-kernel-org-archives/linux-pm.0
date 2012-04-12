From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 12:52:21 -0400
Message-ID: <1334249541.23924.338.camel@gandalf.stny.rr.com>
References: <20120412153750.GA12852@belkar.wrar.name>
	<Pine.LNX.4.44L0.1204121203530.1496-100000@iolanthe.rowland.org>
	<20120412164903.GB12852@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120412164903.GB12852@belkar.wrar.name>
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
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2012-04-12 at 22:49 +0600, Andrey Rahmatullin wrote:
> On Thu, Apr 12, 2012 at 12:09:00PM -0400, Alan Stern wrote:
> > > > Here's a diagnostic patch that will give us a little more information.  
> > > > Keep the previous change (so that pci_prepare_to_sleep gets called 
> > > > whether ehci-hcd is bound or not) and let's see what it says.  Try 
> > > > doing it both with and without ehci-hcd bound.  Running this with "echo 
> > > > devices >/sys/power/pm_test" ought to be good enough.
> > > I don't see that line with ehci_hcd both bound and unbound and both in
> > > 'devices' test and in a real S3.
> > 
> > You mean the new dev_info message did not appear at all?  Is
> > pci_prepare_to_sleep getting called properly?  Or does the routine exit
> > early because target_state is equal to PCI_POWER_ERROR?
> Either dev_info is silenced on my system or pci_pm_suspend_noirq is not
> called during the 'devices' pm test.
> 

Did you undo the original change that removed the call to
pci_prepare_to_sleep()?

-- Steve
