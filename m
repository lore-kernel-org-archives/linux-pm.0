From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting
	for	frozen	filesystems.
Date: Wed, 29 Oct 2008 00:50:58 +0100
Message-ID: <E1KuyKw-0006UP-EK__24853.7648506046$1225238012$gmane$org@pomaz-ex.szeredi.hu>
References: <1224886068.6478.21.camel@nigel-laptop>
	<E1KuQ1J-0002Vw-9Q@pomaz-ex.szeredi.hu>
	<1225106427.26724.5.camel@nigel-laptop>
	<200810271237.40049.rjw@sisk.pl>
	<1225107607.26724.9.camel@nigel-laptop>
	<E1KuRN4-0002gS-Hq@pomaz-ex.szeredi.hu>
	<1225141168.26724.23.camel@nigel-laptop>
	<E1KuZKt-0003jl-2N@pomaz-ex.szeredi.hu>
	<1225145607.26724.54.camel@nigel-laptop>
	<E1Kuv87-00064p-Lk@pomaz-ex.szeredi.hu>
	<1225235054.9661.37.camel@nigel-laptop>
	<E1Kuxk4-0006NT-Ie@pomaz-ex.szeredi.hu>
	<1225235860.9661.42.camel@nigel-laptop>
	<E1KuxvH-0006Q0-Dy@pomaz-ex.szeredi.hu>
	<1225237298.9661.55.camel@nigel-laptop>
	<E1KuyFq-0006Sc-PC@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <E1KuyFq-0006Sc-PC@pomaz-ex.szeredi.hu> (message from Miklos
	Szeredi on Wed, 29 Oct 2008 00:45:42 +0100)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ncunningham@crca.org.au
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, miklos@szeredi.hu
List-Id: linux-pm@vger.kernel.org

On Wed, 29 Oct 2008, Miklos Szeredi wrote:
> On Wed, 29 Oct 2008, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Wed, 2008-10-29 at 00:24 +0100, Miklos Szeredi wrote:
> > > On Wed, 29 Oct 2008, Nigel Cunningham wrote:
> > > > Remember, though, that we're only freezing fuse at the moment, and
> > > > strictly one filesystem at a time. We can thus happily wait for the
> > > > i_mutex taken by some other process to be released.
> > > 
> > > Not going to work: you need to wait for all requests to be finished,
> > > but those might depend on some other fuse filesystem which has already
> > > been frozen.
> > 
> > Okay. In that case, am I right in thinking that the request waiting on
> > the frozen filesystem will be stuck in request_wait_answer,
> 
> Yes.
> 
> > and the
> > userspace process that was trying to satisfy the request will be stuck
> > in the FUSE_MIGHT_FREEZE call that was invoked for the frozen
> > filesystem?

Sorry, I misunderstood this.  Yes you're right, in the case of one
fuse filesystem relying on another to complete the request the already
frozen one will be stuck in FUSE_MIGHT_FREEZE().

How does that help?

Miklos
