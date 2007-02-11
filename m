From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Re: NAK new drivers without proper power
	management?
Date: Sun, 11 Feb 2007 17:19:40 +0200
Message-ID: <84144f020702110719i27718657s4c74a4f7217cce6@mail.gmail.com>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	<200702111450.49736.rjw@sisk.pl> <20070211135708.GC1868@1wt.eu>
	<200702111536.20871.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702111536.20871.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Robert Hancock <hancockr@shaw.ca>, Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jeff@garzik.org>, Daniel Barkalow <barkalow@iabervon.org>, pm list <linux-pm@lists.osdl.org>, Willy Tarreau <w@1wt.eu>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2/11/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Unfortunately it has to be done in one shot for all of the known good dri=
vers to avoid
> user-observable regressions.

No you don't. You can make it a config option that defaults to n
during a transition period.
