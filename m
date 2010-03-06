From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problems with remote-wakeup settings
Date: Fri, 5 Mar 2010 23:16:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003052314130.10381-100000__39409.610318444$1267849056$gmane$org@netrider.rowland.org>
References: <201003052304.49261.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003052304.49261.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: USB list <linux-usb@vger.kernel.org>, linux-hotplug@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 5 Mar 2010, Rafael J. Wysocki wrote:

> On Friday 05 March 2010, Oliver Neukum wrote:
> > Am Freitag, 5. M=E4rz 2010 21:59:31 schrieben Sie:
> > > > I guess it's better if drivers don't set should_wakeup if unsure, b=
ut of course
> > > > that's impossible to enforce.
> > > =

> > > That's the real question.  Ideally, drivers won't touch should_wakeup=
.  =

> > > How do we get there from here?
> > =

> > Enable it only for devices specifically designed for wakeup, that is
> > keyboards, power buttons and WoL, perhaps also mice and modems.
> > Are we far away from that?
> =

> I don't think we're very far from that.
> =

> Mice are known dangerous, especially the USB ones, though.

I agree, especially for desktop systems.  You don't want the system to =

wake up merely because you happened to jostle the mouse.  That happened =

to me just a few days ago (and it was a PS/2 mouse, not USB).

Alan Stern
