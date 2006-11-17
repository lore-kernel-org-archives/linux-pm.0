From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] convert pm_sem to a mutex
Date: Fri, 17 Nov 2006 20:15:54 +0100
Message-ID: <20061117191554.GB19101@elte.hu>
References: <20061117111308.5dbaa60e@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061117111308.5dbaa60e@freekitty>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Linus Torvalds <torvalds@osdl.org>
List-Id: linux-pm@vger.kernel.org


* Stephen Hemminger <shemminger@osdl.org> wrote:

> The power management semaphore is only used as mutex, so convert it.
> =

> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

looks good to me.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
