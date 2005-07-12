From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: [PATCH][RFC] swsusp for OSK
Date: Tue, 12 Jul 2005 17:32:08 +0900 (JST)
Message-ID: <20050712.173208.41653102.kaminaga@sm.sony.co.jp>
References: <20050707.111613.107948201.kaminaga@sm.sony.co.jp>
	<20050709190837.GA1385@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============68543001275939597=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050709190837.GA1385@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@ucw.cz
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============68543001275939597==
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > Here is swsusp for ARM architecture. It is still target specific.
> > Anyone doing similar work?
> 
> What kind of hardware is that?

I used OMAP 5912 STARTER KIT (OSK) as target reference board.
http://www.celinuxforum.org/CelfPubWiki/OSK

> > Perhaps I have to turn off MMU while copying pagedir_nosave, and turn
> > on later?
> 
> If it is easy for you... that should solve it.

I'm now struggling to do it...

Regards,

HK.
--

--===============68543001275939597==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============68543001275939597==--
