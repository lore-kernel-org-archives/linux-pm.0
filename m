From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: Re: [PATCH] Don't explode on swsusp failure to find
	swap
Date: Wed, 01 Jun 2005 14:52:39 +0800
Message-ID: <1117608759.10003.7.camel@linux-hp.sh.intel.com>
References: <1117583403.5826.72.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============20127873585459666=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117583403.5826.72.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pm <linux-pm@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============20127873585459666==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
On Wed, 2005-06-01 at 07:50 +0800, Benjamin Herrenschmidt wrote:
> On Wed, 2005-06-01 at 00:45 +1000, Benjamin Herrenschmidt wrote: 
> > On Tue, 2005-05-31 at 12:36 +0200, Pavel Machek wrote: 
> > > Hi! 
> > >  
> > > > If we specify a swap device for swsusp using resume= kernel
> argument and 
> > > > that device doesn't exist in the swap list, we end up calling 
> > > > swsusp_free() before we have allocated pagedir_save. That causes
> us to 
> > > > explode when trying to free it. 
> > > >  
> > > > Pavel, does that look right ? 
> > >  
> > > It looks like a workaround. We should not call swsusp_free in
> case 
> > > device does not exists. Quick look did not reveal where the bug
> comes 
> > > from, can you try to trace it? 
> > >                                                             Pavel 
> >  
> > Well, the bug comes from arch code calling swsusp_save() which
> fails, 
> > then we call swsusp_free()
> 
> More specifically, arch suspend calls swsusp_save().
> 
> It fails and returns the error to the arch asm code, which itself 
> returns it to it's caller swsusp_suspend(), which does that:
> 
>         if ((error = swsusp_arch_suspend())) 
>                 swsusp_free();
I encounter a similar issue, when swsusp_swap_check failed.
It seems the swsusp_free isn't required in the failure case,
suspend_prepare_image has correctly handled the failure case to me.
Other arch? I wonder why swsusp_free is called after device_power_down
failed as well. No pages are allocated before device_power_down.

Thanks,
Shaohua


--===============20127873585459666==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============20127873585459666==--
