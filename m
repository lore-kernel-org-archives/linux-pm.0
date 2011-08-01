From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mrst_pmu: driver for Intel Moorestown Power
 Management Unit
Date: Mon, 1 Aug 2011 16:39:38 +0100
Message-ID: <20110801163938.74d03c2d__31040.7058605508$1312213133$gmane$org@lxorguk.ukuu.org.uk>
References: <alpine.LFD.2.02.1107122328180.4502@x980>
	<20110713105105.63e2fbcb@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.02.1108011116160.23581@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1108011116160.23581@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 01 Aug 2011 11:24:45 -0400 (EDT)
Len Brown <lenb@kernel.org> wrote:

> 
> > > +	BUG_ON(pci_dev_num != mrst_devs[index].pci_dev_num);
> > 
> > That strikes me as needlessly unfriendly, you could warn/return NULL and
> > propogate a WARN_ONCE back to the user.
> 
> If a fit of friendlyness, I wrote the patch below.
> Let me know if it is not what you had in mind.

It's not so much the bug on as the fact it spews these if you boot it on
a non mrst box built with a generic kernel - which was the second part of
my comment and doesn't appear addressed.
