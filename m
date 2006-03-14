From: Pavel Machek <pavel@suse.cz>
Subject: Re: Re: standby to disk transition
Date: Tue, 14 Mar 2006 21:29:36 +0100
Message-ID: <20060314202936.GF1782@elf.ucw.cz>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<20060313220811.GL10348@elf.ucw.cz>
	<200603132342.37691.rjw@sisk.pl>
	<200603140912.01502.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============78308590162984293=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603140912.01502.nigel@suspend2.net>
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
	" <porton@ex-code.com>
List-Id: linux-pm@vger.kernel.org

--===============78308590162984293==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > Well, copying all the filesystems would work, as would having no
> > > filesystems at all :-) [ramdisk case]. And perhaps practical
> > > equivalent of "copy all filesystems" can be done with device mapper.
> > >
> > > [Of course, you'd have to copy all the filesystems back before doing
> > > resume].
> >
> > If we had anything like fs suspend/resume, we could handle such things.
> > We could also handle the "USB device mounted before suspend" problem
> > (I think it's related).
> 
> Well, we have bdev freezing, which I guess is what is used for fixing up raid 
> mirrors (but don't know for certain). I use it in refrigerating to get XFS to 
> really stop activity. I don't think it helps in this case though:
> 
> We need to be able to rollback the state of the filesystem in memory and on 
> disk to the point where the last checkpoint was made. Memory would be 
> straight forward if we want to do it dumbly and slowly - just reload the 
> whole check pointed image. If we want to be more efficient, we'd want to just 
> load the pages that had changed (Mark on (first) write?). But filesystems 
> seem to be a whole different story. Do any of the commonly used fses have 
> support for checkpointing and rollback back at the moment?

AFAIK, such support exists at "device mapper" level.
									Pavel
-- 
179:        alg.Mode = CipherMode.CBC;

--===============78308590162984293==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============78308590162984293==--
