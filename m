From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: [PATCH][RFC] swsusp for OSK
Date: Tue, 12 Jul 2005 17:27:16 +0900 (JST)
Message-ID: <20050712.172716.74733957.kaminaga@sm.sony.co.jp>
References: <20050707.111613.107948201.kaminaga@sm.sony.co.jp>
	<1120714200.4860.861.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============22108304743982976=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1120714200.4860.861.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ncunningham@cyclades.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============22108304743982976==
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > Perhaps I have to turn off MMU while copying pagedir_nosave, and turn
> > on later?
> 
> That sounds right.

I tried turning off MMU when copying pagedir_nosave, but OSK target
board hanged up just after MMU was turned off.

What I did was:

* invalidate cache
* invalidate write buffer
* invalidate TLB
* disable cache
* disable MMU

I have to investigate more on how to turn off MMU on ARM...
Below are actual insn:

        mcr     p15, 0, r0, c7, c7, 0   @ invalidate cache
        mcr     p15, 0, r0, c7, c10, 4  @ drain write buffer
        mcr     p15, 0, r0, c8, c7, 0   @ invalidate TLB
        mrc     p15, 0, r0, c1, c0, 0   @ get control register
        bic     r1, r0, #0x0000100d     @ disable cache and MMU
        mcr     p15, 0, r1, c1, c0, 0   @ set control register
	nop	<--- place where hanged up

Besides that, I must convert mem from virt to phys if I go with MMU off.
In kernel area, VIRT_TO_PHYS could be like this:

#define VIRT_TO_PHYS(x)        \
        sub     x, x, # PAGE_OFFSET + PHYS_OFFSET

but could this also be used against hibernated image?

# sorry for late reply.

Regards,

HK.
--

--===============22108304743982976==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============22108304743982976==--
