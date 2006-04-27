From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Thu, 27 Apr 2006 10:54:47 +0000
Message-ID: <20060427105446.GA2460@ucw.cz>
References: <200604241429.52022.david-b@pacbell.net>
	<200604250832.04065.nigel@suspend2.net>
	<200604250856.06038.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============47956607476370827=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604250856.06038.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============47956607476370827==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > It seems to me that the right solution might be for these usb devices to 
> > treat a resume from a freeze as an indication that hardware should be reset.
> 
> I don't much like that model.  It creates more special cases in drivers (not
> just USB), and redefines the "freeze" thing to be more than just "quiescede".
> Every special case that gets added is a breeding ground for more bugs.
> 
> Also, what about the resume-from-freeze that _every_ device does during swsusp
> suspend?  The kernel is still resuming every device, not just the ones needed
> to write the suspend partition.

It is quite hard to tell which devices are needed for write... Plus
only resuming some drivers would only hide the bugs in drivers not
needed for write, and speedup suspend a tiny bit. Too little benefit
for more complex code, I'd say.
							Pavel
-- 
Thanks, Sharp!

--===============47956607476370827==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============47956607476370827==--
