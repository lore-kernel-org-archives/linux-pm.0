From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Re: Hotplug events during sleep transition
Date: Thu, 22 Dec 2005 19:49:28 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512221947250.23983-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0512221703280.17705-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4034880909494083=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512221703280.17705-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============4034880909494083==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 22 Dec 2005, Alan Stern wrote:

> I'm not so sure this approach really qualifies as a "hack".  If a driver
> doesn't have explicit support for suspend/resume, the best way to quiesce
> it is to unbind it.  The only alternative is to fail all of its I/O
> requests, which seems much less reliable.

Hmm, the best way to queisce it seems to be to fix the driver. Sure, that
doesn't solve your problems now, but that is the ideal solution, no? Until
then, band-aids like unbinding the device from the driver is only a remedy
to a symptom; not a cure..


	Patrick

--===============4034880909494083==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============4034880909494083==--
