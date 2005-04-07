From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 18:09:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0504071803330.1071-100000@ida.rowland.org>
References: <200504072259.56759.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============67710440060346566=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504072259.56759.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============67710440060346566==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 7 Apr 2005, Rafael J. Wysocki wrote:

> During resume, we boot the kernel, check if there's an image to read and
> (if there's one) we freeze processes using the refrigerator (we need to get rid
> of them so that we can restore the image safely).  Then, it seems, on
> some systems, freeze_processes() may be called before all of the compiled-in
> drivers complete their initialization.  In particular, kseriod calls usermodehelper
> at that time, which makes it wait uninterruptibly for a helper process to
> complete.  If that helper process is frozen, we end up with the uninterruptible
> kseriod that we can't freeze and _resume_ fails, which is not nice, especially
> that we don't need to care for this kseriod, as we are going to restore
> the image in a while ...
> 
> Perhaps we should not use the refrigerator during resume, or we could use a
> slightly modified version?  I don't know.

Kernel threads calling (and waiting for!) userspace processes is a very 
difficult problem for suspend.  It comes up in several different places, 
and it doesn't seem to have any easy solution.

It might be best to require that kernel threads should always be
freeze-able when they do this, which in particular implies that they must
not hold any locks.  While that should work, it would create problems for
a number of drivers that use the firmware loader during their probe()  
routine.  There will probably be other similar problems I'm not aware of.

Alan Stern


--===============67710440060346566==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============67710440060346566==--
