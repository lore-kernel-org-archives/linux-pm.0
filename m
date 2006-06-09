From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Information in PM messages
Date: Fri, 9 Jun 2006 10:24:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606091018160.16847-100000@netrider.rowland.org>
References: <200606081257.17421.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606081257.17421.david-b@pacbell.net>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, 8 Jun 2006, David Brownell wrote:

> > 	A message whose source is USER or DRIVER should not be
> > 	allowed to resume a device that was suspended by a message
> > 	whose source was SYSTEM.  In other words, runtime PM and
> > 	autoresume should not interfere with a system sleep transition.
> =

> Why wouldn't that be entirely the driver's responsibility, and
> something they don't need API changes to achieve?

Perhaps we don't need to worry about this.

After all, in most cases it's impossible for a device which is suspended
as part of a system-sleep transition to get either a runtime-PM resume or
an autoresume request.  It can only happen in situations where the
system-sleep did not first freeze all tasks.  In those situations people
may agree that it is acceptable for the sleep transition to be aborted by
a user request or an autoresume.

If that is so then yes, we don't need to alter the PM message structures
in this way.

Alan Stern
