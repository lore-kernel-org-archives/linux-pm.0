From: Jim Gettys <jg@laptop.org>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 07:56:46 -0400
Message-ID: <1174564606.4935.6.camel@localhost>
References: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
	<200703220042.20471.lenb@kernel.org>
Reply-To: jg@laptop.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703220042.20471.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2007-03-22 at 00:42 -0400, Len Brown wrote:

> Today on system suspend we suspend all devices.
> Today on system resume, we resume all devices.
> In the future we need to recognize that upon system suspend,
> some devices are already suspended.
> We need to remember that, so upon resume we can restove
> them to their suspended state, rather than blindly resuming everything.

On system suspend, we may not want to suspend all devices; we may need
to leave certain devices alone, and only power down the host interface
to them.

Upon system resume, therefore, devices may also *not* need to be
resumed; only the host interface to them powered up again.

We have two devices in the OLPC machine in this class: our screen, and
our wireless, both of which will often/usually be left on while the rest
of the sysetm is suspended.
                                          - Jim


-- =

Jim Gettys
One Laptop Per Child
