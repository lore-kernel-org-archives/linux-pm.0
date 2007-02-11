From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] Re: NAK new drivers without proper power
	management?
Date: Sun, 11 Feb 2007 22:04:20 +0100
Message-ID: <45CF84D4.3040305@s5r6.in-berlin.de>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	<200702111450.49736.rjw@sisk.pl> <20070211135708.GC1868@1wt.eu>
	<200702111536.20871.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702111536.20871.rjw@sisk.pl>
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

Rafael J. Wysocki wrote:
> - Problem what to do with drivers that work for some people and don't work
> for the others (ie. if we don't flag them as known good, we will break the
> setups in which they work)

And this issue is independent of whether a driver has .suspend and
.resume or not. For example, ohci1394 had them for ages but they didn't
work as expected before 2.6.20.

What's more, ohci1394's resume routine alone is insufficient; an
additional facility in ieee1394 was necessary and added for 2.6.21(-rc).
This shows that the original authors of ohci1394's .suspend and .resume
didn't test with actual external devices or gave up when they figured
that the problem reaches into upper subsystem layers. (We still haven't
tested interaction with most of the IEEE 1394 high level.)
-- =

Stefan Richter
-=3D=3D=3D=3D=3D-=3D-=3D=3D=3D --=3D- -=3D-=3D=3D
http://arcgraph.de/sr/
