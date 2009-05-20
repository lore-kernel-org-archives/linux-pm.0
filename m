From: Surinder P Singh <srplsnh@gmail.com>
Subject: Re: cpuidle C-state accounting
Date: Wed, 20 May 2009 15:06:47 +0530
Message-ID: <f2235a630905200236v29f407dfne77c55165ed94249@mail.gmail.com>
References: <20090519162504.GA26660@linux-foundation.org>
	<13B9B4C6EF24D648824FF11BE8967162038BED6777@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BED6777@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> In code I've used I don't demote other states. =A0But there are state abo=
rts. =A0In those cases residency is low or 0.

Indeed, its the residency=3D0 cases that the patch I sent in my last
mail attempts to fix. The idea being, not to increment
target_state->usage if dev->last_residency was 0, i.e. the state
(whether it was the governor recommended state or  safe_state or any
other state) was  not entered or used.

Cheers,
surinder

P.S Richard, pls ignore my other mail with the same content. I goofed
up & missed your email in my inbox and sent the reply out of context.
This mail should link it back to thread.
