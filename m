From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] userland swsusp
Date: Wed, 16 Nov 2005 23:50:47 +0100
Message-ID: <20051116225047.GJ12505@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	<20051116164429.GA5630@kroah.com>
	<1132172445.25230.73.camel@localhost>
	<20051116220500.GF12505@elf.ucw.cz>
	<1132175574.25230.111.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============084785951108535595=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1132175574.25230.111.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Dave Jones <DaveJ@redhat.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============084785951108535595==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > I've also split the one patch that most people see into what is
> > > currently about 225 smaller patches, each adding only one small part, am
> > > writing descriptions for them all and am preparing to build a git tree
> > > from it.
> > 
> > I'm not sure that gets suspend2 any closer to merging. 225 small
> > patches is still awful lot of code :-(. Now... if something can be
> > done in userspace, it probably should. And I'm trying to show that
> > suspend2 functionality can indeed be done in userspace.
> > 
> > So... to get 225 patches in, you'll need to explain that
> > userland-swsusp can't work. If you can do that, please be nice and do
> > it soon, so that I don't waste too much time on userland-swsusp.
> 
> I thought Dave already did that.

No, I do not think so. He did not like the user<->kernel interface;
but that can be changed (and Rafael has plans to do that). I think we
can present nicer interface to userland without much code. Or maybe
not; but we can certainly limit /dev/kmem for suspend only -- and that
should make it acceptable security-wise.

                                                                Pavel

-- 
Thanks, Sharp!

--===============084785951108535595==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============084785951108535595==--
