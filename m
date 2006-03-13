From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: standby to disk transition
Date: Mon, 13 Mar 2006 23:06:58 +0100
Message-ID: <200603132306.58961.rjw@sisk.pl>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<20060313212856.GA16874@redhat.com>
	<20060313214652.GJ10348@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============62465890110318512=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060313214652.GJ10348@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: "Victor Porton, , , " <porton@ex-code.com>, Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============62465890110318512==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 13 March 2006 22:46, Pavel Machek wrote:
> On Po 13-03-06 16:28:56, Dave Jones wrote:
> > On Mon, Mar 13, 2006 at 10:24:20PM +0100, Pavel Machek wrote:
> > 
> >  > > if suspend-to-disk is fast enough, you could just *always* write
> >  > > to disk, even if we're doing S3.  If power runs out, you then have a
> >  > > valid resume image on-disk.  iirc, this is what Windows does.
> >  > 
> >  > Yep, I call that suspend-to-both. It is planned, but not really
> >  > trivial, and I'm a little busy. If someone wants to help....
> > 
> > I was thinking a few days ago. With your move of all this stuff to
> > userspace, if it was done in multiple stages, we could implement
> > a form of checkpointing this way.
> 
> It is possible...
> 
> > So instead of doing the 'suspend to disk/ram' after 'write out all pages',
> > we just continue.
> 
> ...but it is not _that_ simple. Preparing video for suspend-to-ram is
> rather nasty piece of code, and I'd rather not have it ran after
> system is frozen. Sequence needs to be something like:
> 
> prepare video for s2ram, vbetool save if neccessary
> FREEZE
> SNAPSHOT
> save image to disk
> run s2ram
> immediately after wakeup, s-t-disk signature needs to be removed,
> 	otherwise we risk two resumes from one suspend.
> 
> > Why is this useful ?  We've seen bugs reported that only ever bite customers
> > after they've run their workload for a month.  Now, if they had a means
> > of checkpointing, then when it crashes, they could capture the last image
> > that landed somewhere, and set that up for more tests/monitoring with kprobes etc
> > and reproduce those hard-to-reproduce bugs a lot faster.
> 
> Yes, you can do it, but:
> 
> 1) each SNAPSHOT takes few seconds, and it is rather disruptive
> action -- includes console switch. It needs half of memory free.
> 
> 2) it only snapshots memory. To be able to continue from saved
> snapshot, you'd need to save swap partition and all mounted
> filesystems.
> 
> Maybe you don't need 2) -- like kernel state is enough for you, or
> maybe you can do some magic with device mapper.

Still, if you make any changes to mounted filesystems after the snapshot has
been made, you can't use it any more, because it "remembers" the state of the
filesystems _without_ the changes.

To work around this you'll have to make sure all of the filesystems-related
information will be reread from the actual storage after the snapshot has
been "reloaded".

Greetings,
Rafael

--===============62465890110318512==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============62465890110318512==--
