From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 11:33:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606211130350.6700-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.0606210809380.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606210809380.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, 21 Jun 2006, Linus Torvalds wrote:

> So it's quite possible that the _resume_ codepath is to be shared. But I'=
m =

> pretty damn sure that there's absolutely no shared code in the "suspend" =

> path between STD and STR, exactly because they do fundamentally different =

> things, and from fundamentally different levels.

There is one small point they do have in common.  For those systems where =

power doesn't get turned off completely during STD, you will want to =

enable remote wakeup (just as in STR).

Alan Stern
