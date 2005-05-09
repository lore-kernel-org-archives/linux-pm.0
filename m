From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2.6.12-rc4] driver model wakeup support
Date: Mon, 9 May 2005 11:57:58 +0200
Message-ID: <20050509095758.GC19790@atrey.karlin.mff.cuni.cz>
References: <200505081724.09468.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4125120831268238=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505081724.09468.david-b@pacbell.net>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============4125120831268238==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

>   * there's a writeable sysfs "wakeup" file, with one of three values:
>       - "enabled", when the policy is to allow wakeup 
>       - "disabled", when the policy is not to allow it
>       - "" (empty string), when the hardware doesn't support wakeup

> It would be preferable to not have the attribute for devices that aren't
> wired with wakeup support, but that'd involve extra sysfs magic.

Yes, not having empty wakeup file might be nice. Or place "<not
supported>" there if we are doing strings anyway.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============4125120831268238==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============4125120831268238==--
