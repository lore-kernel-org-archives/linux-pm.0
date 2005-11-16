From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] userland swsusp
Date: Wed, 16 Nov 2005 09:56:05 +0100
Message-ID: <20051116085605.GE10143@elf.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz>
	<20051115222549.GF17023@redhat.com>
	<20051115233201.GA10143@elf.ucw.cz>
	<20051115234007.GO17023@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============63057564249094455=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051115234007.GO17023@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============63057564249094455==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

>  > > Even it were not for this, the whole idea seems misconcieved to me
>  > > anyway.
>  > 
>  > ...but how do you provide nice, graphical progress bar for swsusp
>  > without this? People want that, and "esc to abort", compression,
>  > encryption. Too much to be done in kernel space, IMNSHO.
>  
> I'll take "rootkit doesnt work" over "bells and whistles".

It moves bunch of code from kernelspace to userspace. You don't have
to add bells and whistles at the same time. That's normally called
good thing. If Fedora has special needs, fine.
								Pavel
-- 
Thanks, Sharp!

--===============63057564249094455==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============63057564249094455==--
