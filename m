From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 11:09:15 +0200
Message-ID: <20050407090915.GA1541@elf.ucw.cz>
References: <200504051120.44496.rjw@sisk.pl> <20050405225751.GA1353@elf.ucw.cz>
	<1112742641.3757.58.camel@desktop.cunningham.myip.net.au>
	<200504061434.34050.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81546357537658909=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504061434.34050.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: ncunningham@cyclades.com, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============81546357537658909==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > In this way, I handle kseriod and anything else uninterruptible without
> > any problems.
> 
> This may be off-topic for this thread ... but does anyone
> have system wakeup from PS/2 keyboard/mouse working?

It worked for me from PS/2 keyboard... I did not set up anything on
linux side, I just enabled it with bios. It worked okay with both
ACPI/S3 and swsusp...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============81546357537658909==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============81546357537658909==--
