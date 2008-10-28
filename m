From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Tue, 28 Oct 2008 22:51:59 +0100
Message-ID: <E1KuwTn-0006EQ-8J__45270.1529408388$1225230907$gmane$org@pomaz-ex.szeredi.hu>
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
	<1225229399.9661.13.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1225229399.9661.13.camel@nigel-laptop> (message from Nigel
	Cunningham on Wed, 29 Oct 2008 08:29:59 +1100)
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

On Wed, 29 Oct 2008, Nigel Cunningham wrote:
> > However it does not fix the freezing of tasks which are waiting for
> > VFS locks (i.e. inode->i_mutex) held by the outstanding fuse requests.
> > This is the tricky part...
> 
> Convert them all to wait_event_freezeable.

You mean convert mutexes to event queues?  Not a very good idea.

I fear we are going down the same path as the last time.  I still
don't think rewriting the VFS is the right solution to the freezing
problem.  But hey, if you want, sumbit a patch or an RFD and lets see
what others think.

Miklos
