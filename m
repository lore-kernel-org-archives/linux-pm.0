From: Alan Stern <stern@rowland.harvard.edu>
Subject: Hotplug events during sleep transition
Date: Thu, 22 Dec 2005 09:28:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512220920500.10513-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86171487070388142=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============86171487070388142==
Content-Type: TEXT/PLAIN; charset=US-ASCII

Pavel & Greg:

I recently worked on a patch to unbind USB drivers that don't have 
suspend/resume methods, and then rebind them when the system comes back 
up.  There was an unexpected effect: In some cases the unbind or rebind 
operations caused hotplug events, which started up new user processes at a 
time when everything was supposed to be frozen.  Obviously this is not a 
good thing.

Is there some other way these sorts of events can be handled?  For
instance, can the hotplug system be smart enough to delay creating the new
processes?  Or can they be created already in a frozen state?

Alan Stern


--===============86171487070388142==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86171487070388142==--
