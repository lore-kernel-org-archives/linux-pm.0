From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [RFD] swsusp problem: Drivers allocate much memory
	during suspend
Date: Fri, 13 Apr 2007 17:40:53 -0400
Message-ID: <461FF8E5.7010202@redhat.com>
References: <460B6E4B.3060004@gmail.com> <200704131400.12021.rjw@sisk.pl>
	<1176466896.7112.159.camel@nigel.suspend2.net>
	<200704132241.52725.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704132241.52725.rjw@sisk.pl>
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
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org, Jiri Slaby <jirislaby@gmail.com>, Pavel Machek <pavel@ucw.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> =

> IMO to really fix the problem, we should let the drivers that need much m=
emory
> for suspending allocate it _before_ the memory shrinker is called.  For t=
his
> purpose we can use notifiers that will be called before we start the shri=
nking
> of memory.  Namely, if a driver needs to allocate substantial amount of m=
emory
> for suspending, it can register a notifier that will be called before we =
try to
> shrink memory.  Then, the memory needed by the driver may be allocated in
> this notifier (of course, in that case it will also have to be called if =
the
> shrinking of memory fails, so that the memory allocated by the driver for
> suspending can be freed) and used in the driver's .suspend() routine.
> =


Can't you just put a "prepare to suspend" function pointer in the
bus_type and device_driver structs?
