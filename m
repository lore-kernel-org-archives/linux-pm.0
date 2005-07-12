From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][RFC] swsusp for OSK
Date: Tue, 12 Jul 2005 11:20:27 +0200
Message-ID: <20050712092027.GK1854@elf.ucw.cz>
References: <20050707.111613.107948201.kaminaga@sm.sony.co.jp>
	<20050709190837.GA1385@elf.ucw.cz>
	<20050712.173208.41653102.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============64128206456654313=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050712.173208.41653102.kaminaga@sm.sony.co.jp>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============64128206456654313==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > Here is swsusp for ARM architecture. It is still target specific.
> > > Anyone doing similar work?
> > 
> > What kind of hardware is that?
> 
> I used OMAP 5912 STARTER KIT (OSK) as target reference board.
> http://www.celinuxforum.org/CelfPubWiki/OSK

I just wondered what kind of hardware has both ARM cpu and wants to
suspend-to-disk. Obviously you can do this with any ARM hardware, but
I wanted to know what kind of machine it is actually usefull at.

Probably not PDA-style machine, right? And users would not tolerate
long startup on disk-based mp3-player, right? Maybe big PDA with
notebook-like features? [Or just tell me that you can not say ;-)].

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.

--===============64128206456654313==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============64128206456654313==--
