From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm] swsusp userland interface:
	additional ioctl
Date: Sun, 29 Jan 2006 22:57:26 +0100
Message-ID: <20060129215726.GD2318@elf.ucw.cz>
References: <200601292256.23124.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32155090989145352=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601292256.23124.rjw@sisk.pl>
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
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============32155090989145352==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> The appended patch provides an additional ioctl() for the swsusp userland
> interface that will allow the suspending and/or resuming utilities to change
> the kernel log level at the time of suspend/resume (or even set it to 0 if
> they are going to use some frame buffer graphics etc.).

klogd can already change loglevel... It should be possible to use that
to silence suspend, no?

									Pavel

-- 
Thanks, Sharp!

--===============32155090989145352==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32155090989145352==--
