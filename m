From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for frozen
 filesystems.
Date: Thu, 30 Oct 2008 00:43:09 +0100
Message-ID: <E1KvKgv-0000bf-RS__26009.23397481$1225324096$gmane$org@pomaz-ex.szeredi.hu>
References: <Pine.LNX.4.44L0.0810291627040.3986-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <Pine.LNX.4.44L0.0810291627040.3986-100000@iolanthe.rowland.org>
	(message from Alan Stern on Wed, 29 Oct 2008 16:37:30 -0400 (EDT))
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu
Cc: ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, miklos@szeredi.hu
List-Id: linux-pm@vger.kernel.org

On Wed, 29 Oct 2008, Alan Stern wrote:
> I discussed this last summer with Rafael.  It's a lot harder than it 
> looks, for all sorts of reasons.  For example, what about user tasks 
> that have access to memory-mapped I/O regions?

What about them?  Freezing doesn't seem to help with that.

> > c) is slightly tricky, but could be done for example by setting a flag
> > on open: FMODE_NO_SUSPEND_DISABLE (better name required), saying that
> > implementation is responsible for getting the suspend disable magic
> > right.
> > 
> > For starters this flag could be set for all non-device opens (maybe all
> > non-char-dev opens?), solving the fuse vs. freezer issues without any
> > complicated trickery.
> 
> I don't know.  There are other interfaces too, like sysfs attributes, 
> that would have to be handled specially.  On the whole, the freezer 
> seems much, much simpler.

OK, then non-device files on "regular" filesystems.

> Regarding fuse, something like Nigel's scheme for preventing new 
> requests and then waiting for old requests to complete might work out.  
> Especially if you combine it with a strategy for making the freezer 
> back and retry after a delay when something goes wrong.

I don't think it will work out, because to be able to do this some
ordering between freezing the filesystems must be done.  But this is
basically impossible, for all the same reasons it's impossible to
order the freezing of userspace tasks.

Also this is not just a fuse issue: we have userspace network devices,
we have userspace USB drivers, etc, affected by this problem.

If there _is_ a solution with the freezer that does solve all of this,
I haven't yet heard it.  But yeah, in the end the simpler solution
should win.

Miklos
