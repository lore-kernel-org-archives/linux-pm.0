From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 14:17:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204121416050.1496-100000@iolanthe.rowland.org>
References: <20120412181031.GE12852@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120412181031.GE12852@belkar.wrar.name>
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
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Apr 2012, Andrey Rahmatullin wrote:

> On Thu, Apr 12, 2012 at 10:28:31AM -0400, Alan Stern wrote:
> > Here's a diagnostic patch that will give us a little more information.  
> > Keep the previous change (so that pci_prepare_to_sleep gets called 
> > whether ehci-hcd is bound or not) and let's see what it says.  Try 
> > doing it both with and without ehci-hcd bound.  Running this with "echo 
> > devices >/sys/power/pm_test" ought to be good enough.
> If bound: "target 3 wakeup 1 error 0" for both controllers. If not bound,
> pci_prepare_to_sleep is not called for ehci_hcd.

It should be called, because earlier I asked you to add a call to it 
inside pci_pm_suspend_noirq.  Make sure you that line is still present 
when you test.

Alan Stern
