From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 19:16:53 -0700
Message-ID: <200606211916.53490.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211422450.8272-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606211345150.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606211345150.5498@g5.osdl.org>
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 June 2006 1:49 pm, Linus Torvalds wrote:
> =

> > There's an unforunate asymmetry in the design.
> =

> I don't know why people harp on symmetry so much.

Just that it's _typically_ a source of errors ... because most people
don't have very complete mental models, and (often unknowingly) rely
on symmetry to fill in gaps.  To the extent they may not even be aware
such gaps exist.

It's better to have such basic cognitive mechanisms working in your
favor (by preferring symmetric designs, vocabulary, framing) then
against (asymmetric, ditto).

- Dave
