From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: standby to disk transition
Date: Tue, 14 Mar 2006 19:12:44 +0100
Message-ID: <200603141912.45350.rjw@sisk.pl>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<200603140036.17051.rjw@sisk.pl>
	<200603141019.02907.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============97127971998446005=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603141019.02907.nigel@suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-pm@osdl.org, linux-pm@lists.osdl.org, "Victor Porton, , ,
	" <porton@ex-code.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============97127971998446005==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 14 March 2006 01:18, Nigel Cunningham wrote:
> On Tuesday 14 March 2006 09:36, Rafael J. Wysocki wrote:
> > On Tuesday 14 March 2006 00:11, Nigel Cunningham wrote:
> > > On Tuesday 14 March 2006 08:42, Rafael J. Wysocki wrote:
> > > > On Monday 13 March 2006 23:08, Pavel Machek wrote:
> > > > > > >  > Yep, I call that suspend-to-both. It is planned, but not
> > > > > > >  > really trivial, and I'm a little busy. If someone wants to
> > > > > > >  > help....
> > > > > > >
> > > > > > > I was thinking a few days ago. With your move of all this stuff
> > > > > > > to userspace, if it was done in multiple stages, we could
> > > > > > > implement a form of checkpointing this way.
> > > > > > >
> > > > > > > So instead of doing the 'suspend to disk/ram' after 'write out
> > > > > > > all pages', we just continue.
> > > > > > >
> > > > > > > Why is this useful ?  We've seen bugs reported that only ever
> > > > > > > bite customers after they've run their workload for a month. 
> > > > > > > Now, if they had a means of checkpointing, then when it crashes,
> > > > > > > they could capture the last image that landed somewhere, and set
> > > > > > > that up for more tests/monitoring with kprobes etc and reproduce
> > > > > > > those hard-to-reproduce bugs a lot faster.
> > > > > >
> > > > > > I've been asked about this from time to time too. Apart from the
> > > > > > issues Pavel has already mentioned, the big problem in my mind was
> > > > > > figuring out what to do about disk storage. As the algorithm stands
> > > > > > at the moment, the image includes information about the state of
> > > > > > mounted filesystems. We'd need to somehow get rid of or be able to
> > > > > > ignore that. Any suggestions?
> > > > >
> > > > > Well, copying all the filesystems would work, as would having no
> > > > > filesystems at all :-) [ramdisk case]. And perhaps practical
> > > > > equivalent of "copy all filesystems" can be done with device mapper.
> > > > >
> > > > > [Of course, you'd have to copy all the filesystems back before doing
> > > > > resume].
> > > >
> > > > If we had anything like fs suspend/resume, we could handle such things.
> > > > We could also handle the "USB device mounted before suspend" problem
> > > > (I think it's related).
> > >
> > > Well, we have bdev freezing, which I guess is what is used for fixing up
> > > raid mirrors (but don't know for certain). I use it in refrigerating to
> > > get XFS to really stop activity. I don't think it helps in this case
> > > though:
> >
> > I don't think so too.
> >
> > > We need to be able to rollback the state of the filesystem in memory and
> > > on disk to the point where the last checkpoint was made. Memory would be
> > > straight forward if we want to do it dumbly and slowly - just reload the
> > > whole check pointed image. If we want to be more efficient, we'd want to
> > > just load the pages that had changed (Mark on (first) write?). But
> > > filesystems seem to be a whole different story. Do any of the commonly
> > > used fses have support for checkpointing and rollback back at the moment?
> >
> > I'm not sure if we need a rollback as such.  What we need is to make sure
> > the filesystems state will be consistent before as well as after we have
> > "reloaded" the snapshot.
> 
> Rereading what I think was Dave's original comment above (bug reports that 
> only bite customers...), I think the requirement is to be able to rollback 
> the entire system to the checkpoint - not merely ensure it's consistent, but 
> ensure it's the same so that (all other things being equal), the bug could be 
> reproduced with the extra instrumentation in place. Having a filesystem that 
> was consistent but (say) discarding the inodes and dentries in memory at the 
> time of the checkpoint might be throwing away the very data required to 
> reproduce the bug.

Right, but it still would be useful for tracing bugs that are not related to
filesystems, I think.  Moreover, it would also be useful for other purposes
(the USB devices problem, retrying to resume after fixing some hardware).

Greetings,
Rafael

--===============97127971998446005==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============97127971998446005==--
