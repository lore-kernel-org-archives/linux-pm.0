From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Wed, 29 Oct 2008 09:03:25 +1100
Message-ID: <1225231405.9661.18.camel__30946.235304191$1225231572$gmane$org@nigel-laptop>
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
	<E1KuwTn-0006EQ-8J@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1KuwTn-0006EQ-8J@pomaz-ex.szeredi.hu>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Tue, 2008-10-28 at 22:51 +0100, Miklos Szeredi wrote:
> On Wed, 29 Oct 2008, Nigel Cunningham wrote:
> > > However it does not fix the freezing of tasks which are waiting for
> > > VFS locks (i.e. inode->i_mutex) held by the outstanding fuse requests.
> > > This is the tricky part...
> > 
> > Convert them all to wait_event_freezeable.
> 
> You mean convert mutexes to event queues?  Not a very good idea.

No, I don't. Sorry. I was thinking you were referring to the wait_event
calls in the fuse request code. My bad.

Perhaps it's best to go back to my original position: hold new requests
and allow existing ones to complete. I'll look again at previous
messages to see why you thought that was problematic.

Regards,

Nigel
