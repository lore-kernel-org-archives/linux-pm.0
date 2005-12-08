From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT] suspend from userland
Date: Fri, 9 Dec 2005 00:04:07 +0100
Message-ID: <20051208230407.GB3970@elf.ucw.cz>
References: <20051207011753.GA2526@elf.ucw.cz> <200512082352.07659.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45352376763344338=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200512082352.07659.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============45352376763344338==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > I'd like to get some testing and comments on this. I know that
> > userland part is messy and will not work on x86-64 etc, and I should
> > obviously remove some extra printk's... but otherwise it should be okay.
> > 
> > Testing would be nice, too, but be a bit careful. It should not be
> > more dangerous than /sys/power/resume, but... If you suspect something
> > unusual, be sure to force fsck.
> 
> Could we please postpone it for some time?

Well, it is probably not going into -mm before your changes are in
mainline. That means 2.6.17 earliest.

> First, the patch doesn't apply to the current -mm and the userland part is
> incompatible with the code there to the extent of a serious breakage
> (let alone the x86-64 issue).

Of course I'm going to fix up breakage before the merge. At least all
the kernel parts and enough userland to test that it still works.

> Second, if I had some time to get my solution ready, we could compare the
> alternatives instead of just discussing one of them.

Well, I'm trying to gently push you. I'd like to get some solution in
1-2 months timeframe, so that work on userland parts can start.
									Pavel
-- 
Thanks, Sharp!

--===============45352376763344338==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============45352376763344338==--
