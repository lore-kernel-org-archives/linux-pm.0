From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Don't explode on swsusp failure to find swap
Date: Wed, 01 Jun 2005 09:50:03 +1000
Message-ID: <1117583403.5826.72.camel@gaston>
References: <1117523585.5826.18.camel@gaston>
	<20050531103623.GB1848@elf.ucw.cz>  <1117550706.5826.43.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============62503340936315754=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117550706.5826.43.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============62503340936315754==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-06-01 at 00:45 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2005-05-31 at 12:36 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > If we specify a swap device for swsusp using resume= kernel argument and
> > > that device doesn't exist in the swap list, we end up calling
> > > swsusp_free() before we have allocated pagedir_save. That causes us to
> > > explode when trying to free it.
> > > 
> > > Pavel, does that look right ?
> > 
> > It looks like a workaround. We should not call swsusp_free in case
> > device does not exists. Quick look did not reveal where the bug comes
> > from, can you try to trace it?
> > 								Pavel
> 
> Well, the bug comes from arch code calling swsusp_save() which fails,
> then we call swsusp_free()

More specifically, arch suspend calls swsusp_save().

It fails and returns the error to the arch asm code, which itself
returns it to it's caller swsusp_suspend(), which does that:

 	if ((error = swsusp_arch_suspend()))
		swsusp_free();

Ben.



--===============62503340936315754==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============62503340936315754==--
