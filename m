From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Wed, 28 Dec 2005 21:07:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512282103010.3218-100000@netrider.rowland.org>
References: <d120d5000512271345t6e3e0117j7852bd29668d6abe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12828949486641106=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <d120d5000512271345t6e3e0117j7852bd29668d6abe@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: dtor_core@ameritech.net
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============12828949486641106==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 27 Dec 2005, Dmitry Torokhov wrote:

> Hmm, I am confused. What should ->resume() method do when it fails to
> resume a device? I would say kill it, espacially if it is bus-generic
> method. How else would we clean up after removed devices? And here we
> have a problem because swsuspend likes to resume all devices before
> writing the image and drivers don't rellay know if they are woken up
> for real or just to complete suspend transition.

If resume fails to resume a device, it should return a negative error 
code.  It should not try to unregister the device; that action belongs to 
a different pathway.

Cleaning up after removed devices should be handled the same way as we 
already do it -- that is, totally separate from suspend/resume.

As for swsuspend resuming devices in order to write the image...  I don't
know how it currently handles a resume failure.  Offhand it's not clear
what could be done about a failure anyway.  Probably resume failures at
this point should simply be ignored.

Alan Stern


--===============12828949486641106==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============12828949486641106==--
