From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 30 Dec 2005 13:26:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512301323000.32015-100000@netrider.rowland.org>
References: <200512290020.16246.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============93462826795787302=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200512290020.16246.dtor_core@ameritech.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============93462826795787302==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 29 Dec 2005, Dmitry Torokhov wrote:

> > Why do you need a new cleanup thread?  What's wrong with the existing 
> > strategy for handling removed devices -- i.e., the procedure that would 
> > have been followed if there was no suspend/resume transition?
> > 
> 
> Sometimes there is no such procedure. For example if you yank PS/2 mouse
> there is no way for the system to detect it's missing. Only when you try
> to resume and mouse does not respond you realize it's gone. I bet there
> are other devices like that. 

There may indeed be other devices like that.  If you can't handle device 
removal while the system is running normally, why should you be able to 
handle device removal while the system is suspended?

Conversely, even if the resume routine does detect somehow that the device 
was removed, there's nothing it can do with that information if you don't 
have a mechanism in place for handling device removals.

Alan Stern


--===============93462826795787302==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============93462826795787302==--
