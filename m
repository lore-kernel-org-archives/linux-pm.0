From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] userland swsusp
Date: Wed, 23 Nov 2005 13:02:48 +0100
Message-ID: <20051123120248.GB18403@elf.ucw.cz>
References: <20051115233201.GA10143@elf.ucw.cz>
	<1132115730.2499.37.camel@localhost>
	<20051116061459.GA31181@kroah.com>
	<1132120845.25230.13.camel@localhost>
	<20051116165023.GB5630@kroah.com>
	<1132171051.25230.53.camel@localhost>
	<20051116213517.GD12505@elf.ucw.cz>
	<1132175248.25230.104.camel@localhost>
	<20051116224728.GI12505@elf.ucw.cz> <4384417B.9040201@colitti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============22689204285473519=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <4384417B.9040201@colitti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Lorenzo Colitti <lorenzo@colitti.com>
Cc: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>, Nigel Cunningham <ncunningham@cyclades.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============22689204285473519==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On St 23-11-05 11:16:27, Lorenzo Colitti wrote:
> Pavel Machek wrote:
> >Yes, hopefully users will not notice.
> 
> ? So the idea is to merge inferior code and "hope users won't notice"?
> 
> Users  might not notice that half their memory is gone, but they *will* 
> notice that their system is dog slow when it resumes because all their 
> caches are gone and a most of their stuff is swapped out.
> 
> Non-responsive system on resume is one of the main reasons that swsusp2 
> is much better than swsusp1, and yes, users *do* notice (I was one of 
> them, as I pointed out a while back). Yes, 50% is better than nothing, 
> but it's still a pretty poor show.

Did you actually benchmark it?

> Seen from the perspective of a user, the situation is simple: suspend2 
> works, it's fast, and it's rock-solid. Just use it.

About as helpful as "Windows XP works, it's fast, and it's
rock-solid".

							Pavel
-- 
Thanks, Sharp!

--===============22689204285473519==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============22689204285473519==--
