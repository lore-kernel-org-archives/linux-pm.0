From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 25 Jun 2006 12:35:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606251227210.26740-100000@netrider.rowland.org>
References: <Pine.LNX.4.64.0606241929340.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606241929340.6483@g5.osdl.org>
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

On Sat, 24 Jun 2006, Linus Torvalds wrote:

> On Sat, 24 Jun 2006, Alan Stern wrote:
> > =

> > Is this an okay place to point out that after resume-from-disk, the i80=
42
> > keyboard auto-repeat rate settings are messed up?
> =

> Does this fix it for you?
> =

> (Totally untested - I don't have PS/2 keyboards any more on the machines =
I =

> actually use..)

I tried it and it works well.  I will submit a version of this patch to =

Andrew (there's a comment that should be updated along with the changes to =

the code).

Alan Stern
