From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: freeze_processes questions
Date: Wed, 6 Apr 2005 14:34:33 -0700
Message-ID: <200504061434.34050.david-b@pacbell.net>
References: <200504051120.44496.rjw@sisk.pl> <20050405225751.GA1353@elf.ucw.cz>
	<1112742641.3757.58.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26108951925945245=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1112742641.3757.58.camel@desktop.cunningham.myip.net.au>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org, ncunningham@cyclades.com
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============26108951925945245==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 05 April 2005 4:10 pm, Nigel Cunningham wrote:
> 
> In this way, I handle kseriod and anything else uninterruptible without
> any problems.

This may be off-topic for this thread ... but does anyone
have system wakeup from PS/2 keyboard/mouse working?

Last time I tried to use it, it didn't work.  Not clear where
the problem was, but I suspect it was a case of ACPI support
not having anything to hook up to in the driver.

Hence the (potential) relevance on this thread:  the current
approach to suspend/resume in serio drivers needing updating,
which may interact with how kseriod is used.

- Dave

  

--===============26108951925945245==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26108951925945245==--
