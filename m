From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: Alternative Concept
Date: Thu, 15 Mar 2007 12:33:44 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274298F4157@dlee13.ent.ti.com>
References: Igor Stoppa's message of Thu, 15 Mar 2007 15:04:49 +0200
	<200703151400.l2FE0GhR004563@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <200703151400.l2FE0GhR004563@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Scott E. Preece" <preece@motorola.com>, igor.stoppa@nokia.com
Cc: linux-pm@lists.osdl.org, pavel@ucw.cz, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

> If you did it this way:
> =

> tid1 =3D power_transaction_start();
> clk_set_rate_pending(clk1, 300, tid1);
> clk_set_rate_pending(clk1, 600, tid1);
> power_transaction_commit(tid1);

You could do it in the way above or you can do it with virtual clocks
which allow grouped changes.

In the OMAP2 implementation this is currently hidden.  You can define a
virtual clock which encompasses several key root dividers.  Generally
for this type of change a pre-scale notifier goes out to registered
drivers.  That sequencing code does a clk_set_rate() against that
virtual clock.  The code internally sets up then jumps to SRAM and does
any associated voltage shift along with the multi-divider change.  On
the way back from SRAM the rate change propagates to update all child
nodes.  Finally a post scale happens.  The hardware does give some
assistance with a buffer for key clock groups.

Most simple clocks don't go through this process.

Doing a series of clk_round_rates() before doing your clk_set_rate() to
find available speeds given a certain parent allows you to adjust to
local needs like what a LCD panels end pixel clock divider needs to be
as bounded by panel specs.

The clk api is pretty useful.  Nothing says it can't be expanded or
absorbed.  Right now keeping api's like round/set available is good.

Regards,
Richard W.  =
