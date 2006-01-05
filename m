From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 2/5] swsusp: userland interface
	(rev. 2)
Date: Thu, 5 Jan 2006 01:55:59 +0100
Message-ID: <20060105005559.GC1751@elf.ucw.cz>
References: <200601042340.42118.rjw@sisk.pl> <200601042351.58667.rjw@sisk.pl>
	<20060104234918.GA15983@kroah.com>
	<20060105001837.GA1751@elf.ucw.cz>
	<20060105002619.GA16714@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73857485842785908=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060105002619.GA16714@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============73857485842785908==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > Unless you want to turn these into syscalls :)
> > 
> > Well, I think we simply want to get static major/minor allocated for
> > this device. It really uses read/write, IIRC, so no, I do not think we
> > want to make it a syscall.
> 
> Ok, then I'd recommend using the misc device, dynamic for now, and
> reserve one when you get a bit closer to merging into mainline.

Actually, misc major (character, major 10) seems to be okay,
too. There's stuff like /dev/fuse there, already. But it feels little
crowded there, and /dev/snapshot seems to fit between memory devices
nicely...
								Pavel
-- 
Thanks, Sharp!

--===============73857485842785908==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73857485842785908==--
