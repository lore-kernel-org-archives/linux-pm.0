From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for frozen
	filesystems.
Date: Wed, 29 Oct 2008 00:21:46 +0100
Message-ID: <E1Kuxsg-0006PR-Tr__40355.4404540502$1225236459$gmane$org@pomaz-ex.szeredi.hu>
References: <1224886068.6478.21.camel@nigel-laptop>
	<200810282300.31164.rjw@sisk.pl>
	<E1Kuwe3-0006Gc-LF@pomaz-ex.szeredi.hu>
	<200810282321.59041.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200810282321.59041.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-kernel@vger.kernel.org, ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org, miklos@szeredi.hu
List-Id: linux-pm@vger.kernel.org

On Tue, 28 Oct 2008, Rafael J. Wysocki wrote:
> On Tuesday, 28 of October 2008, Miklos Szeredi wrote:
> > I would prefer a freezer-less solution.  Suspend to ram doesn't need
> > the freezer,
> 
> Well, yes it does.  And it will in forseeable future, AFAICS.

Umm, OK.  Last I remember everybody agreed that there's absolutely no
reason why processes need to be frozen, and the only important thing
is that drivers are not twiddling the hardware during suspend, and
this can usually easily be solved on the subsystem level.

> > I don't think adding hacks to the VFS to work around the issues with
> > the freezer is the right way to solve this.  But this is just my
> > personal opinion, the VFS maintainers may think otherwise.
> 
> Well, my personal opinion is that we need filesystems to support suspend,
> this way or another and the sooner it happens, the better.  Still, I'm rather
> not going to make that happen myself. :-)
> 
> Apparently, Nigel is willing to work in this direction and we can use this as
> an opportunity to learn what exactly is necessary for this purpose and _then_
> decide if this is reasonable or not instead of dismissing it upfront.

I haven't dismissed it, just voiced my opinion that I think it's the
wrong direction.

Miklos
