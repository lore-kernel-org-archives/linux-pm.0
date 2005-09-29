From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problems with PM_FREEZE
Date: Thu, 29 Sep 2005 11:45:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509291136210.4928-100000@iolanthe.rowland.org>
References: <20050928130301.GA2118@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21488700898228386=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050928130301.GA2118@elf.ucw.cz>
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
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============21488700898228386==
Content-Type: TEXT/PLAIN; charset=US-ASCII

Dave:

Pavel is obviously right that the clean solution is to add a pm_message_t 
argument to resume().

But there might be an easier approach that would help this particular
case.  You changed things so that for USB, PM_EVENT_FREEZE works like a
PM_EVENT_SUSPEND.  But once PM_EVENT_RUNTIME is defined and used by the
/sys/.../power/state attribute, why not do the opposite?  Make USB
PM_EVENT_SUSPEND work like a PM_EVENT_FREEZE -- don't actually suspend any
devices other than the root hub.

That way there would be no difficulty about devices being in the wrong
state when the resumed kernel tries to wake them up.  And it would reduce
the time required for the sleep transition.  Actual power consumption
would not be an issue; when the root hub suspends, all the devices below
it will automatically suspend as well.

Alan Stern


--===============21488700898228386==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21488700898228386==--
