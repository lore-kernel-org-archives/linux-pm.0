From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Mon, 16 May 2005 22:56:29 +0200
Message-ID: <200505162256.30090.rjw@sisk.pl>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
	<20050516201606.GA11189@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============24120061572644014=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050516201606.GA11189@neo.rr.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Fabrice Gautier <Fabrice_Gautier@sdesigns.com>
List-Id: linux-pm@vger.kernel.org

--===============24120061572644014==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Monday, 16 of May 2005 22:16, Adam Belay wrote:
> On Fri, May 13, 2005 at 10:06:42PM -0700, Fabrice Gautier wrote:
> > Hi,
> > 
> > > From: Shaohua Li [mailto:shaohua.li@intel.com] 
> > > Sent: Wednesday, May 11, 2005 6:25 PM
> > > To: linux-pm
> > > Subject: [linux-pm] A reference implementation of PCI suspend/resume?
> > > 
> > > Hi,
> > > There are still many PCI drivers don't implement their 
> > > .suspend/.resume
> > > methods correctly. I felt it would be quite helpful there is 
> > > a reference
> > > implementation. Here is my thought:
> > > 
> > > [...snip...]
> > > 
> > > Currently many drivers don't call
> > > free_irq/request_irq/pci_disable_device, which makes unexpected
> > > interrupt occur and even break suspend/resume in some systems. 
> > 
> > I don't understand why not calling free_irq would cause unexpected
> > interrupts.
> 
> I don't think it would.

Please have a look at http://bugzilla.kernel.org/show_bug.cgi?id=4416
Perhaps you can figure out what else is going on there ...

> However, there are three reasons in favor of unregister PCI interrupts:
> 
> a.) the kernel will complain if the irq isn't handled, revealing a possible
> problem with the driver's suspend routine.
> 
> b.) You're assuming every device has its own interrupt.  This may not be the
> case.  Let's say one device was sharing interrupts with a few other devices.
> We don't want it's interrupt handler to mess up things when it tries to read
> hardware registers from a physically "off" device, as it may possibly generate
> errors.  Almost every interrupt handler assumes the device is "on", as it
> should.  Each interrupt handler has to ask its hardware if it generated the
> interrupt.
> 
> c.) Selective device suspending: obviously we don't want to leave stale
> interrupt handlers around.

I agree.

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============24120061572644014==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============24120061572644014==--
