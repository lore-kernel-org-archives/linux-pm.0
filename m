From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Mon, 27 Oct 2008 13:38:58 +0100
Message-ID: <E1KuRN4-0002gS-Hq__33656.5316458747$1225119288$gmane$org@pomaz-ex.szeredi.hu>
References: <1224886068.6478.21.camel@nigel-laptop>
	<E1KuQ1J-0002Vw-9Q@pomaz-ex.szeredi.hu>
	<1225106427.26724.5.camel@nigel-laptop>
	<200810271237.40049.rjw@sisk.pl>
	<1225107607.26724.9.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1225107607.26724.9.camel@nigel-laptop> (message from Nigel
	Cunningham on Mon, 27 Oct 2008 22:40:07 +1100)
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

On Mon, 27 Oct 2008, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2008-10-27 at 12:37 +0100, Rafael J. Wysocki wrote:
> > Well, I guess it's better if you post the entire thing so that we can see
> > what the role of the $subject patch is in it, even if this patch finally gets
> > merged separately.
> 
> Ah.. that makes me see how vfs_check_frozen was getting triggered...
> (fs/namei.c, below).

Nigel, thanks for the patch, it makes thinks a lot clearer.

>From a quick look through the patch it seems to solve a bunch of cases
where new fuse requests during the freezing could cause problems.  But
it doesn't do anything with requests that are already under way when
the freezing starts, which would still result in all the same
problems.

Take this scenario:

 1) process A does rename("/mnt/fuse/a", "/mnt/fuse/b")
 2) request goes to process B serving the fuse filesystem
 3) filesystems are frozen, no new fuse requests
 4) processes are frozen, let's say B first, then A
 5) freezing A will fail, since it's still waiting for the request to finish

Several solutions have been posted, none of which really solve the problem:

 a) Let's tag fuse server processes and freeze them later.  This is
 basically impossible, because many processes could be interoperating
 and there's no way to know which is depending on which (example:
 sshfs uses ssh for communication, which possibly relies on openvpn
 process for packet transmission).

 b) While waiting for replies to fuse request, allow process to
 freeze.  Does not fully solve the problem, as VFS might be holding
 locks, and other processes waiting for those locks will not be
 freezable.

Miklos
