From: Dave Jones <davej@redhat.com>
Subject: Re: Re: standby to disk transition
Date: Mon, 13 Mar 2006 16:28:56 -0500
Message-ID: <20060313212856.GA16874@redhat.com>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<20060313083037.GA3495@elf.ucw.cz>
	<20060313084811.GC20569@neo.rr.com>
	<20060313085042.GB3495@elf.ucw.cz>
	<20060313090759.GA20930@neo.rr.com>
	<20060313091332.GC3495@elf.ucw.cz>
	<20060313183318.GB26234@redhat.com>
	<20060313212420.GG10348@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============35869018994550617=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060313212420.GG10348@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>, "Victor Porton, , , " <porton@ex-code.com>
List-Id: linux-pm@vger.kernel.org

--===============35869018994550617==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 13, 2006 at 10:24:20PM +0100, Pavel Machek wrote:

 > > if suspend-to-disk is fast enough, you could just *always* write
 > > to disk, even if we're doing S3.  If power runs out, you then have a
 > > valid resume image on-disk.  iirc, this is what Windows does.
 > 
 > Yep, I call that suspend-to-both. It is planned, but not really
 > trivial, and I'm a little busy. If someone wants to help....

I was thinking a few days ago. With your move of all this stuff to
userspace, if it was done in multiple stages, we could implement
a form of checkpointing this way.

So instead of doing the 'suspend to disk/ram' after 'write out all pages',
we just continue.

Why is this useful ?  We've seen bugs reported that only ever bite customers
after they've run their workload for a month.  Now, if they had a means
of checkpointing, then when it crashes, they could capture the last image
that landed somewhere, and set that up for more tests/monitoring with kprobes etc
and reproduce those hard-to-reproduce bugs a lot faster.

		Dave

-- 
http://www.codemonkey.org.uk

--===============35869018994550617==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============35869018994550617==--
