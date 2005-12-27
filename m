From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Re: Hotplug events during sleep transition
Date: Tue, 27 Dec 2005 16:45:17 -0500
Message-ID: <d120d5000512271345t6e3e0117j7852bd29668d6abe@mail.gmail.com>
References: <200512261750.26186.dtor_core@ameritech.net>
	<Pine.LNX.4.44L0.0512261755280.10595-100000@netrider.rowland.org>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512261755280.10595-100000@netrider.rowland.org>
Content-Disposition: inline
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

On 12/26/05, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 26 Dec 2005, Dmitry Torokhov wrote:
>
> > Device removal could happen at any point, even during suspend transition.
> > The kernel should be able to handle this scenario therefore implementation
> > that assumes that device tree is frozen in flawed. As far as I understand
> > the only thing that does not work at the moment is invoking hotplug handler.
>
> The situation isn't all that bad.
>
> The device tree can be changed only by calling device_add or device_del
> (or the corresponding register/unregister routines).  That can only be
> done in process context; hence if processes are frozen it can't happen.
> Or rather, it can happen only if a suspend() or resume() method tries to
> do it.
>
> If those methods don't try to handle device removal or addition -- which
> in most cases they shouldn't -- then there's nothing to worry about.  It's
> only oddball situations (like calling the remove method when the driver
> doesn't define a suspend method) that cause problems.
>

Hmm, I am confused. What should ->resume() method do when it fails to
resume a device? I would say kill it, espacially if it is bus-generic
method. How else would we clean up after removed devices? And here we
have a problem because swsuspend likes to resume all devices before
writing the image and drivers don't rellay know if they are woken up
for real or just to complete suspend transition.

> And even then, with most drivers you don't get a hotplug event when the
> driver is unbound.  It happens only with things like usb-storage, that
> define child devices.
>

No, I'd say most drivers generate hotplug events because most of them
create/destroy class devices nowadays.

--
Dmitry
