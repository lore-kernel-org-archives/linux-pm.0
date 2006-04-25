From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 09:11:54 -0700
Message-ID: <200604250911.54951.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200604250832.04065.nigel@suspend2.net>
	<200604251032.57204.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73164841230323208=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604251032.57204.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============73164841230323208==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 25 April 2006 1:32 am, Rafael J. Wysocki wrote:

> > just want things quiesced, mainly because we don't want to spin down drives.
> 
> That's right.  And kernel_restart_prepare(NULL) will make them spin down?
> If so, they have to be treated in a special way.

Seems every time that someone turns up one of the problems with this "freeze"
thing, the same responses come back:  "we can't fix that because we don't want
to spin down drives".

I've begun thinking that calls like pm_should_I_spin_down_drives() would be a
better structural approach than continually redefining this "freeze" thing so
it makes less and less sense to all other drivers ... who nonethless need to
clutter themselves up with a growing list of special cases, to accomodate
rotating media that may not even exist in the target system.


> OTOH I think at least some device driver writers assume that .resume() will
> always be called after .suspend() which only is true for non-modular drivers
> (or for modular drivers loaded from an initrd before resume). 

Say what?  Of _course_ resume() should only be called after suspend().  If
that's not true in any case, the code wrongly issuing the resume() is buggy.

I don't see where you're collecting that list of special cases.  It doesn't
match what I've observed ... and even if it were correct, I'd say that's yet
another case where special casing reflects bugs.

- Dave

  

--===============73164841230323208==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73164841230323208==--
