From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: freeze_processes questions
Date: Fri, 8 Apr 2005 08:20:10 +0200
Message-ID: <20050408062010.GA1381@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504071549040.1071-100000@ida.rowland.org>
	<200504072259.56759.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============98525304216669363=="
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
Cc: linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@cyclades.com>
List-Id: linux-pm@vger.kernel.org

--===============98525304216669363==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > It seems that if a process calls wait_for_completion() right before suspend,
> > > the other task supposed to complete its completion may be accidentally frozen
> > > before it's able to do this.  It looks like this happens to kseroid sometimes
> > > on suspend-during-resume.
> > 
> > You mean, when a suspend occurs so soon after a resume that the resume has 
> > fully completed yet?
> 
> No.
> 
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

As we allow resume to be called from userland, other refrigerator is
not really an option. We could insert mdelay before resume, or some
equivalent trick...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============98525304216669363==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============98525304216669363==--
