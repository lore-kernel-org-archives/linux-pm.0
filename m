From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Use of parallel init threads for slow devices start ups?
Date: Mon, 19 Feb 2007 11:50:38 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274295B9D66@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pm list <linux-pm@lists.osdl.org>
Cc: "Reddy, Teerth" <teerth@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi,

While doing some startup time profiling it is noticed we spend a lot of
time in the idle loop.  As there is only one thread initializing devices
there is no one to schedule during device start ups.  So for example an
external sensor might need a couple seconds to power up.

Does anyone want to give an opinion on forking off a parallel thread to
handle slower devices which are not dependent?

The init could be deferred but you still need to eat the wait time.  Its
nicest if a few devices can be doing their waiting at the same time.

This is true for boot time and for device resume time...

Regards,
Richard W.
