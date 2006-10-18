From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Block on access to temporarily unavailable
	pci device
Date: Thu, 19 Oct 2006 01:27:04 +1000
Message-ID: <453647C8.8040309@yahoo.com.au>
References: <20061017145146.GJ22289@parisc-linux.org>
	<45354A59.3010109@us.ibm.com>
	<20061018145104.GN22289@parisc-linux.org>
	<4536446A.6000405@yahoo.com.au>
	<20061018151601.GR22289@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061018151601.GR22289@parisc-linux.org>
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
Cc: Brian King <brking@us.ibm.com>, Adam Belay <abelay@MIT.EDU>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Oct 19, 2006 at 01:12:42AM +1000, Nick Piggin wrote:

>>Why not just WARN if it is already blocked as well? Presumably if the
> =

> =

> Because the driver can check the return value and fail the higher level
> operation.
> =

> =

>>driver needs nested blocking, it is going to have to carry some state
>>to know when to do the final unblock anyway, so it may as well just
>>not do these redundant blocks either.
> =

> =

> No driver needs nested blocking, but blocks may be imposed on a driver's
> device by the PCI core, for example.

So doesn't that mean it needs nested blocking? Surely that's better than
failing the operation due to an implementation detail.


>>** or ** just do a counting block/unblock to properly support nesting
>>them. That is, go one way or the other, and do it properly.
> =

> =

> I don't think that's necessary.  Right now, we have one user (IPR's
> BIST) and I'm trying to add a second (D-state transitions).  We don't
> need nested blocks, but we do need to fail in the highly unlikely case
> someone tries to do them.

Well if you really don't need nested blocking and you want to fail in
the highly unlikely case that someone tries... add the WARN.

> If it turns out we actually need them later, let's revisit this when we
> have a user.

I don't know much about the pci layer, so I'm sure you know better than
me whether they are needed or not. But if you think they are not, then
do the WARN rather than return failure.

-- =

SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com =
