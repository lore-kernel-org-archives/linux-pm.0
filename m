From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend "core": what to do now ?
Date: Tue, 28 Jun 2005 06:58:47 +0200
Message-ID: <20050628045846.GA10735@atrey.karlin.mff.cuni.cz>
References: <1119851395.5133.112.camel@gaston>
	<1119912918.30369.7.camel@localhost.localdomain>
	<1119916159.5133.145.camel@gaston>
	<1119931577.5133.189.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32809823449483755=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1119931577.5133.189.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adam Belay <abelay@novell.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============32809823449483755==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> However, PM_DISK_PLATFORM and PM_DISK_FIRMWARE sort-of abuse the pm_ops
> that I have killed to call into arch code... it's all crap as it exposes
> to all archs some behaviours that may not be supported by those archs.

Feel free to kill PM_DISK_FIRMWARE. PM_DISK_PLATFORM looks like the
"right way" to do swsusp on acpi-enabled systems, so it should stay...

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============32809823449483755==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32809823449483755==--
