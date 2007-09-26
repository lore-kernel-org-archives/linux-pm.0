From: jfannin@gmail.com (Joseph Fannin)
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Wed, 26 Sep 2007 16:30:36 -0400
Message-ID: <20070926203036.GF31759__32929.9354846173$1190841976$gmane$org@nineveh.local>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211225.25874.nigel@nigel.suspend2.net>
	<1190342757.21818.75.camel@caritas-dev.intel.com>
	<200709211259.00195.nigel@nigel.suspend2.net>
	<m1r6ksiq27.fsf@ebiederm.dsl.xmission.com>
	<20070921094512.GA20149@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070921094512.GA20149@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 21, 2007 at 11:45:12AM +0200, Pavel Machek wrote:
> Hi!
> > >
> > > Sounds doable, as long as you can cope with long command lines (which
> > > shouldn't be a biggie). (If you've got a swapfile or parts of a swap
> > > partition already in use, it can be quite fragmented).
> >
> > Hmm.  This is an interesting problem.  Sharing a swap file or a swap
> > partition with the actual swap of user space pages does seem to be
> > a limitation of this approach.
> >
> > Although the fact that it is simple to write to a separate file may
> > be a reasonable compensation.
>
> I'm not sure how you'd write it to a separate file. Notice that kjump
> kernel may not mount journalling filesystems, not even
> read-only. (Ext3 replays journal in that case). You could pass block
> numbers from the original kernel...

    The ext3 thing is a bug, the case for which I don't think has been
adequately explained to the ext[34] folks.  There should be at least a
no_replay mount flag available, or something.  It has ramifications
for more than just hibernation.

    And yeah, I'm gonna bring up the swap files thing again.  If you
can hibernate to a swap file, you can hibernate to a dedicated
hibernation file, and vice versa.

    If you can't hibernate to a swap file, then swap files are
effectively unsupported for any system you might want to hibernate.
<handwave> I wonder what embedded folks would think about that
</handwave>.

    But, in my ignorance, I'm not sure even fixing the ext3 bug will
guarantee you consistent metadata so that you can handle a
swap/hibernate file.  You can do a sync(), but how do you make that
not race against running processes without the freezer, or blkdev
snapshots?

    I guess uswsusp and the-patch-previously-known-as-suspend2 handle
this somehow, though.

   (It's that same ignorance that has me waiting for someone with
established credit with kernel people to make that argument for the
ext3 bug, so I can hang my own reasons for thinking that it's bad off
of theirs).

--
Joseph Fannin
jfannin@gmail.com
