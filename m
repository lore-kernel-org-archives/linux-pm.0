From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] userland swsusp
Date: Fri, 18 Nov 2005 19:36:29 +0000
Message-ID: <1132342590.25914.86.camel@localhost.localdomain>
References: <20051115212942.GA9828@elf.ucw.cz>
	<20051115222549.GF17023@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============97897262347660385=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051115222549.GF17023@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============97897262347660385==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Maw, 2005-11-15 at 17:25 -0500, Dave Jones wrote:
> Just for info: If this goes in, Red Hat/Fedora kernels will fork
> swsusp development, as this method just will not work there.
> (We have a restricted /dev/mem that prevents writes to arbitary
>  memory regions, as part of a patchset to prevent rootkits)

Perhaps it is trying to tell you that you should be using SELinux rules
not kernel hacks for this purpose ?

> Even it were not for this, the whole idea seems misconcieved to me
> anyway.

I'm sceptical too but several Win9x BIOS vendor suspend paths were
implemented in roughly this way. I don't however see how you can
co-ordinate the freeze with outstanding O_DIRECT DMA to user pages for
one item.



--===============97897262347660385==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============97897262347660385==--
