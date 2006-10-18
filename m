From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Block on access to temporarily unavailable
	pci device
Date: Wed, 18 Oct 2006 16:50:51 +0100
Message-ID: <1161186652.9363.68.camel@localhost.localdomain>
References: <20061017145146.GJ22289@parisc-linux.org>
	<45354A59.3010109@us.ibm.com> <20061018145104.GN22289@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061018145104.GN22289@parisc-linux.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brian King <brking@us.ibm.com>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

Ar Mer, 2006-10-18 am 08:51 -0600, ysgrifennodd Matthew Wilcox:
> The existing implementation of pci_block_user_cfg_access() was recently
> criticised for providing out of date information and for returning errors
> on write, which applications won't be expecting.

It was also favoured by some of us as well. In addition this whole issue
was extensively debated in the past to select the current approach. That
said I do like the approach of a short wait *specifically* on power
transitions, its bounded in time, its neat and it makes sense. =


We must be very very sure its never triggered in the real world any
other way (eg your >block testing must be impossible)

So unless you distinguish between "back in a moment", "back someday" and
"not coming back" it isn't useful. Thus your patch is incomplete as it
does not provide the cache that is also needed. At least I don't think X
hanging forever mid mode switch is terribly useful...

> I also addressed the potential issue with nested attempts to block.
> Now pci_block_user_cfg_access() can return -EBUSY if it's already blocked,
> and pci_unblock_user_cfg_access() will WARN if you try to unblock an
> already unblocked device.

Gak that is IMHO a mistake. Just keep a counter. You've just added
another "what the hell do I do if this returns -EBUSY" problem for all
the driver authors.

> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

NAK for all the above reasons. This is a cure looking for a disease, and
its a cure which is worse than the theoretical disease it wants to fix.
