From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Mon, 09 Jul 2007 19:33:56 +1000
Message-ID: <1183973636.5961.37.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707081517540.11049-100000@netrider.rowland.org>
	<200707090847.43378.oliver@neukum.org>
	<1183972420.5961.26.camel@localhost.localdomain>
	<200707091123.57400.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707091123.57400.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-07-09 at 11:23 +0200, Oliver Neukum wrote:
> Suspension is to be transparent. Apart from a jump in the system clock
> user space must not notice, thus returning errors due to suspension is
> not an option.

Who says ?

If I'm talking to a USB printer, it will notice the USB bus being
suspended, believe me. It's actually likely to screw up whatever job is
in progress. It make perfect sense to error out attempts to talk to it
when suspended.

I don't think "transparent" is an absolute requirement. In some cases,
it doesn't make sense and the printer is a good example of that. The
printing daemon is typically something that will ideally need to grow
knowledge about suspend/resume to interrupt things at the right time.

That's one of the thing... we don't even have the kernel right, so we
are light-years from having the rest of userland right.

For example, from a user point of view, what should happen if you
suspend while printing ?

Well, it's a matter of policy (thus should be configurable), but I would
exect (as a former Mac user) something around the lines of this as a
default:

 - If the laptop's clamshell has been closed, it's likely that the
user's just picking up the laptop for a ride, makes sense to abort jobs
in progress.

 - If this is a manual action via the menus, displaying a dialog asking
if you really want to suspend before your page is finished makes sense
(with that dialog disappearing and the machine going to sleep if you
just wait and let it print).

That sort of thing requires much more than just kernel collaboration of
course, but a whole infrastructure in userland as well.

So no, suspend is -not- transparent, doesn't have to be, it's something
that is to be decided on a case-by-case basis (or rather,
driver-per-driver and possibly via policy settings).

Ben.
