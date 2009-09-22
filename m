From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI PM: Read device power state from
	register after updating it (rev. 2)
Date: Tue, 22 Sep 2009 22:39:08 +0200
Message-ID: <200909222239.08255.rjw__33555.1064963967$1253653085$gmane$org@sisk.pl>
References: <20090922080747.GA20853@rhlx01.hs-esslingen.de>
	<200909222150.01185.rjw@sisk.pl>
	<7004b08e0909221256m6d917531kc8b51e1af85d3459@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <7004b08e0909221256m6d917531kc8b51e1af85d3459@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: kevin granade <kevin.granade@gmail.com>
Cc: linux-pci@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andreas Mohr <andi@lisas.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday 22 September 2009, kevin granade wrote:
> On Tue, Sep 22, 2009 at 2:50 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > On Tuesday 22 September 2009, Andreas Mohr wrote:
> > > Hi Rafael,
> >
> > Hi,
> >
> > > first you say "returning an error code in such cases would..."
> > > and then the patch content has...?
> >
> > I don't quite understand your comment, care to elaborate?
> >
> >
> I think this is what was being referenced:
> 
> +       /* Return error code if we have failed to change the state */
> +       if (dev->current_state != state)
> +               dev_info(&dev->dev, "Refused to change power state, "
> +                       "currently in D%d\n", dev->current_state);
> 
> The comment says, "Return error code", where it should probably say, "Log
> error".  Or possibly no comment at all.

Ah, thanks.

Rafael
