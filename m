From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 14:54:48 +0800
Message-ID: <1205304888.10239.0.camel__48156.1944973238$1205305030$gmane$org@caritas-dev.intel.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
	<1205286326.29069.16.camel@caritas-dev.intel.com>
	<m1abl4znw6.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1abl4znw6.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2008-03-11 at 20:17 -0600, Eric W. Biederman wrote:
> "Huang, Ying" <ying.huang@intel.com> writes:
> 
> > Yes. The entry point should be saved in dump.elf itself, this can be
> > done via a user-space tool such as "makedumpfile". Because
> > "makedumpfile" is also used to exclude free pages from disk image, it
> > needs a communication method between two kernels (to get backup pages
> > map or something like that from kernel A). We have talked about this
> > before.
> >
> > - Your opinion is to communicate via the purgatory. (But I don't know
> > how to communicate between kernel A and purgatory).
> 
> How about the return address on the stack?
> 
> > - Eric's opinion is to communicate between the user space in kernel A
> > and user space in kernel B.
> 
> Purgatory is for all intents and purposes user space.  Because the
> return address falls on the trampoline page we won't know it's
> address before we call kexec.  But a return address and a stack
> on that page should be a perfectly good way to communicate.
> 
> > - My opinion is to communicate between two kernel directly.
> >
> > I think as a minimal infrastructure patch, we can communicate minimal
> > information between user space of two kernels. When we have consensus on
> > this topic, we can use makedumpfile for both excluding free pages and
> > saving the entry point. Now, we can save the entry point in a separate
> > file or I can write a simple tool to do this.
> 
> We need a fixed protocol so we do not make assumptions about how things
> will be implemented, allowing kernels to diverge and kinds of other
> good things.
> 
> For communicating extra information from the kernel being shut down
> we have elf notes.
> 
> Direct kernel to kernel communication is forbidden.  We must have
> a well defined protocol.  Allowing the implementations to change
> at their different speeds, and still work together.

This sounds reasonable. But after some initial trying I found it is
fairly difficult for me to define a communication protocol to be back
compatible with original kexec/kdump, doing work in user space as far as
possible, dealing with some special scenario (such as: A kexec B, then B
kexec C). So I will try my best to work on this, and propose a
communication protocol combining the proposals from you and Vivek in
several days.

> >> May be we can have a separate load flag (--load-resume-image) to mark
> >> that we are resuming an hibernated image and kexec does not have to
> >> prepare commandline, does not have to prepare zero page/setup page etc.
> >
> > There is already similar flag in original kexec-tools implementation:
> > "--args-none". If it is specified, kexec-tools does not prepare command
> > line and zero page/setup page etc. I think we can just re-use this flag.
> > And If it is desired an alias is good for me too.
> 
> My gut feel is we look at the image and detect what kind it is, and simply
> not enable image processing after we have read the note that says it
> is a resumable core or whatever.

Yes. This sounds good.

Best Regards,
Huang Ying
