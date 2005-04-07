From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 10:41:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0504071039550.989-100000@ida.rowland.org>
References: <200504070041.46418.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============22854542889418705=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504070041.46418.rjw@sisk.pl>
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
Cc: ncunningham@cyclades.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============22854542889418705==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 7 Apr 2005, Rafael J. Wysocki wrote:

> Well, (having thought about it for a while) why, actually, a device's _suspend()
> routine would need such a lock?  Devices are suspended on one CPU in
> a single thread which can only (potentially) race with interrupt handlers ...

You're blinded by thinking that suspend() can be called only during a 
system sleep transition.  Don't forget about runtime power management!

Alan Stern


--===============22854542889418705==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============22854542889418705==--
