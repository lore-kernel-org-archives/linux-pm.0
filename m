From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: standby to disk transition
Date: Mon, 13 Mar 2006 23:08:11 +0100
Message-ID: <20060313220811.GL10348@elf.ucw.cz>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<20060313212420.GG10348@elf.ucw.cz>
	<20060313212856.GA16874@redhat.com>
	<200603140759.15754.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============15546433060079612=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603140759.15754.nigel@suspend2.net>
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
Cc: "Victor Porton, , , " <porton@ex-code.com>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============15546433060079612==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> >  > Yep, I call that suspend-to-both. It is planned, but not really
> >  > trivial, and I'm a little busy. If someone wants to help....
> >
> > I was thinking a few days ago. With your move of all this stuff to
> > userspace, if it was done in multiple stages, we could implement
> > a form of checkpointing this way.
> >
> > So instead of doing the 'suspend to disk/ram' after 'write out all pages',
> > we just continue.
> >
> > Why is this useful ?  We've seen bugs reported that only ever bite
> > customers after they've run their workload for a month.  Now, if they had a
> > means of checkpointing, then when it crashes, they could capture the last
> > image that landed somewhere, and set that up for more tests/monitoring with
> > kprobes etc and reproduce those hard-to-reproduce bugs a lot faster.
> 
> I've been asked about this from time to time too. Apart from the issues Pavel 
> has already mentioned, the big problem in my mind was figuring out what to do 
> about disk storage. As the algorithm stands at the moment, the image includes 
> information about the state of mounted filesystems. We'd need to somehow get 
> rid of or be able to ignore that. Any suggestions?

Well, copying all the filesystems would work, as would having no
filesystems at all :-) [ramdisk case]. And perhaps practical
equivalent of "copy all filesystems" can be done with device mapper.

[Of course, you'd have to copy all the filesystems back before doing
resume].

							Pavel
-- 
116:

--===============15546433060079612==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============15546433060079612==--
