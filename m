From: Pavel Machek <pavel@ucw.cz>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Fri, 27 May 2005 09:20:12 +0200
Message-ID: <20050527072012.GA1922@elf.ucw.cz>
References: <1115861087.3817.23.camel@linux-hp.sh.intel.com>
	<1117176553.3925.6.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21056519602704427=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117176553.3925.6.camel@linux-hp.sh.intel.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============21056519602704427==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Currently many drivers don't call 
> > free_irq/request_irq/pci_disable_device, which makes unexpected 
> > interrupt occur and even break suspend/resume in some systems. The 
> > reason is we disable PIC/IOAPIC/irq router very later (they are
> > treated 
> > as a sysdev), so there is a window between when a device is suspend
> > and 
> > when its PIC/IOAPIC/irq router pin are disabled. The ideal way is 
> > PIC/IOAPIC/irq router's pins are disabled soon after no device is 
> > referencing them. I'm now working on disabling irq router if no 
> > reference on it, but first I'd like to know your opinions about the 
> > proposal (the reference .suspend/.resume implementation).
> Hi Pavel,
> Could this be put into your tree? We should fix many PCI drivers, this
> possibly will help us.

Thanks, applied.
								Pavel

--===============21056519602704427==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21056519602704427==--
