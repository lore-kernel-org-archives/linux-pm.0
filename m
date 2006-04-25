From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 16:55:01 -0700
Message-ID: <200604251655.01988.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200604260006.33856.rjw@sisk.pl>
	<200604260818.20484.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============99067583876390342=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604260818.20484.nigel@suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============99067583876390342==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 25 April 2006 3:18 pm, Nigel Cunningham wrote:

> I saw the 2 suspends, 1 resume comment in another part of the thread, but 
> don't believe a driver would be able to detect that 2 suspends and 1 resume 
> call had been made - at least not without some non volatile ram.

The extra suspend is just IMO a symptom of sloppiness, like a "here may be bugs"
sign.  Not necessarily an issue in its own right.

In fact if you count carefully, it's three suspends and one resume:  one
suspend before calling swsusp_resume, one inside swsusp_resume -- replaced
by my patch -- and a correctly matched pair in the kernel being resumed.

Raising two points:  (1) for those who think suspend is right, you can
think of it as replacing one of the extra ones with kernel_restart_prepare();
and (2) not very much code interacts with that restart prep, that's a
sane audit problem.


Also, about non-volatile RAM.  Not necessary ... the device hardware holds all
the relevant state.  The problem is that swsusp is now trashing it with those
suspend calls before resuming the real kernel.  On the plus side, we already
have code being used to resolve the identical issue for kexec(), and all my
patch does is to use it.

- Dave



--===============99067583876390342==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============99067583876390342==--
