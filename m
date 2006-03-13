From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: standby to disk transition
Date: Mon, 13 Mar 2006 23:42:37 +0100
Message-ID: <200603132342.37691.rjw@sisk.pl>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<200603140759.15754.nigel@suspend2.net>
	<20060313220811.GL10348@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============51924506085509847=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060313220811.GL10348@elf.ucw.cz>
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
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-pm@osdl.org, "Victor Porton, ,
	, " <porton@ex-code.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============51924506085509847==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 13 March 2006 23:08, Pavel Machek wrote:
> > >  > Yep, I call that suspend-to-both. It is planned, but not really
> > >  > trivial, and I'm a little busy. If someone wants to help....
> > >
> > > I was thinking a few days ago. With your move of all this stuff to
> > > userspace, if it was done in multiple stages, we could implement
> > > a form of checkpointing this way.
> > >
> > > So instead of doing the 'suspend to disk/ram' after 'write out all pages',
> > > we just continue.
> > >
> > > Why is this useful ?  We've seen bugs reported that only ever bite
> > > customers after they've run their workload for a month.  Now, if they had a
> > > means of checkpointing, then when it crashes, they could capture the last
> > > image that landed somewhere, and set that up for more tests/monitoring with
> > > kprobes etc and reproduce those hard-to-reproduce bugs a lot faster.
> > 
> > I've been asked about this from time to time too. Apart from the issues Pavel 
> > has already mentioned, the big problem in my mind was figuring out what to do 
> > about disk storage. As the algorithm stands at the moment, the image includes 
> > information about the state of mounted filesystems. We'd need to somehow get 
> > rid of or be able to ignore that. Any suggestions?
> 
> Well, copying all the filesystems would work, as would having no
> filesystems at all :-) [ramdisk case]. And perhaps practical
> equivalent of "copy all filesystems" can be done with device mapper.
> 
> [Of course, you'd have to copy all the filesystems back before doing
> resume].

If we had anything like fs suspend/resume, we could handle such things.
We could also handle the "USB device mounted before suspend" problem
(I think it's related).

Greetings,
Rafael

--===============51924506085509847==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============51924506085509847==--
