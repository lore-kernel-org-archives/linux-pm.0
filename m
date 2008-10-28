From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for frozen
	filesystems.
Date: Tue, 28 Oct 2008 23:02:35 +0100
Message-ID: <E1Kuwe3-0006Gc-LF__18963.1097986878$1225231587$gmane$org@pomaz-ex.szeredi.hu>
References: <1224886068.6478.21.camel@nigel-laptop>
	<1225229399.9661.13.camel@nigel-laptop>
	<E1KuwTn-0006EQ-8J@pomaz-ex.szeredi.hu>
	<200810282300.31164.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200810282300.31164.rjw@sisk.pl>
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
> > On Wed, 29 Oct 2008, Nigel Cunningham wrote:
> > > > However it does not fix the freezing of tasks which are waiting for
> > > > VFS locks (i.e. inode->i_mutex) held by the outstanding fuse requests.
> > > > This is the tricky part...
> > > 
> > > Convert them all to wait_event_freezeable.
> > 
> > You mean convert mutexes to event queues?  Not a very good idea.
> > 
> > I fear we are going down the same path as the last time.  I still
> > don't think rewriting the VFS is the right solution to the freezing
> > problem.  But hey, if you want, sumbit a patch or an RFD and lets see
> > what others think.
> 
> So, what solution would you prefer?

I would prefer a freezer-less solution.  Suspend to ram doesn't need
the freezer, and with the kexec approach hibernate could be done
without it also.

I don't think adding hacks to the VFS to work around the issues with
the freezer is the right way to solve this.  But this is just my
personal opinion, the VFS maintainers may think otherwise.

Miklos
