From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Freezer: Don't count threads waiting
	for	frozen	filesystems.
Date: Wed, 29 Oct 2008 10:17:40 +1100
Message-ID: <1225235860.9661.42.camel__28457.7603488744$1225236434$gmane$org@nigel-laptop>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1Kuxk4-0006NT-Ie@pomaz-ex.szeredi.hu>
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

On Wed, 2008-10-29 at 00:12 +0100, Miklos Szeredi wrote:
> On Wed, 29 Oct 2008, Nigel Cunningham wrote:
> > > However it does not fix the freezing of tasks which are waiting for
> > > VFS locks (i.e. inode->i_mutex) held by the outstanding fuse requests.
> > > This is the tricky part...
> > 
> > Okay. Looking back on our conversation brought me back to this message,
> > which I think needs another reply.
> > 
> > If we take the strategy of holding new requests and allowing existing
> > ones to complete, then am I right in thinking that we only need to worry
> > about where inode->i_mutex is taken in fs/fuse/file.c (I don't see it
> > taken in other fs/fuse/*.c files).
> 
> Nope, i_mutex is usually taken by the VFS not the filesystem.  That
> means that the filesystem is called with the mutex already held.  Try
> "grep i_mutex fs/*.c".  There's also sb->s_vfs_rename_mutex, for all
> the gory details see Documentation/filesystems/Locking.
> 
> So it's not just having to fix fuse, it's having to "fix" the VFS as
> well.

Remember, though, that we're only freezing fuse at the moment, and
strictly one filesystem at a time. We can thus happily wait for the
i_mutex taken by some other process to be released.

Regards,

Nigel
