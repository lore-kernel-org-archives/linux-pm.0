From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Xen-devel] Re: [PATCH 0/3] xen: Use PM/Hibernate
	events for save/restore/chkpt
Date: Fri, 25 Feb 2011 19:24:47 +0100
Message-ID: <201102251924.47802.rjw__25711.3249194392$1298658429$gmane$org@sisk.pl>
References: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
	<201102241941.00984.rjw@sisk.pl>
	<alpine.DEB.2.00.1102251713560.19277@kaball-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1102251713560.19277@kaball-desktop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Beulich <JBeulich@novell.com>, Ian Campbell <Ian.Campbell@eu.citrix.com>, Shriram Rajagopalan <rshriram@cs.ubc.ca>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, February 25, 2011, Stefano Stabellini wrote:
> On Thu, 24 Feb 2011, Rafael J. Wysocki wrote:
> > > I believe it only "[PATCH 3/3] PM: pm.h - Add comments about Xen save/restore/chkpt use case"
> > > 
> > > (http://marc.info/?i=1298157158-5421-4-git-send-email-rshriram@cs.ubc.ca)
> > 
> > This particular one should go in _after_ the functional patches.
> > 
> > > I or Stefano (these patches are against Ian's tree which is againsts Stefano's
> > > tree) can take the other patches and stick Pavel's Ack, Rafeal's Ack, Ian's Ack
> > > on them and also my Signed-off for the Xen bits.
> > > 
> > > I think that would work?
> > 
> > In fact, I think it's better if all patches go through the Xen tree.
> > 
>  
> I don't mind taking them but if they have to go after your
> suspend-2.6/linux-next tree this would introduce a new dependency in the
> branch I am preparing for linux-next myself.
> 
> Should I pull your suspend-2.6/linux-next tree into my linux-next branch?
> Considering that this could create conflicts in linux-next if you
> force-push your tree with some new changes and I don't update my version
> of it, maybe it is better if I pull only a reduced version of it with
> just the strict dependencies?

It's not that simple, I think you'd need to pull my entire linux-next branch
because of the dependencies between commits in there.

Alternatively, I can take the entire $subject patchset.

Still, I'd like the discussion to settle before anyway.

Thanks,
Rafael
