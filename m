From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Tue, 15 Mar 2005 22:52:54 +0100
Message-ID: <20050315215253.GE20818@elf.ucw.cz>
References: <20050314022308.GD6008@blackham.com.au>
	<Pine.LNX.4.44L0.0503151636290.711-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9274807608880995=="
In-Reply-To: <Pine.LNX.4.44L0.0503151636290.711-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============9274807608880995==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> One other point: Suspend calls free_irq() and resume calls request_irq().  
> This doesn't seem necessary to me since the common IRQ handler will reject
> interrupts occuring while the controller is suspended.  Also it's asking
> for trouble if the driver is unloaded before the controller is resumed,
> since the remove routine will call free_irq() again on its own.  I've
> #ifdef'ed out those calls below, but this deserves closer attention.

Be carefull with free_irq() / request_irq(). For some reason I needed
to add them to b44 driver. I'm not sure what is going on, perhaps we
are not saving interrupt controller state right?
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============9274807608880995==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============9274807608880995==--
