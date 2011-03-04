From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Xen-devel] Re: [PATCH 0/3] xen: Use PM/Hibernate
	events for save/restore/chkpt
Date: Fri, 4 Mar 2011 21:52:02 +0100
Message-ID: <201103042152.02341.rjw__7070.53651935912$1299272106$gmane$org@sisk.pl>
References: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
	<alpine.DEB.2.00.1102281104180.19277@kaball-desktop>
	<AANLkTimVaxA6fJw+pKacAt=KAt6b9qTZFAL1sjSKbhX6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimVaxA6fJw+pKacAt=KAt6b9qTZFAL1sjSKbhX6@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rshriram@cs.ubc.ca
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Jan Beulich <JBeulich@novell.com>, Ian Campbell <Ian.Campbell@eu.citrix.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, March 04, 2011, Shriram Rajagopalan wrote:
> On Mon, Feb 28, 2011 at 3:06 AM, Stefano Stabellini
> <stefano.stabellini@eu.citrix.com> wrote:
> > On Fri, 25 Feb 2011, Rafael J. Wysocki wrote:
> >> On Friday, February 25, 2011, Stefano Stabellini wrote:
> >> > On Thu, 24 Feb 2011, Rafael J. Wysocki wrote:
> >> > > > I believe it only "[PATCH 3/3] PM: pm.h - Add comments about Xen save/restore/chkpt use case"
> >> > > >
> >> > > > (http://marc.info/?i=1298157158-5421-4-git-send-email-rshriram@cs.ubc.ca)
> >> > >
> >> > > This particular one should go in _after_ the functional patches.
> >> > >
> >> > > > I or Stefano (these patches are against Ian's tree which is againsts Stefano's
> >> > > > tree) can take the other patches and stick Pavel's Ack, Rafeal's Ack, Ian's Ack
> >> > > > on them and also my Signed-off for the Xen bits.
> >> > > >
> >> > > > I think that would work?
> >> > >
> >> > > In fact, I think it's better if all patches go through the Xen tree.
> >> > >
> >> >
> >> > I don't mind taking them but if they have to go after your
> >> > suspend-2.6/linux-next tree this would introduce a new dependency in the
> >> > branch I am preparing for linux-next myself.
> >> >
> >> > Should I pull your suspend-2.6/linux-next tree into my linux-next branch?
> >> > Considering that this could create conflicts in linux-next if you
> >> > force-push your tree with some new changes and I don't update my version
> >> > of it, maybe it is better if I pull only a reduced version of it with
> >> > just the strict dependencies?
> >>
> >> It's not that simple, I think you'd need to pull my entire linux-next branch
> >> because of the dependencies between commits in there.
> >>
> >> Alternatively, I can take the entire $subject patchset.
> >>
> >> Still, I'd like the discussion to settle before anyway.
> >
> There has been no further discussion on this issue so far. Is there a
> consensus ? To summarize:
>  XEN_SAVE_RESTORE depends on HIBERNATE, and in order to
> enable the save/restore functionality, the user has to enable HIBERNATE
> explicitly.
>  In thread "xen: fix XEN_SAVE_RESTORE Kconfig dependencies", Jan raised
> an issue about "selecting" HIBERNATE & SWAP without the user's knowledge. That
> was resolved by making XEN_SAVE_RESTORE "depend" on HIBERNATE and
> making the user explicitly select it.
>  Rafael suggested making an intermediate interface CONFIG_HIBERNATE_INTERFACE
> as an alternative but at the cost of a lot of code rework possibly.

Not really.  There are a few files I'd like to depend on
CONFIG_HIBERNATE_INTERFACE initially (in kernel/power/ mostly) and the more
fine-grained differentiation can be done later over time.

So, my suggestion is to introduce CONFIG_HIBERNATE_INTERFACE as discussed
elsewhere and rework CONFIG_XEN_SAVE_RESTORE accordingly.

Thanks,
Rafael
