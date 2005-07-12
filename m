From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: [PATCH][RFC] swsusp for OSK
Date: Tue, 12 Jul 2005 18:04:41 +0900 (JST)
Message-ID: <20050712.180441.104053811.kaminaga@sm.sony.co.jp>
References: <20050707.111613.107948201.kaminaga@sm.sony.co.jp>
	<20050709190837.GA1385@elf.ucw.cz>
	<20050712.173208.41653102.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7693431159451265=="
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
To: pavel@ucw.cz
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============7693431159451265==
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > Perhaps I have to turn off MMU while copying pagedir_nosave, and turn
> > on later?
> 
> If it is easy for you... that should solve it.

In kernel/power/swsusp.c, comment says
...
   Warning: this is even more evil than it seems. Pagedirs this file
   talks about are completely different from page directories used by
   MMU hardware.
...

If it is so, then turning MMU off doesn't sound like solving the
problem... true?

I'll look more closely on page table between hibernate & wakeup.

Regards,

HK.
--

--===============7693431159451265==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============7693431159451265==--
