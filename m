From: Andrew Morton <akpm@osdl.org>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Mon, 10 Jul 2006 22:56:31 -0700
Message-ID: <20060710225631.f520bca5.akpm@osdl.org>
References: <200607101525.43507.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607101525.43507.david-b@pacbell.net>
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
Cc: torvalds@osdl.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, 10 Jul 2006 15:25:43 -0700
David Brownell <david-b@pacbell.net> wrote:

> Two Models for Device Power Management

Is useful, thanks.  Later on it'd be good to include some pointers to
drivers which do everything right, and which are well-maintained, for people
to crib from.  (Not "skeleton" drivers, IMO - they tend to go out-of-date).

It's all very suspend-the-whole-machine centric.  We don't presently help
that NIC driver to put itself into a low-power state if there's been no net
activity for 100 milliseconds.  I guess that comes later.
