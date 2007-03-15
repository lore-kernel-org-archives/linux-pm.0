From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH/RFC] PCI prepare/activate instead of enable
	to avoid IRQ storm and rogue DMA access
Date: Thu, 15 Mar 2007 11:17:13 +0100
Message-ID: <20070315101713.GA10114@one.firstfloor.org>
References: <20070314152302.GB15600@htj.dyndns.org>
	<p73fy878pmg.fsf@bingen.suse.de> <45F8B1FE.5060406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45F8B1FE.5060406@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Tejun Heo <htejun@gmail.com>
Cc: michal.k.k.piotrowski@gmail.com, Jeff Garzik <jeff@garzik.org>, gregkh@suse.de, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, mlord@pobox.com, linux-ide@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, tglx@linutronix.de, shemminger@linux-foundation.org, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: linux-pm@vger.kernel.org

> Do you mean between disabling IRQ mechanisms and enabling PCI device in =

> pcim_prepare_device()?

Yes.

-Andi
