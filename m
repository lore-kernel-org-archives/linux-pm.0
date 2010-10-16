From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ath9k: Convert to new PCI PM framework
Date: Sat, 16 Oct 2010 22:02:52 +0200
Message-ID: <201010162202.52766.rjw__17762.5144286596$1287274083$gmane$org@sisk.pl>
References: <201010160036.17653.rjw@sisk.pl>
	<AANLkTimdatos1psRnp_Es=q8iOe9aQE_aVARLpm18efb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimdatos1psRnp_Es=q8iOe9aQE_aVARLpm18efb@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ath9k-devel@venema.h4ckr.net, linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, October 16, 2010, Luis R. Rodriguez wrote:
> On Fri, Oct 15, 2010 at 3:36 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > The ath9k driver uses the legacy PCI power management (suspend
> > and resume) callbacks that apparently cause intermittent problems
> > to happen (the adapter sometimes doesn't resume correctly on my
> > Acer Ferrari One).  Make it use the new PCI PM and let the PCI core
> > code handle the PCI-specific details of power transitions.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Do you know when these hooks were added?

Well, which ones?  If you're asking about the new framework, it's been there
since 2.6.29 and is a recommended way of implementing PM hooks now.

Please have a look at Documentation/power/pci.txt. :-)

> If it fixes an issue should this go for stable?

I'm not 100% sure it fixes everything yet, although I hasn't been able to
reproduce the problem with it applied, so far.

So, I don't think it's -stable material at this point.  However, it should be
done anyway at one point, so it very well can be done right now, given that I
have the hardware to test it. :-)

Thanks,
Rafael
