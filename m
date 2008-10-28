From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Freezer: Don't count threads waiting for frozen
	filesystems.
Date: Tue, 28 Oct 2008 23:21:58 +0100
Message-ID: <200810282321.59041.rjw__48806.8435727202$1225232483$gmane$org@sisk.pl>
References: <1224886068.6478.21.camel@nigel-laptop>
	<200810282300.31164.rjw@sisk.pl>
	<E1Kuwe3-0006Gc-LF@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1Kuwe3-0006Gc-LF@pomaz-ex.szeredi.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 28 of October 2008, Miklos Szeredi wrote:
> On Tue, 28 Oct 2008, Rafael J. Wysocki wrote:
> > On Tuesday, 28 of October 2008, Miklos Szeredi wrote:
> > > On Wed, 29 Oct 2008, Nigel Cunningham wrote:
> > > > > However it does not fix the freezing of tasks which are waiting for
> > > > > VFS locks (i.e. inode->i_mutex) held by the outstanding fuse requests.
> > > > > This is the tricky part...
> > > > 
> > > > Convert them all to wait_event_freezeable.
> > > 
> > > You mean convert mutexes to event queues?  Not a very good idea.
> > > 
> > > I fear we are going down the same path as the last time.  I still
> > > don't think rewriting the VFS is the right solution to the freezing
> > > problem.  But hey, if you want, sumbit a patch or an RFD and lets see
> > > what others think.
> > 
> > So, what solution would you prefer?
> 
> I would prefer a freezer-less solution.  Suspend to ram doesn't need
> the freezer,

Well, yes it does.  And it will in forseeable future, AFAICS.

> and with the kexec approach hibernate could be done without it also.

There are problems with that too, although they aren't directly related to
filesystems.

> I don't think adding hacks to the VFS to work around the issues with
> the freezer is the right way to solve this.  But this is just my
> personal opinion, the VFS maintainers may think otherwise.

Well, my personal opinion is that we need filesystems to support suspend,
this way or another and the sooner it happens, the better.  Still, I'm rather
not going to make that happen myself. :-)

Apparently, Nigel is willing to work in this direction and we can use this as
an opportunity to learn what exactly is necessary for this purpose and _then_
decide if this is reasonable or not instead of dismissing it upfront.

Thanks,
Rafael
