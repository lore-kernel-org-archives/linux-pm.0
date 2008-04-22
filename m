From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: device_pm_add (was: Re: 2.6.25-git2: BUG: unable to
 handle kernel paging request at ffffffffffffffff)
Date: Tue, 22 Apr 2008 13:58:43 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804221350110.2779@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0804201410090.2779@woody.linux-foundation.org>
	<c4e36d110804221135v1dbfaf1bn4557052d1ead6060@mail.gmail.com>
	<alpine.LFD.1.10.0804221144130.2779@woody.linux-foundation.org>
	<200804222234.19936.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804222234.19936.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, paulmck@linux.vnet.ibm.com, David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au
List-Id: linux-pm@vger.kernel.org



On Tue, 22 Apr 2008, Rafael J. Wysocki wrote:
> 
> There is a bug in device_add() that IMO can be fixed this way:

Ok, looks fine. Greg?

> Index: linux-2.6/drivers/base/core.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/core.c
> +++ linux-2.6/drivers/base/core.c
> @@ -820,11 +820,11 @@ int device_add(struct device *dev)
>  	error = bus_add_device(dev);
>  	if (error)
>  		goto BusError;
> +	bus_attach_device(dev);
>  	error = device_pm_add(dev);
>  	if (error)
>  		goto PMError;
>  	kobject_uevent(&dev->kobj, KOBJ_ADD);
> -	bus_attach_device(dev);
>  	if (parent)
>  		klist_add_tail(&dev->knode_parent, &parent->klist_children);
>  
> The problem is that bus_remove_device() assumes bus_attach_device() to have
> run, AFAICS.

As to the other issue:

> > So I would suggest reverting that commit, or at least just making it a 
> > warning (while still registering the device).
> 
> Are drivers supposed to register children of suspended devices?  That doesn't
> make much sense IMO ...

Well, that's why I think the warning itself makes sense - and then we can 
decide whether it makes sense for that particular case or not. Clearly it 
happens (since it triggered), now we need to figure out _why_ it happened. 

But I don't think debugging messages should change behaviour.

		Linus
