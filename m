From: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp3: system suspend/resume from userspace
Date: Wed, 21 Sep 2005 12:18:11 +0200
Message-ID: <20050921101811.GC25297@atrey.karlin.mff.cuni.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8E51@hdsmsx401.amr.corp.intel.com>
	<20050901201714.GA2027@openzaurus.ucw.cz>
	<1127259699.4386.82.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============19651586211741767=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1127259699.4386.82.camel@gaston>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

--===============19651586211741767==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > shrink kernel a bit at the same time.
> > > 
> > > got numbers (or predicted numbers)?
> > 
> > 30-50% of swsusp.c deals with swap writing, and with swsusp3, they could
> > be removed.  Of course, removal would take some time before people install userland
> > "write image" programs.
> 
> I have trouble understanding how you can make that work without all sort
> of interesting races though... 

I still do my "userspace freezing", except that it does not freeze the
process doing that. (Thats no change from previous design,
BTW). System snapshot works single CPU and with interrupts disabled;
so it indeed should be atomic. That should mean there are no
interesting races, as long as userspace app is not doing anything
stupid.

Userland application is currently simple port of kernel swsusp.c into
userspace, so it should not do anything stupid...

							Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============19651586211741767==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============19651586211741767==--
