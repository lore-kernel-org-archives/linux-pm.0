From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: A reference implementation of PCI
 suspend/resume?
Date: Mon, 16 May 2005 15:19:37 -0600
Message-ID: <20050516151937.63b37fbb@cosmic.amd.com>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
	<20050516201606.GA11189@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============16759482673311266=="
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
To: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============16759482673311266==
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 16 May 2005 16:16:06 -0400
"Adam Belay" <ambx1@neo.rr.com> wrote:

> b.) You're assuming every device has its own interrupt.  This may not
> be the case.  Let's say one device was sharing interrupts with a few
> other devices. We don't want it's interrupt handler to mess up things
> when it tries to read hardware registers from a physically "off"
> device, as it may possibly generate errors.  Almost every interrupt
> handler assumes the device is "on", as it should.  Each interrupt
> handler has to ask its hardware if it generated the interrupt.

I ran into this very problem a while back on 2.4. On my platform, the
EHCI and OCHI host controllers share an interrupt.  I was insmoding the
EHCI module before the OHCI module, but it turned out that the OHCI
controller was first on the bus, so it went down first during suspend,
and up first on resume.  Long story short, it starting firing interrupts
which went to the EHCI driver first (since it was earlier on the
interrupt handler chain), and the device faithfully hung waiting to read
hardware that was still powered off.

Now, granted that particular scenario is a corner case, and the PCI
hardware should have been configured better, but it shows that you
can't assume that any given interrupt handler will only be called with
active hardware underneath.

So either an "active" bit gets added to each and every driver to be
checked in an interrupt routine, or we bail on the handler all together
- I fancy the second.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>



--===============16759482673311266==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============16759482673311266==--
