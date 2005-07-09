From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][RFC] swsusp for OSK
Date: Sat, 9 Jul 2005 21:08:37 +0200
Message-ID: <20050709190837.GA1385@elf.ucw.cz>
References: <20050707.111613.107948201.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============070264230655534998=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050707.111613.107948201.kaminaga@sm.sony.co.jp>
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

--===============070264230655534998==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Here is swsusp for ARM architecture. It is still target specific.
> Anyone doing similar work?

What kind of hardware is that?


> Perhaps I have to turn off MMU while copying pagedir_nosave, and turn
> on later?

If it is easy for you... that should solve it.


								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.

--===============070264230655534998==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============070264230655534998==--
