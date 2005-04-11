From: Pavel Machek <pavel@suse.cz>
Subject: Re: Re: freeze_processes questions
Date: Tue, 12 Apr 2005 01:59:07 +0200
Message-ID: <20050411235907.GB2472@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504071549040.1071-100000@ida.rowland.org>
	<200504072303.15502.rjw@sisk.pl> <20050408062306.GB1381@elf.ucw.cz>
	<200504081323.51164.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============33191537892380385=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504081323.51164.rjw@sisk.pl>
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

--===============33191537892380385==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Clearing PF_FREEZE when we fail to stop some process sounds okay to
> > me. It would be nice if the patch was actually tested ;-).
> 
> The patch (against 2.6.12-rc2) follows.  It has been tested, but of course it's difficult to
> recreate every possible scenario. :-)

Applied, modulo some whitespace.
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.

--===============33191537892380385==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============33191537892380385==--
