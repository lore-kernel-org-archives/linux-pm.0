From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] Don't explode on swsusp failure to find
	swap
Date: Wed, 1 Jun 2005 11:29:06 +0200
Message-ID: <20050601092906.GD6693@elf.ucw.cz>
References: <1117583403.5826.72.camel@gaston>
	<1117608759.10003.7.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48742895871980929=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117608759.10003.7.camel@linux-hp.sh.intel.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============48742895871980929==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > More specifically, arch suspend calls swsusp_save().
> > 
> > It fails and returns the error to the arch asm code, which itself 
> > returns it to it's caller swsusp_suspend(), which does that:
> > 
> >         if ((error = swsusp_arch_suspend())) 
> >                 swsusp_free();
> I encounter a similar issue, when swsusp_swap_check failed.
> It seems the swsusp_free isn't required in the failure case,
> suspend_prepare_image has correctly handled the failure case to me.
> Other arch? I wonder why swsusp_free is called after device_power_down
> failed as well. No pages are allocated before device_power_down.

Agreed, its wrong. Also there's no reason for the swap check to be
called (even indirectly) from arch code...
								Pavel

--===============48742895871980929==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48742895871980929==--
