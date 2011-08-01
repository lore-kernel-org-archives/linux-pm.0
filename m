From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] mrst_pmu: driver for Intel Moorestown Power
	Management Unit
Date: Mon, 01 Aug 2011 01:47:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1108010135290.26733__14434.0136474513$1312177733$gmane$org@x980>
References: <alpine.LFD.2.02.1107122328180.4502@x980>
	<20110713105105.63e2fbcb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110713105105.63e2fbcb@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> > +static struct mrst_device *pci_id_2_mrst_dev(u16 pci_dev_num)
> > +{
...
> > +	else
> > +		BUG();
> > +
> > +	BUG_ON(pci_dev_num != mrst_devs[index].pci_dev_num);
> 
> That strikes me as needlessly unfriendly, you could warn/return NULL and
> propogate a WARN_ONCE back to the user.

This code asserts that the firmware is correct, and today it is.
If somebody breaks the firmware in the future, I want them to discover
it the instant they break it.  If I had the option of shooting
lazer beams out of the system to instantly kill the firmware programmer,
I'd do it.  But alas, I have to settle for crashing their system:-)

> > +static int __init scu_fw_check(void)

	if (!mrst_pmu)
		return 0;

> > +late_initcall(scu_fw_check);
> 
> NAK. I pointed this problem with the driver to you way back - this code
> gets run always - even on machines that are not in fact Moorestown which
> are then going to crash.
> 
> You need to check that the platform is Moorestown (not just the CPU
> either because of Oaktrail)

Right-o.  I think the 1-liner to check mrst_pmu above should do it.

thanks for reading, and sorry for being a slow listener,
-Len
