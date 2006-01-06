From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 0/5] swsusp: userland interface
	(rev. 2)
Date: Fri, 6 Jan 2006 23:44:30 +0100
Message-ID: <20060106224430.GC12428@elf.ucw.cz>
References: <200601042340.42118.rjw@sisk.pl> <20060105233026.GA3339@elf.ucw.cz>
	<200601062217.09012.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============29761830072264939=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601062217.09012.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============29761830072264939==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > This is the second "preview release" of the swsusp userland interface patches.
> > > They have changed quite a bit since the previous post, as I tried to make the
> > > interface more robust against some potential user space bugs (or outright
> > > attempts to abuse it).
> > 
> > Works for me, thanks.
> > 
> > Perhaps it is time to get 1/4 and 3/4 into -mm? You get my signed-off
> > on them...
> 
> OK, I'll prepare them in a while.

Thanks.

> > 2/4 needs to allocate official major/minor. 1/13 would be nice :-).
> 
> Well, you said you liked the patch with a misc device (ie. major = 10).
> 
> Actually the code is somewhat simpler in that case so I'd prefer it.
> 
> Now, if we used a misc device, which minor would be suitable?  231?

If code is simpler, lets stick with misc. You have to obtain minor by
mailing device@lanana.org, see Doc*/devices.txt.

> > 4/4... I'm not sure. It would be nice to make swsusp.c disappear. It
> > is really wrong name. That means we need to only delete from it for a
> > while...
> 
> Anyway I think it would be nice to move the code that does not really belong
> to the snapshot and is used by both the user interface and disk.c/swap.c to
> a separate file.  I have no preference as far as the name of the file is
> concerned, though.

Ok, lets keep it as it is. We can always rename file in future. [I
don't quite understand your reasons for movement, through. Highmem is
part of snapshot we need to make; it is saved in a very different way
than rest of memory, but that is implementation detail...]


									Pavel
-- 
Thanks, Sharp!

--===============29761830072264939==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============29761830072264939==--
