From: David Brownell <david-b@pacbell.net>
Subject: Re: HCD polling root hub status before controller is
	brought out of suspend
Date: Thu, 4 Nov 2010 16:53:54 -0700 (PDT)
Message-ID: <891479.65425.qm@web180316.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, Maksim Rayskiy <maksim.rayskiy@gmail.com>
List-Id: linux-pm@vger.kernel.org


--- On Thu, 11/4/10, Maksim Rayskiy <maksim.rayskiy@gmail.com> wrote:


I am running into a crash on 2.6.36-rc7 kernel when I am bringing ohci cont=
roller out of suspend. Our suspend gates the clocks, so any access to the o=
hci registers becomes a bus error.

The original model was that the OHCI suspend and
resume methods would gate and un-gate clocks
(respectively).=A0 Don't know if someone changed that;
it can be awkward to enforce on some silicon.


But I'd expect that model would still work.=A0 (It makes no
sense to poll a suspended controller, either...)


- Dave
